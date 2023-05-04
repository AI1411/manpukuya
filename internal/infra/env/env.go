package env

import (
	"fmt"

	"github.com/kelseyhightower/envconfig"
	"github.com/pkg/errors"
)

type Values struct {
	DB
	Env        string `default:"local" split_words:"true"`
	Debug      bool   `default:"true" split_words:"true"`
	ServerPort string `required:"true" split_words:"true"`
}

type DB struct {
	PostgresHost     string `required:"true" split_words:"true"`
	PostgresPort     string `required:"true" split_words:"true"`
	PostgresDatabase string `required:"true" split_words:"true"`
	PostgresUser     string `required:"true" split_words:"true"`
	PostgresPassword string `required:"true" split_words:"true"`
}

func NewValue() (*Values, error) {
	var v Values
	err := envconfig.Process("MANPUKUYA", &v)
	if err != nil {
		s := fmt.Sprintf("need to set all env values %+v", v)
		return nil, errors.Wrap(err, s)
	}
	return &v, nil
}
