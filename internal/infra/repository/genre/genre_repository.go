package genre

import (
	"context"

	"go.uber.org/zap"

	"github.com/AI1411/manpukuya/internal/domain/entity"
	"github.com/AI1411/manpukuya/internal/domain/repository"
	"github.com/AI1411/manpukuya/internal/infra/db"
)

type genreRepository struct {
	dbClient  db.Client
	zapLogger *zap.Logger
}

func NewGenreRepository(dbClient db.Client, zapLogger *zap.Logger) repository.GenreRepository {
	return &genreRepository{
		dbClient:  dbClient,
		zapLogger: zapLogger,
	}
}

func (g genreRepository) GetGenre(ctx context.Context, s string) (entity.Genre, error) {
	//TODO implement me
	panic("implement me")
}

func (g genreRepository) ListGenres(ctx context.Context) ([]entity.Genre, error) {
	var genres []entity.Genre
	if err := g.dbClient.Conn(ctx).Find(&genres).Error; err != nil {
		return nil, err
	}

	return genres, nil
}

func (g genreRepository) CreateGenre(ctx context.Context) (string, error) {
	//TODO implement me
	panic("implement me")
}

func (g genreRepository) UpdateGenre(ctx context.Context) error {
	//TODO implement me
	panic("implement me")
}

func (g genreRepository) DeleteGenre(ctx context.Context) error {
	//TODO implement me
	panic("implement me")
}
