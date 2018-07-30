[![Codacy Badge](https://api.codacy.com/project/badge/Grade/e6e9a17f8190438e83874c1b3f7cb62f)](https://www.codacy.com/app/Codacy/codacy-shellcheck?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=codacy/codacy-shellcheck&amp;utm_campaign=Badge_Grade)
[![Build Status](https://circleci.com/gh/codacy/codacy-shellcheck.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/codacy/codacy-shellcheck)

# Codacy ShellCheck

Create the docker: `sbt docker:publishLocal`

The docker is supposed to be run with the following command:

```sh
docker run -it - $srcDir:/src  <DOCKER_NAME>:<DOCKER_VERSION>
```

and $srcDir must contain a valid `.codacy.json` configuration

## Docs

[Docker Docs](https://support.codacy.com/hc/en-us/articles/207994725-Tool-Developer-Guide)

[Scala Docker Template Docs](https://support.codacy.com/hc/en-us/articles/207280379-Tool-Developer-Guide-Using-Scala)

## Test

Follow the instructions at [codacy-plugins-test](https://github.com/codacy/codacy-plugins-test/blob/master/README.md#test-definition)

## Generating the documentation

Update the `VERSION` variable and run:

```bash
cd docs
./generate.sh
```

This will create updated `patterns.json`, `description.json` and the individual documentation Markdown files.

## What is Codacy?

[Codacy](https://www.codacy.com/) is an Automated Code Review Tool that monitors your technical debt, helps you improve your code quality, teaches best practices to your developers, and helps you save time in Code Reviews.

### Among Codacy’s features:

- Identify new Static Analysis issues
- Commit and Pull Request Analysis with GitHub, BitBucket/Stash, GitLab (and also direct git repositories)
- Auto-comments on Commits and Pull Requests
- Integrations with Slack, HipChat, Jira, YouTrack
- Track issues in Code Style, Security, Error Proneness, Performance, Unused Code and other categories

Codacy also helps keep track of Code Coverage, Code Duplication, and Code Complexity.

Codacy supports PHP, Python, Ruby, Java, JavaScript, and Scala, among others.

### Free for Open Source

Codacy is free for Open Source projects.

## License

Licensed under the Apache License, Version 2.0.
