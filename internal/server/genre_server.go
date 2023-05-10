package server

import (
	"context"

	"github.com/bufbuild/connect-go"
	"go.uber.org/zap"

	genrev1 "github.com/AI1411/manpukuya/gen/genre/v1"
	"github.com/AI1411/manpukuya/internal/domain/repository"
	"github.com/AI1411/manpukuya/internal/infra/db"
	"github.com/AI1411/manpukuya/internal/usecase/genre"
)

type GenreServer struct {
	dbClient  db.Client
	zapLogger *zap.Logger
	genreRepo repository.GenreRepository
}

func NewGenreServer(
	dbClient db.Client,
	zapLogger *zap.Logger,
	genreRepo repository.GenreRepository,
) *GenreServer {
	return &GenreServer{
		dbClient:  dbClient,
		zapLogger: zapLogger,
		genreRepo: genreRepo,
	}
}

func (s *GenreServer) GetGenre(ctx context.Context, in *connect.Request[genrev1.GetGenreRequest]) (*connect.Response[genrev1.GetGenreResponse], error) {
	//TODO implement me
	panic("implement me")
}

func (s *GenreServer) ListGenres(ctx context.Context, in *connect.Request[genrev1.ListGenresRequest]) (*connect.Response[genrev1.ListGenresResponse], error) {
	uc := genre.NewListGenreUsecase(s.genreRepo)
	res, err := uc.Exec(ctx)
	if err != nil {
		s.zapLogger.Error(err.Error())
		return nil, err
	}
	return res, nil
}

func (s *GenreServer) CreateGenre(ctx context.Context, in *connect.Request[genrev1.CreateGenreRequest]) (*connect.Response[genrev1.CreateGenreResponse], error) {
	//TODO implement me
	panic("implement me")
}

func (s *GenreServer) UpdateGenre(ctx context.Context, in *connect.Request[genrev1.UpdateGenreRequest]) (*connect.Response[genrev1.UpdateGenreResponse], error) {
	//TODO implement me
	panic("implement me")
}

func (s *GenreServer) DeleteGenre(ctx context.Context, in *connect.Request[genrev1.DeleteGenreRequest]) (*connect.Response[genrev1.DeleteGenreResponse], error) {
	//TODO implement me
	panic("implement me")
}
