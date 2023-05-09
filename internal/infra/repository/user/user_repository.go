package user

import (
	"context"
	"errors"

	"go.uber.org/zap"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"

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

func (u *userRepository) Login(ctx context.Context, email, password string) (string, error) {
	var ue *userEntity.User
	if err := u.dbClient.Conn(ctx).Where("email", email).First(&ue).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return "", err
		}
		return "", err
	}

	if err := bcrypt.CompareHashAndPassword(ue.Password, []byte(password)); err != nil {
		return "", err
	}

	token, err := domain.GenerateToken(ue.ID.String())
	if err != nil {
		return "", err
	}

	return token, nil
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
