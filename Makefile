SHELL := /bin/bash
VERSION := 3.0.0

ARCH := $(shell uname -p)

INSTALL_DIR ?= dist
BUILD_DIR ?= $(shell mktemp -d)

BUILD_DIR := $(BUILD_DIR)/link3-$(VERSION)_$(ARCH)
INSTALL_FILE := $(INSTALL_DIR)/link3-$(VERSION)_$(ARCH).tar.gz

B := $(shell tput setaf 3 && tput bold)
C := $(shell tput sgr0)

# build the application into build/
build:
	@echo "$(B)--- building into '$(BUILD_DIR)' ...$(C)"
	@mkdir -p $(BUILD_DIR)

	@echo "$(B)(B-01) building server ...$(C)"
	@tsc --outDir=$(BUILD_DIR)/server --project src/server/tsconfig.json

	@echo "$(B)(B-02) bulding client ...$(C)"
	@tsc --outDir=$(BUILD_DIR)/client --project src/client/tsconfig.json

	@echo "$(B)(B-03) building executables ...$(C)"
	@tsc --outFile=$(BUILD_DIR)/bin/www --project src/bin/tsconfig.json
	@chmod +x $(BUILD_DIR)/bin/www

	@echo "$(B)(B-04) copying build files ...$(C)"
	@cp -R package.json build/* $(BUILD_DIR)/

	@echo "$(B)(B-05) installing npm modules ...$(C)"
	@cd $(BUILD_DIR) && npm install

	@echo "$(B)--- build complete$(C)"

# create a .tar.gz package
dist:
	@echo "$(B)--- packaging into '$(INSTALL_FILE)' ...$(C)"
	@mkdir -p $(INSTALL_DIR)

	@echo "$(B)(D-01) zipping package ...$(C)"
	@tar -czf $(INSTALL_FILE) $(BUILD_DIR)/

	@echo "$(B)--- packaging complete ...$(C)"

.PHONY: build dist
