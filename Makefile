include ./srcs/.env
all: run

# Defines a target named "run". This target does the following:
run:

# Creates directories specified by $(VOLUME_WEB) and $(VOLUME_DB)
	@sudo mkdir -p $(VOLUME_WEB)
	@sudo mkdir -p $(VOLUME_DB)

# Uses docker-compose to start the services defined in the file specified by $(COMPOSE_FILE) 
# in detached mode (-d) and rebuild the images (--build).
	@docker-compose -f $(COMPOSE_FILE) up -d --build
#	@echo "Let's see..."

#	@docker-compose -f $(COMPOSE_FILE) down
#	@docker-compose -f $(COMPOSE_FILE) up -d --build

#	@docker-compose -f $(COMPOSE_FILE) up

	@echo "Inception is ready!"

up:
	@docker-compose -f $(COMPOSE_FILE) up -d --build
	@echo "Inception is up!"


down:
# Defines a target named "down". This target uses docker-compose to stop and remove the containers, 
# networks, and volumes defined in the file specified by $(COMPOSE_FILE).
	@docker-compose -f $(COMPOSE_FILE) down

clean:
# Uses docker-compose to stop and remove the containers, networks, and volumes defined in the file specified by $(COMPOSE_FILE).
	@docker-compose -f $(COMPOSE_FILE) down

# Removes Docker networks, containers, images, volumes, and the directory /home/nimai_incpetion.
	@-docker network rm `docker network ls -q`
	@-docker rm `docker ps -qa`
	@-docker rmi -f `docker images -qa`
	@-docker volume rm `docker volume ls -q`
	@-docker network rm `docker network ls -q`
	@sudo rm -rf /home/nimai

# Prunes unused Docker volumes and system resources.
	@docker volume prune -f
	@-docker system prune -f

	@echo "clean finished"

.PHONY: all run up down clean
.SILENT:
