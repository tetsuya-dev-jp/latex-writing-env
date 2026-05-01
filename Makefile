LATEX_IMAGE_NAME ?= latex-writing-env:local
FILE ?=

.PHONY: init build lint lint-fix format clean

init:
	docker build -t $(LATEX_IMAGE_NAME) -f docker/Dockerfile .

build:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash scripts/build.sh "$(FILE)"

lint:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash scripts/lint.sh "$(FILE)"

lint-fix:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash scripts/lint-fix.sh "$(FILE)"

format:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash scripts/format.sh "$(FILE)"

clean:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash scripts/clean.sh
