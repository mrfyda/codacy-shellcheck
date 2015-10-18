package codacy.shellcheck

import java.nio.file.Path
import codacy.dockerApi._
import codacy.dockerApi.utils.CommandRunner
import play.api.libs.json._
import seedtools.{FileHelper, ToolHelper}
import scala.util.Try

case class ShellCheckResult(file: String, line: Int, column: Int, level: String, code: Int, message: String)

object ShellCheckResult {
  implicit val shellCheckResult = Json.format[ShellCheckResult]
}

object ShellCheck extends Tool {

  override def apply(path: Path, conf: Option[Seq[PatternDef]], files: Option[Set[Path]])(implicit spec: Spec): Try[Iterable[Result]] = {
    Try {
      val filesToLint: Seq[String] = files.fold(Seq(path.toString)) {
        paths =>
          paths.map(_.toString).toSeq
      }

      val command = Seq("shellcheck", "-f", "json") ++ filesToLint

      CommandRunner.exec(command) match {
        case Right(resultFromTool) =>
          val patternsToLint = ToolHelper.getPatternsToLint(conf)
          parseToolResult(resultFromTool.stdout, path, patternsToLint)
        case Left(failure) => throw failure
      }
    }
  }

  def parseToolResult(resultFromTool: Seq[String], path: Path, patterns: Seq[PatternDef]): Seq[Result] = {
    Json.parse(resultFromTool.mkString).asOpt[Seq[ShellCheckResult]].map {
      result =>
        result.collect {
          case shellCheckResult if patterns.map(_.patternId.value).contains(s"SC${shellCheckResult.code}") =>
            Issue(
              SourcePath(FileHelper.stripPath(shellCheckResult.file, path.toString)),
              ResultMessage(shellCheckResult.message),
              PatternId(s"SC${shellCheckResult.code}"),
              ResultLine(shellCheckResult.line))
        }
    }
  }.getOrElse(Seq.empty)

}
