LATEX_IMAGE_NAME ?= latex-writing-env:local
FILE ?=
TEMPLATE ?=
NAME ?=

.PHONY: init doctor build watch lint format clean new

init:
	docker build -t $(LATEX_IMAGE_NAME) -f tools/latex/Dockerfile .

doctor:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash tools/latex/scripts/doctor.sh

build:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash tools/latex/scripts/build.sh "$(FILE)"

watch:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash tools/latex/scripts/watch.sh "$(FILE)"

lint:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash tools/latex/scripts/lint.sh "$(FILE)"

format:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash tools/latex/scripts/format.sh "$(FILE)"

clean:
	LATEX_IMAGE_NAME=$(LATEX_IMAGE_NAME) bash tools/latex/scripts/clean.sh "$(FILE)"

new:
	TEMPLATE="$(TEMPLATE)" NAME="$(NAME)" bash tools/latex/scripts/new-document.sh
