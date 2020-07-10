PROJECT_ID?=cldntventr
CLUSTER_NAME?=cldntventr-dev
CLUSTER_ZONE?=us-east4-b
NODE_APPS=content,keycloak-gateway,person-model,www
OS := $(shell uname)

build:
	meta exec "make build" --include-only $(NODE_APPS)

clean-install:
	meta exec "make clean-install" --include-only $(NODE_APPS)

connect-to-kubernetes: gcloud-login
	gcloud container clusters get-credentials $(CLUSTER_NAME) --zone=$(CLUSTER_ZONE)

copy-secrets:
	cd clusters/$(CLUSTER_NAME)/infrastructure && ./scripts/decrypt.sh
	cp clusters/$(CLUSTER_NAME)/infrastructure/secret/local/content.env ./content/.env
	cp clusters/$(CLUSTER_NAME)/infrastructure/secret/local/www.env ./www/.env

down:
	docker-compose down --remove-orphans

ensure-gcloud-project:
	gcloud config set project $(PROJECT_ID)

gcloud-login:
	@echo "You will now be asked to log in to Google twice - use the same gcloud account each time"
	gcloud auth login
	gcloud auth application-default login

install:
	meta exec "make install" --include-only $(NODE_APPS)

install-tools:
ifeq ($(OS),Darwin)
	sh ./scripts/install-tools.sh
else ifeq ($(OS),Linux)
	sh ./scripts/check-tools.sh
else
	echo "platfrom $(OS) not supported to tool checking or installation"
	exit -1
endif

login-to-gcloud: gcloud-login

onboard:
	make ensure-gcloud-project \
	&& make install-tools \
	&& make onboard-jx \
	&& make copy-secrets

onboard-jx: connect-to-kubernetes
	jx team jx
	jx ns jx

restart:
	make down \
	&& make up

start:
	make clean-install \
	&& make up-d

up:
	docker-compose -f docker-compose.yml up

up-d:
	docker-compose -f docker-compose.yml up -d
