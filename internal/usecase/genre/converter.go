package genre

import (
	genrev1 "github.com/AI1411/manpukuya/gen/genre/v1"
	"github.com/AI1411/manpukuya/internal/domain/entity"
)

func ToGRPC(p *entity.Genre) *genrev1.Genre {
	return &genrev1.Genre{
		Id:        p.GetIDString(),
		GenreName: p.GetGenreName(),
		Slag:      p.GetSlag(),
	}
}
