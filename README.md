# Production Delivery Platform 🚀

![CI Pipeline](https://github.com/Alihehe232/devops-production-lab/actions/workflows/ci.yml/badge.svg)
![CD Pipeline](https://github.com/Alihehe232/devops-production-lab/actions/workflows/cd.yml/badge.svg)

Production-ready платформа доставки приложений со встроенным CI/CD пайплайном, автоматическим сканированием уязвимостей, оркестрацией деплоя через Ansible и механизмами автоматического отката (rollback).

## 🛠 Технологический стек

* **Application**: FastAPI (Python 3.11), Uvicorn
* **Containerization**: Docker, Docker Compose, Nginx
* **CI/CD**: GitHub Actions, GitHub Container Registry (GHCR)
* **Security**: Trivy (Vulnerability Scanner)
* **Configuration Management**: Ansible
* **Testing**: Pytest

## 🔄 Архитектура пайплайна

```text
[ Git Push ]
     │
     ▼
┌───────── CI Pipeline ─────────┐
│ 1. Run Tests (Pytest)        │
│ 2. Security Scan (Trivy)     │
│ 3. Build & Push Image (GHCR) │
└──────────────┬────────────────┘
               │
               ▼
┌───────── CD Pipeline ─────────┐
│ 1. Ansible Deployment         │
│ 2. Healthcheck Verification   │
│ 3. Automated Rollback (Fail)  │
└───────────────────────────────┘

1. CI Pipeline (ci.yml)
Testing: Автоматический запуск юнит-тестов с помощью pytest.

Security Scan: Анализ проекта на уязвимости с помощью Trivy.

Build & Registry: Сборка Docker-образа и публикация в ghcr.io с тегами :latest и :${{ github.sha }}.

2. CD Pipeline (cd.yml)
Orchestration: Запуск Ansible Playbook (ansible/deploy.yml) после успешного завершения CI.

Deploy: Разворачивание обновленной версии контейнеров через docker compose.

Healthcheck & Rollback: Запуск scripts/healthcheck.sh. В случае сбоя автоматически вызывается scripts/rollback.sh для отката на предыдущий стабильный релиз.

📂 Структура проекта
.
├── .github/
│   └── workflows/
│       ├── ci.yml              # CI пайплайн (тесты, скан, сборка)
│       └── cd.yml              # CD пайплайн (деплой через Ansible)
├── ansible/
│   ├── deploy.yml              # Ansible playbook для деплоя
│   └── inventory.ini           # Конфигурация хостов
├── app/
│   ├── main.py                 # FastAPI приложение
│   ├── requirements.txt        # Зависимости Python
│   └── tests/                  # Тесты
├── docker/
│   └── nginx.conf              # Конфигурация Nginx
├── scripts/
│   ├── deploy.sh               # Скрипт деплоя
│   ├── healthcheck.sh          # Скрипт проверки здоровья
│   └── rollback.sh             # Скрипт отката
├── Dockerfile                  # Инструкция сборки контейнера
├── docker-compose.yml          # Dev-окружение
└── docker-compose.prod.yml     # Prod-окружение

🚀 Локальный запуск
Клонирование репозитория:

Bash
git clone [https://github.com/Alihehe232/devops-production-lab.git](https://github.com/Alihehe232/devops-production-lab.git)
cd devops-production-lab
Запуск сервисов через Docker Compose:

Bash
docker compose -f docker-compose.prod.yml up -d --build
Проверка работы:
Приложение доступно по адресу: http://localhost