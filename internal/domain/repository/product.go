package repository

import (
	"context"

	"github.com/google/uuid"

	productEntity "github.com/AI1411/manpukuya/internal/domain/entity"
)

type ProductRepository interface {
	ListProducts(context.Context, *productEntity.ListProductsCondition) (productEntity.ListProducts, error)
	GetProduct(context.Context, uuid.UUID) (*productEntity.Product, error)
	CreateProduct(context.Context, *productEntity.Product) (string, error)
	UpdateProduct(context.Context, *productEntity.Product) error
	DeleteProduct(context.Context, uuid.UUID) error
}
