SHELL := /bin/bash

B := $(shell tput setaf 3 && tput bold)
C := $(shell tput sgr0)

build:
	@echo "$(B)(01) building typescript files ...$(C)"
	@tsc
	@echo "$(B)(02) moving stuff around ...$(C)"
	@mv src/*.js .
	@test -d bin || mkdir bin
	@for f in src/bin/*.js; do f=`basename $$f` && mv src/bin/$$f bin/$${f%.js}; done
	@chmod +x bin/*
