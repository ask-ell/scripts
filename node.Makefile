ASKELL_MAKEFILE_VERSION := "0.0.1"

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
build: .env
	npm run build
	mkdir -p build
	date > build/last_build

build/last_build:
	@make build

.PHONY: serve
serve: .env node_modules/last_install
	npm run start:dev

.PHONY: test
test: node_modules/last_install
	npm run test
	npm run test:e2e

.PHONY: test-watch
test-watch: node_modules/last_install
	npm run test:watch
