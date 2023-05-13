package product

import (
	context "context"

	"github.com/google/uuid"
	"go.uber.org/zap"

	productEntity "github.com/AI1411/manpukuya/internal/domain/entity"
	productRepo "github.com/AI1411/manpukuya/internal/domain/repository"
	"github.com/AI1411/manpukuya/internal/infra/db"
	"github.com/AI1411/manpukuya/internal/infra/repository"
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
	var products productEntity.ListProducts
	query := p.dbClient.Conn(ctx)
	query = repository.AddLimit(query, int32(condition.Limit))
	query = repository.AddOffset(query, int32(condition.Offset))
	query = repository.AddWhereLike(query, "product_name", condition.ProductName)
	err := query.Preload("Artist").Preload("Genre").Find(&products).Error
	if err != nil {
		return nil, err
	}

	return products, nil
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
