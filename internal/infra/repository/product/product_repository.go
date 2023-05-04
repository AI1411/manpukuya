package product

import (
	context "context"

	"github.com/google/uuid"
	"go.uber.org/zap"

	productEntity "github.com/AI1411/manpukuya/internal/domain/entity"
	productRepo "github.com/AI1411/manpukuya/internal/domain/repository"
	"github.com/AI1411/manpukuya/internal/infra/db"
)

type productRepository struct {
	dbClient  db.Client
	zapLogger *zap.Logger
}

func NewProductRepository(dbClient db.Client, zapLogger *zap.Logger) productRepo.ProductRepository {
	return &productRepository{
		dbClient:  dbClient,
		zapLogger: zapLogger,
	}
}

func (p productRepository) ListProducts(
	ctx context.Context,
	condition *productEntity.ListProductsCondition,
) (productEntity.ListProducts, error) {
	//TODO implement me
	panic("implement me")
}

func (p productRepository) GetProduct(ctx context.Context, uuid uuid.UUID) (*productEntity.Product, error) {
	//TODO implement me
	panic("implement me")
}

func (p productRepository) CreateProduct(ctx context.Context, product *productEntity.Product) (string, error) {
	//TODO implement me
	panic("implement me")
}

func (p productRepository) UpdateProduct(ctx context.Context, product *productEntity.Product) error {
	//TODO implement me
	panic("implement me")
}

func (p productRepository) DeleteProduct(ctx context.Context, uuid uuid.UUID) error {
	//TODO implement me
	panic("implement me")
}
