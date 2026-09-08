COMPOSE_DEV = docker-compose.yml

.PHONY: help up down build test logs

help:
	@echo "Доступные команды:"
	@echo "  make up      - Запустить локальное окружение (dev)"
	@echo "  make down    - Остановить локальное окружение"
	@echo "  make build   - Собрать Docker-образы"
	@echo "  make test    - Запустить тесты"
	@echo "  make logs    - Посмотреть логи приложения"

up:
	docker compose -f $(COMPOSE_DEV) up -d

down:
	docker compose -f $(COMPOSE_DEV) down

build:
	docker compose -f $(COMPOSE_DEV) build

test:
	docker compose -f $(COMPOSE_DEV) run --rm app pytest tests/

logs:
	docker compose -f $(COMPOSE_DEV) logs -f app
	