# ===== stage: build =====
FROM golang:1.24 AS build

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

# копируем остальной код
COPY . .

# собираем статически (удобно для scratch/alpine)
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o parcel-tracker ./main.go

# ===== stage: runtime =====
FROM gcr.io/distroless/base-debian12

WORKDIR /app
# бинарник
COPY --from=build /app/parcel-tracker /app/parcel-tracker
# если приложению нужен готовый файл БД, положите его рядом:
# COPY tracker.db /app/tracker.db

EXPOSE 8080
ENTRYPOINT ["/app/parcel-tracker"]
