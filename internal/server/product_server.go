package server

import (
	"context"
	"log"

	"github.com/bufbuild/connect-go"
	"go.uber.org/zap"

	productv1 "github.com/AI1411/manpukuya/gen/product/v1"
	"github.com/AI1411/manpukuya/internal/domain/repository"
	"github.com/AI1411/manpukuya/internal/infra/db"
	"github.com/AI1411/manpukuya/internal/usecase/product"
)

type ProductServer struct {
	dbClient     db.Client
	zapLogger    *zap.Logger
	categoryRepo repository.ProductRepository
}

func NewProductServer(
	dbClient db.Client,
	zapLogger *zap.Logger,
	categoryRepo repository.ProductRepository,
) *ProductServer {
	return &ProductServer{
		dbClient:     dbClient,
		zapLogger:    zapLogger,
		categoryRepo: categoryRepo,
	}
}

func (s *ProductServer) GetProduct(
	ctx context.Context,
	in *connect.Request[productv1.GetProductRequest],
) (*connect.Response[productv1.GetProductResponse], error) {
	//TODO implement me
	panic("implement me")
}

func (s *ProductServer) ListProducts(
	ctx context.Context,
	in *connect.Request[productv1.ListProductsRequest],
) (*connect.Response[productv1.ListProductsResponse], error) {
	uc := usecase.NewListProductsUsecase(s.categoryRepo)
	res, err := uc.Exec(ctx, in)
	if err != nil {
		s.zapLogger.Error(err.Error())
		return nil, err
	}
	context.WithValue(ctx, "response", res)
	log.Printf("response: %v", ctx.Value("response"))
	return res, nil
}

func (s *ProductServer) CreateProduct(
	ctx context.Context,
	in *connect.Request[productv1.CreateProductRequest],
) (*connect.Response[productv1.CreateProductResponse], error) {
	//TODO implement me
	panic("implement me")
}

func (s *ProductServer) UpdateProduct(
	ctx context.Context,
	in *connect.Request[productv1.UpdateProductRequest],
) (*connect.Response[productv1.UpdateProductResponse], error) {
	//TODO implement me
	panic("implement me")
}

func (s *ProductServer) DeleteProduct(
	ctx context.Context,
	in *connect.Request[productv1.DeleteProductRequest],
) (*connect.Response[productv1.DeleteProductResponse], error) {
	//TODO implement me
	panic("implement me")
}
