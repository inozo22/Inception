include ./srcs/.env
all: run

run:
	@sudo mkdir -p $(VOLUME_WEB)
	@sudo mkdir -p $(VOLUME_DB)
	@docker-compose -f $(COMPOSE_FILE) up -d --build
#	@docker-compose -f $(COMPOSE_FILE) up
	@echo "I have done up"

down:
	@docker-compose -f $(COMPOSE_FILE) down

clean:
	@docker-compose -f $(COMPOSE_FILE) down
	@-docker network rm `docker network ls -q`
	@-docker rm `docker ps -qa`
	@-docker rmi -f `docker images -qa`
	@-docker volume rm `docker volume ls -q`
	@-docker network rm `docker network ls -q`
	@sudo rm -rf /home/syamashi
	@docker volume prune -f
	@-docker system prune -f
	@echo "clean finished"

.PHONY: all run down clean
.SILENT:
