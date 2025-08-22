#!/usr/bin/env bash

# lint this repo
shellcheck --shell=bash --external-sources \
	bin/* --source-path=lib/ \
	lib/* \
	scripts/*

shfmt --language-dialect bash --diff \
	bin/* \
	lib/*.bash \
	scripts/*.bash
