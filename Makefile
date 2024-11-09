ENV_FILE = --env-file srcs/.env
COMPOSE = -f ./srcs/docker-compose.yml
COMPOSE_CMD = docker compose ${COMPOSE} ${ENV_FILE}

all: 
	@${COMPOSE_CMD} build
	mkdir -p /home/${USER}/data/wordpress
	mkdir -p /home/${USER}/data/mariadb

up:
	@${COMPOSE_CMD} up || true

run: all up

down:
	@${COMPOSE_CMD} down

clean: down
	docker system prune -f

fclean:
	@${COMPOSE_CMD} down -v
	docker system prune -f

re:	fclean all

clean-local:
	sudo rm -rf /home/${USER}/data/wordpress
	sudo rm -rf /home/${USER}/data/mariadb

reset:	fclean clean-local all
		
.PHONY: all up run down clean fclean re clean-local reset