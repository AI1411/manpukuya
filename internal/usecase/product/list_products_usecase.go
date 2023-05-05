package usecase

import (
	"context"

	"github.com/bufbuild/connect-go"

	productv1 "github.com/AI1411/manpukuya/gen/product/v1"
	productEntity "github.com/AI1411/manpukuya/internal/domain/entity"
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
	lpc := productEntity.NewListProductsCondition(
		in.Msg.ProductName,
		in.Msg.Offset,
		in.Msg.Limit,
	)

	lp, err := l.productRepository.ListProducts(ctx, lpc)
	if err != nil {
		return nil, err
	}

	lpr := make([]*productv1.Product, len(lp))
	for i, p := range lp {
		lpr[i] = ToGRPC(p)
	}

	return &connect.Response[productv1.ListProductsResponse]{
		Msg: &productv1.ListProductsResponse{
			Products: lpr,
		},
	}, nil
}
