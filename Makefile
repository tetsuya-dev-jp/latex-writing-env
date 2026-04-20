LATEX_IMAGE_NAME ?= latex-writing-env:local
FILE ?=

.PHONY: init build lint lint-fix format clean

init:
	docker build -t $(LATEX_IMAGE_NAME) -f tools/latex/Dockerfile .

build:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash tools/latex/scripts/build.sh "$(FILE)"

lint:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash tools/latex/scripts/lint.sh "$(FILE)"

lint-fix:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash tools/latex/scripts/lint-fix.sh "$(FILE)"

format:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash tools/latex/scripts/format.sh "$(FILE)"

clean:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash tools/latex/scripts/clean.sh "$(FILE)"
