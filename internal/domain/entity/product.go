package entity

import (
	"time"

	"github.com/google/uuid"
)

type ListProducts []*Product

type Product struct {
	ID          uuid.UUID `gorm:"type:uuid;primary_key;default:uuid_generate_v4()"`
	ProductName string
	Description string
	Artist      Artist `gorm:"foreignkey:ArtistID;->"`
	Genre       Genre  `gorm:"foreignkey:GenreID;->"`
	ArtistID    uuid.UUID
	GenreID     uuid.UUID
	ReleaseDate time.Time
	Stock       uint32
	Price       uint32
	CreatedAt   time.Time
	UpdatedAt   time.Time
}

type ListProductsCondition struct {
	ProductName string
	Offset      uint32
	Limit       uint32
}

func NewProduct(
	productName string,
	description string,
	artistID uuid.UUID,
	genreID uuid.UUID,
	releaseDate time.Time,
	stock uint32,
	price uint32,
) *Product {
	return &Product{
		ProductName: productName,
		Description: description,
		ArtistID:    artistID,
		GenreID:     genreID,
		ReleaseDate: releaseDate,
		Stock:       stock,
		Price:       price,
	}
}

func NewListProductsCondition(
	productName string,
	offset uint32,
	limit uint32,
) *ListProductsCondition {
	if limit == 0 {
		limit = 10
	}
	return &ListProductsCondition{
		ProductName: productName,
		Offset:      offset,
		Limit:       limit,
	}
}

func (lp ListProducts) Len() int {
	return len(lp)
}
