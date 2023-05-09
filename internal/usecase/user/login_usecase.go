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

func (u *loginUsecase) Exec(
	ctx context.Context,
	in *connect.Request[userv1.LoginRequest],
) (*connect.Response[userv1.LoginResponse], error) {
	res, err := u.userRepository.Login(ctx, in.Msg.GetEmail(), in.Msg.GetPassword())
	if err != nil {
		return nil, err
	}

	return &connect.Response[userv1.LoginResponse]{
		Msg: &userv1.LoginResponse{
			Token: res,
		},
	}, nil
}
