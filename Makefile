I := $(shell tput setaf 3 && tput bold)
C := $(shell tput sgr0)

build:
	@echo "$(I)building main application ...$(C)"
	tsc src/*.ts --outDir ./
	@echo "$(I)building executables ...$(C)"
	tsc src/bin/*.ts --outDir bin/
	for f in bin/*.js; do mv $f ${f%.js}; done
	chmod +x bin/*
