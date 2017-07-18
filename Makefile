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
	@mkdir -p $(BUILD_DIR) $(INSTALL_DIR)

	@echo "$(B)(01) building server ...$(C)"
	@tsc --outDir $(BUILD_DIR)/server --project src/server/tsconfig.json

	@echo "$(B)(02) bulding client ...$(C)"
	@tsc --outDir $(BUILD_DIR)/client --project src/client/tsconfig.json

	@echo "$(B)(03) building executables ...$(C)"
	@tsc --outFile $(BUILD_DIR)/bin/www --project src/bin/tsconfig.json
	@chmod +x $(BUILD_DIR)/bin/www

	@echo "$(B)(04) copying build files ...$(C)"
	@cp -R package.json build/* $(BUILD_DIR)/

	@echo "$(B)(05) installing npm modules ...$(C)"
	@cd $(BUILD_DIR) && npm install --production --silent > /dev/null

	@echo "$(B)(06) zipping package ...$(C)"
	@tar -czPf $(INSTALL_FILE) $(BUILD_DIR)

	@echo "$(B)--- build complete, package: '$(INSTALL_FILE)'$(C)"

.PHONY: build dist
