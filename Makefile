SHELL := /bin/bash
VERSION := 3.0.0
TSC_FLAGS := $(TSC_FLAGS) --moduleResolution=node --target=ES2017 --typeRoots=node_modules/@types

ARCH := $(shell uname -p)

INSTALL_DIR ?= dist
BUILD_DIR ?= $(shell mktemp -d)

BUILD_DIR += /link3-$(VERSION)_$(ARCH)
INSTALL_FILE := $(INSTALL_DIR)/link3-$(VERSION)_$(ARCH).tar.gz

B := $(shell tput setaf 3 && tput bold)
C := $(shell tput sgr0)

# build the application into build/
build:
	@echo "$(B)--- building into '$(BUILD_DIR)' ...$(C)"
	@mkdir -p $(BUILD_DIR)

	@echo "$(B)(B-01) building server ...$(C)"
	@tsc $(TSC_FLAGS) --outDir=$(BUILD_DIR)/server src/server/*.ts

	@echo "$(B)(B-02) bulding client ...$(C)"
	@tsc $(TSC_FLAGS) --outDir=$(BUILD_DIR)/client src/client/*.ts

	@echo "$(B)(B-03) building executables ...$(C)"
	@tsc $(TSC_FLAGS) --outFile=$(BUILD_DIR)/bin/www src/bin/www.ts
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
