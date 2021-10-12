build-base:
	docker build -f baseimage/Dockerfile . -t ghcr.io/k1low/github-script-ruby-base:latest

push-base: build-base
	docker push ghcr.io/k1low/github-script-ruby-base:latest

prerelease:
	git pull origin main --tag
	sed -i -e "s#FROM ghcr.io/k1low/github-script-ruby-base:.*#FROM ghcr.io/k1low/github-script-ruby-base:${VER}#g" Dockerfile
	ghch -w -N ${VER}
	git add CHANGELOG.md Dockerfile
	git commit -m'Bump up version number'
	git tag ${VER}
	docker build -f baseimage/Dockerfile . -t ghcr.io/k1low/github-script-ruby-base:${VER}

release:
	docker push ghcr.io/k1low/github-script-ruby-base:${VER}
	git push origin main --tag
