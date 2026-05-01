LATEX_IMAGE_NAME ?= latex-writing-env:local
FILE ?=

.PHONY: init build view lint lint-fix format clean

init:
	docker build -t $(LATEX_IMAGE_NAME) -f docker/Dockerfile .

build:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash scripts/build.sh "$(FILE)"

view:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash scripts/build.sh "$(FILE)"
	bash scripts/open-pdf.sh "$(FILE)"

lint:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash scripts/lint.sh "$(FILE)"

lint-fix:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash scripts/lint.sh --fix "$(FILE)"

format:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash scripts/format.sh "$(FILE)"

clean:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash scripts/clean.sh
