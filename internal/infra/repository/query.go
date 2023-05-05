package repository

import (
	"fmt"
	"reflect"
	"time"

	"gorm.io/gorm"
)

func AddWhereEq(query *gorm.DB, columnName string, value interface{}) *gorm.DB {
	if isNilOrEmpty(value) {
		return query
	}
	return query.Where(fmt.Sprintf("%s = ?", columnName), value)
}

func AddWhereGte(query *gorm.DB, columnName string, value interface{}) *gorm.DB {
	if isNilOrEmpty(value) {
		return query
	}
	return query.Where(fmt.Sprintf("%s >= ?", columnName), value)
}

func AddWhereLte(query *gorm.DB, columnName string, value interface{}) *gorm.DB {
	if isNilOrEmpty(value) {
		return query
	}
	return query.Where(fmt.Sprintf("%s <= ?", columnName), value)
}

func AddWhereLike(query *gorm.DB, columnName string, value string) *gorm.DB {
	if isNilOrEmpty(value) {
		return query
	}
	return query.Where(fmt.Sprintf("%s LIKE ?", columnName), "%"+value+"%")
}

func AddWhereIn(query *gorm.DB, columnName string, values interface{}, includeNull bool) *gorm.DB {
	if isNilOrEmpty(values) {
		return query
	}
	if includeNull {
		return query.Where(fmt.Sprintf("(%s IN (?) OR %s IS NULL)", columnName, columnName), values)
	}
	return query.Where(fmt.Sprintf("%s IN (?)", columnName), values)
}

func AddOffset(query *gorm.DB, offset int32) *gorm.DB {
	if isNilOrEmpty(offset) {
		return query
	}
	return query.Offset(int(offset))
}

func isNilOrEmpty(x interface{}) bool {
	if x == nil {
		return true
	}
	wkTypeName := fmt.Sprintf("%T", x)
	switch wkTypeName {
	case "bool", "uint", "uint8", "uint16", "uint32", "uint64", "int", "int8", "int16", "int32", "int64",
		"float32", "float64", "complex64", "complex128", "byte", "uintptr", "error":
		return false
	case "rune", "string":
		if x == "" {
			return true
		}
		return false
	case "time.Time":
		return x.(time.Time).IsZero()
	}
	xVal := reflect.ValueOf(x)
	if xVal.IsNil() {
		return true
	}

	if xVal.Kind() == reflect.Slice {
		if xVal.Len() == 0 {
			return true
		}
	}

	return false
}

func AddLimit(query *gorm.DB, limit int32) *gorm.DB {
	if isNilOrEmpty(limit) {
		return query
	}
	return query.Limit(int(limit))
}
