package genre

import (
	"context"

	"github.com/bufbuild/connect-go"

	genrev1 "github.com/AI1411/manpukuya/gen/genre/v1"
	"github.com/AI1411/manpukuya/internal/domain/repository"
)

type ListGenreUsecase interface {
	Exec(ctx context.Context) (*connect.Response[genrev1.ListGenresResponse], error)
}

type listGenreUsecase struct {
	genreRepository repository.GenreRepository
}

func NewListGenreUsecase(genreRepository repository.GenreRepository) ListGenreUsecase {
	return &listGenreUsecase{
		genreRepository: genreRepository,
	}
}

func (u *listGenreUsecase) Exec(ctx context.Context) (*connect.Response[genrev1.ListGenresResponse], error) {
	genres, err := u.genreRepository.ListGenres(ctx)
	if err != nil {
		return nil, err
	}

	res := make([]*genrev1.Genre, len(genres))
	for i, genre := range genres {
		res[i] = ToGRPC(&genre)
	}

	return &connect.Response[genrev1.ListGenresResponse]{
		Msg: &genrev1.ListGenresResponse{
			Genres: res,
		},
	}, nil
}
