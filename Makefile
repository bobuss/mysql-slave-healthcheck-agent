GIT_VER := $(shell git describe --tags)
OS := linux
ARCH := amd64

all:
	go get github.com/fujiwara/mysql-slave-healthcheck-agent

build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o "pkg/mysql-slave-check" -ldflags '-d -w -s' main.go

package: build
	cd pkg && find . -name "mysql-slave-check" -type f -exec zip mysql-slave-check-${GIT_VER}-${OS}-${ARCH}.zip {} \;

clean:
	rm -f pkg/*
