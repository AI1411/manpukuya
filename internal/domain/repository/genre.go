package repository

import (
	"context"

	"github.com/AI1411/manpukuya/internal/domain/entity"
)

type GenreRepository interface {
	GetGenre(context.Context, string) (entity.Genre, error)
	ListGenres(ctx context.Context) ([]entity.Genre, error)
	CreateGenre(ctx context.Context) (string, error)
	UpdateGenre(ctx context.Context) error
	DeleteGenre(ctx context.Context) error
}
