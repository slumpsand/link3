SHELL := /bin/bash

I := $(shell tput setaf 3 && tput bold)
C := $(shell tput sgr0)

build:
	@echo "$(I)(01) building main application ...$(C)"
	tsc src/*.ts --outDir ./
	@echo "$(I)(02) building executables ...$(C)"
	test -d bin/ || mkdir bin/
	tsc src/bin/*.ts --outDir bin/
	for f in bin/*.js ; do mv $$f $${f%.js} ; done
	chmod +x bin/*
