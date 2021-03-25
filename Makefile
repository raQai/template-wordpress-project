ifneq (,$(wildcard ./.env))
	include .env
	export
endif

all: pullall buildall connect up

# Pulls all repositories based on config
pullall:
	./git-foreach.sh

# Builds all repositories based on config
buildall:
	./build.sh

# Connect to docker instance. Tries for 30 seconds
connect:
	(curl --silent --retry 30 --retry-delay 1 --retry-connrefused \
		$(or $(LOCAL_ADDRESS), localhost) && \
		python -m webbrowser "$(or $(LOCAL_ADDRESS), localhost)") &

# Start docker instance
up:
	docker-compose up