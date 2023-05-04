package usecase

import (
	"context"

	"github.com/bufbuild/connect-go"

	productv1 "github.com/AI1411/manpukuya/gen/proto/product/v1"
	"github.com/AI1411/manpukuya/internal/domain/repository"
)

type ListProductsUsecase interface {
	Exec(ctx context.Context, in *connect.Request[productv1.ListProductsRequest]) (*connect.Response[productv1.ListProductsResponse], error)
}

type listProductsUsecaseImpl struct {
	productRepository repository.ProductRepository
}

func NewListProductsUsecase(productRepository repository.ProductRepository) ListProductsUsecase {
	return &listProductsUsecaseImpl{
		productRepository: productRepository,
	}
}

func (l listProductsUsecaseImpl) Exec(
	ctx context.Context,
	in *connect.Request[productv1.ListProductsRequest],
) (*connect.Response[productv1.ListProductsResponse], error) {
	_, err := l.productRepository.ListProducts(ctx, nil)
	if err != nil {
		return nil, err
	}

	return &connect.Response[productv1.ListProductsResponse]{}, nil
}
