Parcel Tracker

Простое Go-приложение для отслеживания посылок с хранением данных в SQLite.
В проекте также настроен CI/CD через GitHub Actions для автоматического тестирования и публикации Docker-образа в Docker Hub.

🚀 Возможности

Хранение информации о посылках (номер, клиент, статус, адрес, дата создания).

CRUD-операции над таблицей parcel в базе SQLite.

Unit-тесты на пакет работы с посылками.

Автоматическая сборка и тестирование через GitHub Actions.

Автопубликация образа в Docker Hub при создании тега.

🛠️ Технологии

Go 1.24

SQLite (modernc.org/sqlite)

Docker

GitHub Actions

📦 Установка и запуск
Локально
# клонировать проект
git clone https://github.com/MarishkaAntuanetta/sprint_final_12.git
cd sprint_final_12

# инициализировать/обновить зависимости
go mod tidy

# прогнать тесты
go test ./...

# запустить приложение
go run main.go


По умолчанию приложение работает с файлом tracker.db в корне проекта.

Через Docker
# собрать образ
docker build -t parcel-tracker .

# запустить контейнер
docker run -p 8080:8080 parcel-tracker

⚙️ CI/CD Workflow

test job: запускается на каждый push/PR → проверяет форматирование и выполняет тесты.

publish job: запускается при пуше тега вида v* → собирает Docker-образ и публикует его в Docker Hub.

Для публикации нужно добавить в GitHub Secrets:

DOCKERHUB_USERNAME — логин Docker Hub

DOCKERHUB_TOKEN — персональный access-token

📝 Структура проекта
.
├── main.go              # входная точка приложения
├── parcel.go            # логика работы с посылками (ParcelStore)
├── parcel_test.go       # unit-тесты
├── tracker.db           # база SQLite (для локального запуска)
├── go.mod / go.sum      # зависимости
├── Dockerfile           # сборка образа
├── .dockerignore
└── .github/workflows/ci.yml  # GitHub Actions