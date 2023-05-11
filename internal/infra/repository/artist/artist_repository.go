package artist

import (
	"context"

	"go.uber.org/zap"

	"github.com/AI1411/manpukuya/internal/domain/entity"
	"github.com/AI1411/manpukuya/internal/domain/repository"
	"github.com/AI1411/manpukuya/internal/infra/db"
	q "github.com/AI1411/manpukuya/internal/infra/repository"
)

type artistRepository struct {
	dbClient  db.Client
	zapLogger *zap.Logger
}

func NewArtistRepository(dbClient db.Client, zapLogger *zap.Logger) repository.ArtistRepository {
	return &artistRepository{
		dbClient:  dbClient,
		zapLogger: zapLogger,
	}
}

func (a artistRepository) GetArtist(ctx context.Context, s string) (*entity.Artist, error) {
	//TODO implement me
	panic("implement me")
}

func (a artistRepository) ListArtists(ctx context.Context, condition *entity.ListArtistCondition) ([]entity.Artist, error) {
	var artists []entity.Artist
	query := a.dbClient.Conn(ctx)
	query = q.AddWhereLike(query, "artist_name", condition.ArtistName)
	query = q.AddOffset(query, condition.Offset)
	query = q.AddLimit(query, condition.Limit)
	if err := query.Find(&artists).Error; err != nil {
		return nil, err
	}

	return artists, nil
}

func (a artistRepository) CreateArtist(ctx context.Context, artist *entity.Artist) (string, error) {
	//TODO implement me
	panic("implement me")
}

func (a artistRepository) UpdateArtist(ctx context.Context, artist *entity.Artist) error {
	//TODO implement me
	panic("implement me")
}

func (a artistRepository) DeleteArtist(ctx context.Context, s string) error {
	//TODO implement me
	panic("implement me")
}
