package main

import (
	"context"
	"fmt"
	"log"
	"net/http"

	"github.com/bufbuild/connect-go"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"

	productv1 "github.com/AI1411/manpukuya/gen/product/v1"
	"github.com/AI1411/manpukuya/gen/product/v1/productv1connect"
)

const address = "localhost:8080"

func main() {
	mux := http.NewServeMux()
	path, handler := productv1connect.NewProductServiceHandler(&productStoreServiceServer{})
	mux.Handle(path, handler)
	fmt.Println("... Listening on", address)
	http.ListenAndServe(
		address,
		// Use h2c so we can serve HTTP/2 without TLS.
		h2c.NewHandler(mux, &http2.Server{}),
	)
}

type productStoreServiceServer struct {
	productv1connect.UnimplementedProductServiceHandler
}

func (s *productStoreServiceServer) CreateProduct(
	ctx context.Context,
	req *connect.Request[productv1.CreateProductRequest],
) (*connect.Response[productv1.CreateProductResponse], error) {
	product := req.Msg.GetProduct()
	log.Printf("Got a request to create a %+v", product)
	return connect.NewResponse(&productv1.CreateProductResponse{}), nil
}
