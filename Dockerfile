# самый простой Dockerfile, дружелюбный к modernc.org/sqlite
FROM golang:1.24-bookworm

WORKDIR /app

# 1) инструменты для сборки (gcc и т.п. — modernc это любит)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 2) сначала модули (лучше кешируется)
COPY go.mod go.sum ./
RUN go mod download

# 3) затем исходники
COPY . .

# 4) сборка (CGO включен по умолчанию в golang:bookworm)
RUN go build -o parcel-tracker ./main.go

# 5) запуск
CMD ["./parcel-tracker"]
