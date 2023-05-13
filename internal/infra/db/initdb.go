package db

import (
	"context"
	"fmt"
	"log"
	"math/rand"
	"time"

	"github.com/joho/godotenv"

	"github.com/AI1411/manpukuya/internal/domain/entity"
	"github.com/AI1411/manpukuya/internal/infra/env"
	"github.com/AI1411/manpukuya/internal/infra/logger"
)

func InitDB() {
	ctx := context.Background()
	err := godotenv.Load()
	e, err := env.NewValue()
	if err != nil {
		log.Fatalf("failed to load env: %v", err)
	}

	zapLogger, _ := logger.NewLogger(e.Debug)
	dbClient := NewClient(&e.DB, zapLogger)

	// all genres
	var genres []entity.Genre
	err = dbClient.Conn(ctx).Find(&genres).Error
	if err != nil {
		log.Fatalf("failed to get genres: %v", err)
	}
	// all artists
	var artists []entity.Artist
	err = dbClient.Conn(ctx).Find(&artists).Error
	if err != nil {
		log.Fatalf("failed to get artists: %v", err)
	}

	randomStock := rand.Intn(10)
	randomPrice := rand.Intn(10000)

	min := -365 * 5
	max := 365 * 5
	days := rand.Intn(max-min+1) + min
	randomDate := time.Now().AddDate(0, 0, days)

	// truncate
	err = dbClient.Conn(ctx).Exec("TRUNCATE TABLE products CASCADE").Error
	if err != nil {
		log.Fatalf("failed to truncate products: %v", err)
	}

	products := make([]*entity.Product, len(genres)*len(artists))
	for i, genre := range genres {
		for j, artist := range artists {
			products[i*len(artists)+j] = entity.NewProduct(
				fmt.Sprintf("product%d", i*len(artists)+j+1),
				fmt.Sprintf("description%d", i*len(artists)+j+1),
				artist.ID,
				genre.ID,
				randomDate,
				uint32(randomStock),
				uint32(randomPrice),
			)
		}
	}

	// bulk insert
	err = dbClient.Conn(ctx).Create(&products).Error
	if err != nil {
		log.Fatalf("failed to insert products: %v", err)
	}
}
