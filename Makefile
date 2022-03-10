postgresql :
	docker run --name postgres-simplebank -p 5432:5432 -e POSTGRES_USER=root POSTGRES_PASSWORD=secret -d postgres

execdb :
	docker exec -it postgres-simplebank psql simple_bank

createdb :
	docker exec -it postgres-simplebank createdb --username=root --owner=root simple_bank

initmigrate :
	migrate create -ext sql -dir db/migration -seq init_schema

migrateup :
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown :
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc :
	sqlc generate

.PHONY : postgresql execdb createdb initmigrate migrateup migratedown