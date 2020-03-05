build: _posts/* 404.html index.md _config.yml about.md
	bundle exec jekyll build

clean: _site/* .jekyll-cache/* .sass-cache/*
	rm -rf _site/* .jekyll-cache/* .sass-cache/*
	rmdir _site .jekyll-cache .sass-cache

serve: 
	make build
	bundle exec jekyll serve