package codacy

import com.codacy.tools.scala.seed.DockerEngine
import codacy.shellcheck.ShellCheck

object Engine extends DockerEngine(ShellCheck)()
