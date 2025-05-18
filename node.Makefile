ASKELL_MAKEFILE_VERSION := "0.0.2"

.PHONY: help
help:
	curl https://raw.githubusercontent.com/ask-ell/scripts/refs/heads/develop/makefile.help.sh | bash "$(MAKEFILE_LIST)"

.PHONY: reload-makefile
reload-makefile:
	curl -o Makefile https://raw.githubusercontent.com/ask-ell/scripts/refs/heads/develop/node.Makefile

.env:
	cp .env.sample .env

.PHONY: install
install:
	npm install
	date > node_modules/last_install

node_modules/last_install:
	@make install

.PHONY: build
build:
	npm run build
	mkdir -p build
	date > build/last_build

build/last_build:
	@make build

.PHONY: serve
serve: .env node_modules/last_install
	npm run start:dev

.PHONY: format
format:
	npm run format

.PHONY: lint
lint:
	npm run lint

.PHONY: test
test: node_modules/last_install
	npm run test

.PHONY: test-watch
test-watch: node_modules/last_install
	npm run test:watch
