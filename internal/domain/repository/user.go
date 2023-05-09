package repository

import (
	"context"

	userEntity "github.com/AI1411/manpukuya/internal/domain/entity"
)

type UserRepository interface {
	Login(context.Context, string, string) (string, error)
	Register(context.Context, *userEntity.User) (*userEntity.UserWithToken, error)
	Logout(context.Context, string) error
}
