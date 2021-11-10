.PHONY: run
run:
	cd wiki && hugo server --minify --theme book
.PHONY: build
build:
	cd wiki && hugo --minify -t book
.PHONY: deploy
deploy: build
	firebase deploy
