package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/bufbuild/connect-go"
	"github.com/joho/godotenv"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"

	"github.com/AI1411/manpukuya/gen/product/v1/productv1connect"
	"github.com/AI1411/manpukuya/gen/user/v1/userv1connect"
	"github.com/AI1411/manpukuya/internal/infra/db"
	"github.com/AI1411/manpukuya/internal/infra/env"
	interceptor2 "github.com/AI1411/manpukuya/internal/infra/interceptor"
	"github.com/AI1411/manpukuya/internal/infra/logger"
	"github.com/AI1411/manpukuya/internal/infra/repository/product"
	"github.com/AI1411/manpukuya/internal/infra/repository/user"
	"github.com/AI1411/manpukuya/internal/server"
)

const address = "localhost:8080"

func main() {
	err := godotenv.Load()
	e, err := env.NewValue()
	if err != nil {
		log.Fatalf("failed to load env: %v", err)
	}

	zapLogger, _ := logger.NewLogger(e.Debug)
	dbClient := db.NewClient(&e.DB, zapLogger)

	// repository
	productRepo := product.NewProductRepository(dbClient, zapLogger)
	userrepo := user.NewUserRepository(dbClient, zapLogger)

	// interceptor
	interceptor := connect.WithInterceptors(interceptor2.ZapLoggerInterceptor(zapLogger))

	// server
	productServer := server.NewProductServer(dbClient, zapLogger, productRepo)
	userServer := server.NewUserServer(dbClient, zapLogger, userrepo)

	// handler
	mux := http.NewServeMux()
	mux.Handle(productv1connect.NewProductServiceHandler(productServer, interceptor))
	mux.Handle(userv1connect.NewUserServiceHandler(userServer, interceptor))

	fmt.Println("... Listening on", address)
	http.ListenAndServe(
		address,
		// Use h2c so we can serve HTTP/2 without TLS.
		h2c.NewHandler(mux, &http2.Server{}),
	)
}
