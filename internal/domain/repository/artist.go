package repository

import (
	"context"

	"github.com/AI1411/manpukuya/internal/domain/entity"
)

type ArtistRepository interface {
	GetArtist(context.Context, string) (*entity.Artist, error)
	ListArtists(context.Context, *entity.ListArtistCondition) ([]entity.Artist, error)
	CreateArtist(context.Context, *entity.Artist) (string, error)
	UpdateArtist(context.Context, *entity.Artist) error
	DeleteArtist(context.Context, string) error
}
