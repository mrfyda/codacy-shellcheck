import com.typesafe.sbt.packager.docker.{Cmd, ExecCmd}

organization := "codacy"

name := "codacy-shellcheck"

version := "1.0.0-SNAPSHOT"

val languageVersion = "2.12.9"

scalaVersion := languageVersion

resolvers ++= Seq(
  "Sonatype OSS Snapshots".at("https://oss.sonatype.org/content/repositories/releases"),
  "Typesafe Repo".at("http://repo.typesafe.com/typesafe/releases/")
)

libraryDependencies ++= Seq("com.codacy" %% "codacy-engine-scala-seed" % "3.0.296" withSources ())

enablePlugins(AshScriptPlugin)

enablePlugins(DockerPlugin)

version in Docker := "1.0"

mappings in Universal ++= {
  (resourceDirectory in Compile) map { (resourceDir: File) =>
    val src = resourceDir / "docs"
    val dest = "/docs"

    for {
      path <- src.allPaths.get if !path.isDirectory
    } yield path -> path.toString.replaceFirst(src.toString, dest)
  }
}.value

val dockerUser = "docker"
val dockerGroup = "docker"

daemonUser in Docker := dockerUser

daemonGroup in Docker := dockerGroup

dockerBaseImage := s"codacy/alpine-jre-shellcheck"

dockerCommands := dockerCommands.value.flatMap {
  case cmd @ Cmd("ADD", _) =>
    List(Cmd("RUN", s"adduser -u 2004 -D $dockerUser"), cmd, Cmd("RUN", "mv /opt/docker/docs /docs"))
  case other => List(other)
}
