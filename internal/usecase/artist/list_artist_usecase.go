package artist

import (
	"context"

	"github.com/bufbuild/connect-go"

	artistv1 "github.com/AI1411/manpukuya/gen/artist/v1"
	"github.com/AI1411/manpukuya/internal/domain/entity"
	"github.com/AI1411/manpukuya/internal/domain/repository"
)

type ListArtistUsecase interface {
	Exec(context.Context, *connect.Request[artistv1.ListArtistsRequest]) (*connect.Response[artistv1.ListArtistsResponse], error)
}

type listArtistUsecase struct {
	artistRepository repository.ArtistRepository
}

func NewListArtistUsecase(artistRepository repository.ArtistRepository) ListArtistUsecase {
	return &listArtistUsecase{
		artistRepository: artistRepository,
	}
}

func (l listArtistUsecase) Exec(ctx context.Context, in *connect.Request[artistv1.ListArtistsRequest]) (*connect.Response[artistv1.ListArtistsResponse], error) {
	nc := entity.NewListArtistCondition(in.Msg.GetArtistName(), in.Msg.GetLimit(), in.Msg.GetOffset())
	artists, err := l.artistRepository.ListArtists(ctx, nc)
	if err != nil {
		return nil, err
	}

	a := make([]*artistv1.Artist, len(artists))

	for i, artist := range artists {
		a[i] = &artistv1.Artist{
			Id:         artist.ID.String(),
			ArtistName: artist.GetArtistName(),
			Slag:       artist.GetSlag(),
		}
	}

	res := &connect.Response[artistv1.ListArtistsResponse]{
		Msg: &artistv1.ListArtistsResponse{
			Artists: a,
		},
	}

	return res, nil
}
