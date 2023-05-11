package server

import (
	"context"

	"github.com/bufbuild/connect-go"
	"go.uber.org/zap"

	v1 "github.com/AI1411/manpukuya/gen/artist/v1"
	"github.com/AI1411/manpukuya/internal/domain/repository"
	"github.com/AI1411/manpukuya/internal/infra/db"
	"github.com/AI1411/manpukuya/internal/usecase/artist"
)

type ArtistServer struct {
	dbClient   db.Client
	zapLogger  *zap.Logger
	artistRepo repository.ArtistRepository
}

func NewArtistServer(dbClient db.Client, zapLogger *zap.Logger, artistRepo repository.ArtistRepository) *ArtistServer {
	return &ArtistServer{
		dbClient:   dbClient,
		zapLogger:  zapLogger,
		artistRepo: artistRepo,
	}
}

func (s *ArtistServer) GetArtist(context.Context, *connect.Request[v1.GetArtistRequest]) (*connect.Response[v1.GetArtistResponse], error) {
	panic("implement me")
}

func (s *ArtistServer) ListArtists(ctx context.Context, in *connect.Request[v1.ListArtistsRequest]) (*connect.Response[v1.ListArtistsResponse], error) {
	uc := artist.NewListArtistUsecase(s.artistRepo)
	artists, err := uc.Exec(ctx, in)
	if err != nil {
		return nil, err
	}

	return artists, nil
}

func (s *ArtistServer) CreateArtist(context.Context, *connect.Request[v1.CreateArtistRequest]) (*connect.Response[v1.CreateArtistResponse], error) {
	panic("implement me")
}

func (s *ArtistServer) UpdateArtist(context.Context, *connect.Request[v1.UpdateArtistRequest]) (*connect.Response[v1.UpdateArtistResponse], error) {
	panic("implement me")
}

func (s *ArtistServer) DeleteArtist(context.Context, *connect.Request[v1.DeleteArtistRequest]) (*connect.Response[v1.DeleteArtistResponse], error) {
	panic("implement me")
}
