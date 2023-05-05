package server

import (
	"context"

	"github.com/bufbuild/connect-go"
	"go.uber.org/zap"

	userv1 "github.com/AI1411/manpukuya/gen/user/v1"
	"github.com/AI1411/manpukuya/internal/domain/repository"
	"github.com/AI1411/manpukuya/internal/infra/db"
	"github.com/AI1411/manpukuya/internal/usecase/user"
)

type UserServer struct {
	dbClient  db.Client
	zapLogger *zap.Logger
	userRepo  repository.UserRepository
}

func NewUserServer(
	dbClient db.Client,
	zapLogger *zap.Logger,
	userRepo repository.UserRepository,
) *UserServer {
	return &UserServer{
		dbClient:  dbClient,
		zapLogger: zapLogger,
		userRepo:  userRepo,
	}
}

func (u *UserServer) GetUser(ctx context.Context, in *connect.Request[userv1.GetUserRequest]) (*connect.Response[userv1.GetUserResponse], error) {
	//TODO implement me
	panic("implement me")
}

func (u *UserServer) ListUsers(ctx context.Context, in *connect.Request[userv1.ListUsersRequest]) (*connect.Response[userv1.ListUsersResponse], error) {
	panic("implement me")
}

func (u *UserServer) CreateUser(ctx context.Context, in *connect.Request[userv1.CreateUserRequest]) (*connect.Response[userv1.CreateUserResponse], error) {
	panic("implement me")
}

func (u *UserServer) UpdateUser(ctx context.Context, in *connect.Request[userv1.UpdateUserRequest]) (*connect.Response[userv1.UpdateUserResponse], error) {
	panic("implement me")
}

func (u *UserServer) DeleteUser(ctx context.Context, in *connect.Request[userv1.DeleteUserRequest]) (*connect.Response[userv1.DeleteUserResponse], error) {
	panic("implement me")
}

func (u *UserServer) ChangeUserStatus(ctx context.Context, in *connect.Request[userv1.ChangeUserStatusRequest]) (*connect.Response[userv1.ChangeUserStatusResponse], error) {
	panic("implement me")
}

func (u *UserServer) Login(ctx context.Context, in *connect.Request[userv1.LoginRequest]) (*connect.Response[userv1.LoginResponse], error) {
	//TODO implement me
	panic("implement me")
}

func (u *UserServer) Register(ctx context.Context, in *connect.Request[userv1.RegisterRequest]) (*connect.Response[userv1.RegisterResponse], error) {
	uc := user.NewRegisterUsecase(u.userRepo)
	res, err := uc.Exec(ctx, in)
	if err != nil {
		u.zapLogger.Error(err.Error())
		return nil, err
	}

	return res, nil
}

func (u *UserServer) Logout(ctx context.Context, in *connect.Request[userv1.LogoutRequest]) (*connect.Response[userv1.LogoutResponse], error) {
	panic("implement me")
}
