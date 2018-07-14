build: _posts/* 404.html index.md _config.yml about.md
	jekyll build
	
push_dryrun: _site/* 
	s3_website push --dry-run

push: _site/*
	s3_website push

build_push: _posts/* 404.html index.md _config.yml about.md _site/*
	jekyll build
	s3_website push