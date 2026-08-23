# Makefile
# Ensure NOTICE and LICENSE are included in any distribution package.
# Add or merge these targets into your project's existing Makefile if one exists.

.PHONY: notice license all build

# Ensure NOTICE is present in distribution package
notice:
	@echo "Installing NOTICE file into dist/"
	mkdir -p dist
	cp NOTICE dist/ || true

# Ensure LICENSE is present in distribution package
license:
	@echo "Installing LICENSE file into dist/"
	mkdir -p dist
	cp LICENSE dist/ || true

# Example: include notice/license when building distribution
all: build notice license

# Placeholder build target; replace with actual build steps for the project
build:
	@echo "No build rule defined. Replace this with your project build steps (e.g., mvn package, gradle build, etc.)."
