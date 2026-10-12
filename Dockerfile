FROM golang:1.21 as base

WORKDIR /app

COPY go.mod . 

RUN go mod download

COPY . .

RUN go build -o /kas .

EXPOSE 8080
# Final stage - Distroless image
FROM gcr.io/distroless/base

COPY --from=base /app/kas .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./kas"]