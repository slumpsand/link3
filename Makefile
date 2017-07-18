SHELL := /bin/bash
VERSION := 3.0.0

ARCH := $(shell uname -p)

INSTALL_DIR ?= dist
BUILD_DIR ?= $(shell mktemp -d -t link3.XXXXXX)

BUILD_DIR := $(BUILD_DIR)/link3-$(VERSION)_$(ARCH)
INSTALL_FILE := $(INSTALL_DIR)/link3-$(VERSION)_$(ARCH).tar.gz

B := $(shell tput setaf 3 && tput bold)
C := $(shell tput sgr0)

# build the application into BUILD_DIR
build: _build
	@echo "$(B)--- build complete$(C)"

# build the application and zip it.
dist: _build
	@echo "$(B)(05) zipping package ...$(C)"
	@tar -czPf $(INSTALL_FILE) $(BUILD_DIR)
	@echo "$(B)--- build complete, package: '$(INSTALL_FILE)'$(C)"

# build the application into build/
_build:
	@echo "$(B)--- building into '$(BUILD_DIR)' ...$(C)"
	@mkdir -p $(BUILD_DIR) $(INSTALL_DIR)

	@echo "$(B)(01) building typescript ...$(C)"
	@tsc --project tsconfig.json --outDir $(BUILD_DIR)

	@echo "$(B)(02) moving stuff around ...$(C)"
	@for f in $(BUILD_DIR)/bin/*.js; do chmod +x $$f && mv $$f $${f%.js}; done

	@echo "$(B)(03) copying build files ...$(C)"
	@cp -R package.json build/* $(BUILD_DIR)/

	@echo "$(B)(04) installing npm modules ...$(C)"
	@cd $(BUILD_DIR) && npm install --production --silent > /dev/null

.PHONY: build dist
