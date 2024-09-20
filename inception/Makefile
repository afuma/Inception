FILE=srcs/docker-compose.yml

all: build

build:
	docker-compose -f $(FILE) build
	docker-compose -f $(FILE) up -d

clean:
	docker-compose -f $(FILE) down

fclean: clean
	rm -rf $(DATA)
	docker system prune -af

re: fclean build