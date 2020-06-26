PROJECT_ID?=cldntventr
CLUSTER_NAME?=cldntventr-dev
CLUSTER_ZONE?=us-east4-b
NODE_APPS=content,keycloak-gateway,person-model,www
OS := $(shell uname)

onboard:
	make ensure-gcloud-project \
	&& make install-tools \
	&& make onboard-jx

first-run:
	npm ci \
	&& make clean-install

restart:
	npm i \
	&& make down \
	&& make up

build:
	meta exec "make build" --include-only $(NODE_APPS)

clean-install:
	meta exec "make clean-install" --include-only $(NODE_APPS)

down:
	docker-compose down

connect-to-kubernetes: gcloud-login
	gcloud container clusters get-credentials $(CLUSTER_NAME) --zone=$(CLUSTER_ZONE)

ensure-gcloud-project:
	gcloud config set project $(PROJECT_ID)

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

gcloud-login:
	@echo "You will now be asked to log in to Google twice - use the same gcloud account each time"
	gcloud auth login
	gcloud auth application-default login

login-to-gcloud: gcloud-login

onboard-jx: connect-to-kubernetes
	jx team jx
	jx ns jx

up:
	docker-compose -f docker-compose.yml up

up-d:
	docker-compose -f docker-compose.yml up -d
