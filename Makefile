# Makefile for distcc volunteer

.PHONY: all
all: build save

.PHONY: build
build:
	@echo "Building distcc volunteer image..."
	@docker build -t archlinux:distcc .

.PHONY: save
save: build
	@echo "Saving distcc volunteer image..."
	@docker save -o archlinux-distcc.tar archlinux:distcc
	@echo "Image saved as archlinux-distcc.tar"
	@echo "To load the image, use: docker load -i archlinux-distcc.tar"
	@echo "To run the image, use: docker run -it --rm archlinux:distcc"

.PHONY: load
load: archlinux-distcc.tar
	@echo "Loading distcc volunteer image..."
	@docker load -i archlinux-distcc.tar
	@echo "Image loaded successfully"

.PHONY: run
run:
	@echo "Running distcc volunteer image..."
	@docker run -it --rm --detach --name distcc-volunteer archlinux:distcc
	@echo "Exited from the container"

.PHONY: clean
clean:
	@echo "Cleaning up..."
	@docker rmi archlinux:distcc || true
	@rm -f archlinux-distcc.tar
	@echo "Cleaned up successfully"

.PHONY: usage
usage:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  all       - Build and save the distcc volunteer image"
	@echo "  build     - Build the distcc volunteer image"
	@echo "  save      - Save the distcc volunteer image to a tar file"
	@echo "  usage     - Show this usage message"
	@echo ""
	@echo "To run the image, use: docker run -it --rm archlinux:distcc"
