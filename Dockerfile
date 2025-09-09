# очень простой Dockerfile
FROM golang:1.24

WORKDIR /app

# сначала модули — чтобы кешировались
COPY go.mod go.sum ./
RUN go mod download

# потом исходники
COPY . .

# сборка
RUN go build -o parcel-tracker ./main.go

# запуск
CMD ["./parcel-tracker"]
