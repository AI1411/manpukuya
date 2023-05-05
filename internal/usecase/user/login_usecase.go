package user

import (
	"context"

	"github.com/bufbuild/connect-go"

	userv1 "github.com/AI1411/manpukuya/gen/user/v1"
	"github.com/AI1411/manpukuya/internal/domain/repository"
)

type LoginUsecase interface {
	Exec(ctx context.Context, request *connect.Request[userv1.LoginRequest]) (*connect.Response[userv1.LoginResponse], error)
}

type loginUsecase struct {
	userRepository repository.UserRepository
}

func NewLoginUsecase(userRepository repository.UserRepository) LoginUsecase {
	return &loginUsecase{
		userRepository: userRepository,
	}
}

func (l *loginUsecase) Exec(
	ctx context.Context,
	in *connect.Request[userv1.LoginRequest],
) (*connect.Response[userv1.LoginResponse], error) {
	panic("implement me")
}
