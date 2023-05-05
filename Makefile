cp-schema:
	cat ./DDL/*.sql > ./DDL/scripts/schema.sql
generate:
	buf generate proto