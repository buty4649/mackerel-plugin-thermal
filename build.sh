#!/bin/bash

GOLANG_VERSION=1.23.1
NAME=mackerel-plugin-thermal

docker run -i --rm -v $(pwd):/go/$NAME -w /go/$NAME golang:$GOLANG_VERSION bash <<EOS
set -x
go install github.com/Songmu/goxz/cmd/goxz@latest
go mod tidy

# see. https://tech.mfkessai.co.jp/2023/07/vcs-stamping-error/
git config --global --add safe.directory \$(pwd)

goxz -z -os linux -arch amd64,arm64
EOS
