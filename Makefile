M = $(shell printf "\033[34;1m▶\033[0m")

.DEFAULT:
all: tools build

.PHONY:
tools: ytt

bin:
	@mkdir -p bin

.PHONY:
ytt: bin/ytt

bin/ytt: bin ; $(info $(M) Installing ytt...)
	@set -o errexit; \
	curl -s https://api.github.com/repos/k14s/ytt/releases/latest | \
	    jq --raw-output '.assets[] | select(.name == "ytt-linux-amd64") | .browser_download_url' | \
	    xargs curl -Lfo ./bin/ytt; \
	chmod +x ./bin/ytt

.PHONY:
build: bin/ytt
	@docker build --tag nicholasdille/flux:1.19.0 . \
	docker push nicholasdille/flux:1.19.0
