FROM golang AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o ./fizzbuzz

FROM scratch
COPY --from=builder /app/fizzbuzz /fizzbuzz
COPY templates /templates

CMD ["/fizzbuzz", "serve"]
