build: _posts/* 404.html index.md _config.yml about.md
	bundle exec jekyll build

clean: _site/* .jekyll-cache/*
	bundle exec jekyll clean

serve: 
	make build
	bundle exec jekyll serve