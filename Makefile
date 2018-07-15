build: _posts/* 404.html index.md _config.yml about.md
	jekyll build

serve: 
	make build
	jekyll serve
	
push_dryrun: _site/* 
	s3_website push --dry-run

push: _site/*
	s3_website push

build_push: _posts/* 404.html index.md _config.yml about.md _site/*
	make build
	make push