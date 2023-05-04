package usecase

import (
	"google.golang.org/protobuf/types/known/timestamppb"

	productv1 "github.com/AI1411/manpukuya/gen/product/v1"
	productEntity "github.com/AI1411/manpukuya/internal/domain/entity"
)

func ToGRPC(p *productEntity.Product) *productv1.Product {
	return &productv1.Product{
		Id:          p.ID.String(),
		ProductName: p.ProductName,
		Description: p.Description,
		ArtistId:    p.ArtistID.String(),
		GenreId:     p.GenreID.String(),
		ReleaseDate: p.ReleaseDate.String(),
		Stock:       p.Stock,
		Price:       p.Price,
		CreatedAt:   timestamppb.New(p.CreatedAt),
		UpdatedAt:   timestamppb.New(p.CreatedAt),
	}
}
