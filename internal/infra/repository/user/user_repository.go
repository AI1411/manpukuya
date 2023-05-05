package user

import (
	"context"

	"go.uber.org/zap"

	"github.com/AI1411/manpukuya/internal/domain"
	userEntity "github.com/AI1411/manpukuya/internal/domain/entity"
	userRepo "github.com/AI1411/manpukuya/internal/domain/repository"
	"github.com/AI1411/manpukuya/internal/infra/db"
)

type userRepository struct {
	dbClient  db.Client
	zapLogger *zap.Logger
}

func NewUserRepository(dbClient db.Client, zapLogger *zap.Logger) userRepo.UserRepository {
	return &userRepository{
		dbClient:  dbClient,
		zapLogger: zapLogger,
	}
}

func (u *userRepository) Login(ctx context.Context, user *userEntity.User) (string, error) {
	//TODO implement me
	panic("implement me")
}

func (u *userRepository) Register(ctx context.Context, user *userEntity.User) (*userEntity.UserWithToken, error) {
	err := user.SetPassword()
	if err != nil {
		return nil, err
	}

	if err = u.dbClient.Conn(ctx).Create(user).Error; err != nil {
		return nil, err
	}

	// generate token
	token, err := domain.GenerateToken(user.ID.String())
	if err != nil {
		return nil, err
	}

	userWithToken := &userEntity.UserWithToken{
		User:  user,
		Token: token,
	}

	return userWithToken, nil
}

func (u *userRepository) Logout(ctx context.Context, token string) error {
	//TODO implement me
	panic("implement me")
}
