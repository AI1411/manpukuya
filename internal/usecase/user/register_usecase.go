package user

import (
	"context"

	"github.com/bufbuild/connect-go"
	"google.golang.org/protobuf/types/known/timestamppb"

	userv1 "github.com/AI1411/manpukuya/gen/user/v1"
	userEntity "github.com/AI1411/manpukuya/internal/domain/entity"
	"github.com/AI1411/manpukuya/internal/domain/repository"
)

type RegisterUsecase interface {
	Exec(ctx context.Context, request *connect.Request[userv1.RegisterRequest]) (*connect.Response[userv1.RegisterResponse], error)
}

type registerUsecase struct {
	userRepository repository.UserRepository
}

func NewRegisterUsecase(userRepository repository.UserRepository) RegisterUsecase {
	return &registerUsecase{
		userRepository: userRepository,
	}
}

func (u *registerUsecase) Exec(
	ctx context.Context,
	in *connect.Request[userv1.RegisterRequest],
) (*connect.Response[userv1.RegisterResponse], error) {
	nu := userEntity.NewUser(in.Msg.GetUsername(), in.Msg.GetEmail(), []byte(in.Msg.GetPassword()))

	res, err := u.userRepository.Register(ctx, nu)
	if err != nil {
		return nil, err
	}

	return &connect.Response[userv1.RegisterResponse]{
		Msg: &userv1.RegisterResponse{
			User: &userv1.User{
				Id:        res.User.ID.String(),
				Username:  res.User.Username,
				Email:     res.User.Email,
				Password:  string(res.User.Password),
				CreatedAt: timestamppb.New(res.User.CreatedAt),
				UpdatedAt: timestamppb.New(res.User.UpdatedAt),
			},
			Token: res.Token,
		},
	}, nil
}
