account = $(shell aws sts get-caller-identity --query "Account" --output text)
repo = apiapp
stage = dev
include stages/$(stage)

build:
	@docker build -t $(account).dkr.ecr.us-east-1.amazonaws.com/$(repo):$(version) .

push: login
	@docker push $(account).dkr.ecr.us-east-1.amazonaws.com/$(repo):$(version)

login:
	@aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(account).dkr.ecr.us-east-1.amazonaws.com

deploy:
	@cat kubernetes/deployment.yaml | sed "s/VERSION/$(version)/g;s/ACCOUNT/$(account)/g;s/NAMESPACE/$(namespace)/g" | kubectl apply -f -
	@cat kubernetes/svc.yaml | sed "s/NAMESPACE/$(namespace)/g" | kubectl apply -f -
