package entity

import "github.com/google/uuid"

type Artist struct {
	ID         uuid.UUID
	ArtistName string
	Slag       string
}

type ListArtistCondition struct {
	ArtistName string
	Limit      int32
	Offset     int32
}

func NewArtist(artistName string, slag string) *Artist {
	return &Artist{
		ArtistName: artistName,
		Slag:       slag,
	}
}

func NewListArtistCondition(artistName string, limit, offset int32) *ListArtistCondition {
	return &ListArtistCondition{
		ArtistName: artistName,
		Limit:      limit,
		Offset:     offset,
	}
}

func (a *Artist) SetID(id uuid.UUID) {
	a.ID = id
}

func (a *Artist) SetArtistName(artistName string) {
	a.ArtistName = artistName
}

func (a *Artist) SetSlag(slag string) {
	a.Slag = slag
}

func (a *Artist) GetID() uuid.UUID {
	if a != nil {
		return a.ID
	}
	return uuid.Nil
}

func (a *Artist) GetIDString() string {
	if a != nil {
		return a.ID.String()
	}
	return ""
}

func (a *Artist) GetArtistName() string {
	if a != nil {
		return a.ArtistName
	}
	return ""
}

func (a *Artist) GetSlag() string {
	if a != nil {
		return a.Slag
	}
	return ""
}
