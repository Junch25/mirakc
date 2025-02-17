TAG ?= test
PLATFORM ?= linux/amd64
DEBIAN ?= bookworm

.PHONY: all
all: build

.PHONY: build
build: format
	cargo build --all-features

.PHONY: test
test: build
	cargo nextest run --all-features

.PHONY: format
format:
	cargo fmt

.PHONE: alpine-image
alpine-image:
	docker buildx build -t mirakc/mirakc:$(TAG) -f docker/Dockerfile.alpine --load \
	  --target mirakc --platform=$(PLATFORM) .

.PHONE: debian-image
debian-image:
	docker buildx build -t mirakc/mirakc:$(TAG) -f docker/Dockerfile.debian --load \
	  --target mirakc --platform=$(PLATFORM) --build-arg DEBIAN_CODENAME=$(DEBIAN) .
