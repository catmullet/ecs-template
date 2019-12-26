.PHONY: build clean vendor get.yml build.example

build.example:
	env GOOS=linux go build -ldflags="-s -w" -o bin/example main.go

get.yml:
	envi yml --id example

build: clean build.example

clean:
	rm -rf ./bin

vendor:
	go mod tidy
	go mod vendor
