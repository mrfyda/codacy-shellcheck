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

      val patternsToLint = ToolHelper.getPatternsToLint(conf)
      val configuration = Seq()// Seq("-c", writeConfigFile(patternsToLint))

      val command = Seq("shellcheck", "-f", "json") ++ configuration ++ filesToLint

      CommandRunner.exec(command) match {
        case Right(resultFromTool) =>
          parseToolResult(resultFromTool.stdout, path)
        case Left(failure) => throw failure
      }
    }
  }

/*  def extractIssuesAndErrors(filePath: String, messages: Option[JsArray])(implicit basePath: String): Seq[Result] = {
    messages.map(
      messagesArr =>
        messagesArr.value.flatMap {
          message =>
              val path = SourcePath(FileHelper.stripPath(filePath, basePath))
              val msg = (message \ "message").asOpt[String].getOrElse("Fatal Error")
              val patternId = PatternId("fatal")
              val line = ResultLine((message \ "line").asOpt[Int].getOrElse(1))

              val fileError = FileError(path, Some(ErrorMessage(msg)))
              val issue = Issue(path, ResultMessage(msg), patternId, line)

              Seq(fileError, issue)
        }
    ).getOrElse(Seq())
  }*/

  def resultFromToolResult(toolResult: JsArray)(implicit basePath: String): Seq[Result] = {
    toolResult.value.flatMap {
      result =>
        result.asOpt[ShellCheckResult].map {
          shellCheckResult =>
            Issue(SourcePath(FileHelper.stripPath(shellCheckResult.file, basePath)), ResultMessage(shellCheckResult.message), PatternId(shellCheckResult.code.toString), ResultLine(shellCheckResult.line))
        }
    }
  }

  def parseToolResult(resultFromTool: Seq[String], path: Path): Iterable[Result] = {
    implicit val basePath = path.toString

    val jsonParsed = Json.parse(resultFromTool.mkString)
    jsonParsed.asOpt[JsArray].fold(Seq[Result]())(resultFromToolResult)
  }

}