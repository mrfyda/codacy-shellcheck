FROM koalaman/shellcheck-alpine:v0.5.0 AS build

FROM openjdk:8-jre-alpine
LABEL maintainer="Rafael Cortes <mrfyda@gmail.com>"
COPY --from=build /bin/shellcheck /bin
CMD shellcheck
