package entity

import "github.com/google/uuid"

type Genre struct {
	ID        uuid.UUID
	GenreName string
	Slag      string
}

func NewGenre(genreName string, slag string) *Genre {
	return &Genre{
		ID:        uuid.New(),
		GenreName: genreName,
		Slag:      slag,
	}
}

func (g *Genre) SetID(id uuid.UUID) {
	g.ID = id
}

func (g *Genre) SetGenreName(genreName string) {
	g.GenreName = genreName
}

func (g *Genre) SetSlag(slag string) {
	g.Slag = slag
}

func (g *Genre) GetID() uuid.UUID {
	if g != nil {
		return g.ID
	}
	return uuid.Nil
}

func (g *Genre) GetIDString() string {
	if g != nil {
		return g.ID.String()
	}
	return ""
}

func (g *Genre) GetGenreName() string {
	if g != nil {
		return g.GenreName
	}
	return ""
}

func (g *Genre) GetSlag() string {
	if g != nil {
		return g.Slag
	}
	return ""
}
