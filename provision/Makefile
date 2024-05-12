
IMAGE:=wordpress.pkr.hcl


init:
	packer init $(IMAGE)

validate:
	packer validate $(IMAGE)

build:
	packer build $(IMAGE)


all: init validate build