package usecase

import (
	"google.golang.org/protobuf/types/known/timestamppb"

	artistv1 "github.com/AI1411/manpukuya/gen/artist/v1"
	genrev1 "github.com/AI1411/manpukuya/gen/genre/v1"
	productv1 "github.com/AI1411/manpukuya/gen/product/v1"
	productEntity "github.com/AI1411/manpukuya/internal/domain/entity"
)

func ToGRPC(p *productEntity.Product) *productv1.Product {
	return &productv1.Product{
		Id:          p.ID.String(),
		ProductName: p.ProductName,
		Description: p.Description,
		Artist: &artistv1.Artist{
			Id:         p.Artist.ID.String(),
			ArtistName: p.Artist.GetArtistName(),
			Slag:       p.Artist.GetSlag(),
		},
		Genre: &genrev1.Genre{
			Id:        p.Genre.GetIDString(),
			GenreName: p.Genre.GetGenreName(),
			Slag:      p.Genre.GetSlag(),
		},
		ReleaseDate: p.ReleaseDate.String(),
		Stock:       p.Stock,
		Price:       p.Price,
		CreatedAt:   timestamppb.New(p.CreatedAt),
		UpdatedAt:   timestamppb.New(p.CreatedAt),
	}
}
