
init:
	terraform init

validate:
	terraform validate

fmt:
	terraform fmt

plan:
	terraform plan -out=terraform.tfplan

apply:
	terraform apply terraform.tfplan


all: init validate fmt plan apply