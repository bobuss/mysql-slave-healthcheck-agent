GIT_VER := $(shell git describe --tags)
OS := linux
ARCH := amd64

all:
	go get github.com/fujiwara/mysql-slave-healthcheck-agent

build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o "pkg/mysql-check-${GIT_VER}-${OS}-${ARCH}" -ldflags '-d -w -s' main.go

package: build
	cd pkg && find . -name "*${GIT_VER}*" -type f -exec zip {}.zip {} \;

clean:
	rm -f pkg/*
