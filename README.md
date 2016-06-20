[![Build Status](https://circleci.com/gh/codacy/codacy-shellcheck.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/codacy/codacy-shellcheck)

create the docker: sbt docker:publishLocal

the docker is supposed to be run with the following command:

```
docker run -it -v $srcDir:/src  <DOCKER_NAME>:<DOCKER_VERSION>
```

and $srcDir must contain a valid .codacy.json configuration

## Docs

[Docker Docs](https://support.codacy.com/hc/en-us/articles/207994725-Tool-Developer-Guide)

[Scala Docker Template Docs](https://support.codacy.com/hc/en-us/articles/207280379-Tool-Developer-Guide-Using-Scala)

## Test

Follow the instructions at [codacy-plugins-test](https://github.com/codacy/codacy-plugins-test/blob/master/README.md#test-definition)
