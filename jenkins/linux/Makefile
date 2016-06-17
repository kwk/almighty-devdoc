SOURCE_DIR := $(shell pwd)/../..
BUILD_DIR := $(shell mktemp -d)
DOCKER_IMAGE_DEVDOC := almighty-devdoc

.PHONY: all
all: build

.PHONY: docker-image-devdoc
docker-image-devdoc:
	docker build -t $(DOCKER_IMAGE_DEVDOC) .

.PHONY: build-dir
build-dir:
	mkdir -p $(BUILD_DIR)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
	
.PHONY: build
build: build-dir docker-image-devdoc
	# TODO (kkleine) Remove interactive switch when running in Jenkins 
	echo "Building in $(BUILD_DIR)"
	docker run \
		-it \
		--rm \
		-v $(SOURCE_DIR):/source-dir:ro \
		-v $(BUILD_DIR):/build-dir:rw \
		$(DOCKER_IMAGE_DEVDOC) \
		/source-dir/jenkins/linux/build.sh /source-dir /build-dir


