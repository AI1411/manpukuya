package entity

import (
	"time"

	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

type User struct {
	ID        uuid.UUID `gorm:"type:uuid;primary_key;default:uuid_generate_v4()"`
	Username  string
	Email     string
	Password  []byte
	CreatedAt time.Time
	UpdatedAt time.Time
}

type UserWithToken struct {
	User  *User
	Token string
}

func NewUser(
	userName string,
	email string,
	password []byte,
) *User {
	return &User{
		Username: userName,
		Email:    email,
		Password: password,
	}
}

func (u *User) SetPassword() error {
	p, err := bcrypt.GenerateFromPassword(u.Password, bcrypt.DefaultCost)
	if err != nil {
		return err
	}
	u.Password = p
	return nil
}
