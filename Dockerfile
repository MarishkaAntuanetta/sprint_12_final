# дружелюбный к modernc.org/sqlite базовый образ
FROM golang:1.24-bookworm

WORKDIR /app

# 1) инструменты сборки (modernc их любит)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 2) сначала модули — лучше кэшируются
COPY go.mod go.sum ./
RUN go mod download

# 3) потом исходники
COPY . .

# 4) сборка (CGO включён по умолчанию в bookworm)
RUN go build -o parcel-tracker .

# 5) запуск бинарника
CMD ["./parcel-tracker"]
