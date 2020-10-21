#!/bin/sh -x

goal_createDB() {
    docker run --rm --name postgress -e POSTGRES_PASSWORD=sorravit -p5432:5432 -d postgres:13
}

goal_deleteDB() {
    docker kill postgress
}

goal_migrateDB() {
    gradle flywayMigrate
}

if type -t "goal_$1" &>/dev/null; then
  goal_$1 ${@:-2}
else
    echo "usage: $0 <goal>
    goal:
        createDB           -- create database in docker container in the background
        deleteDB           -- delete the database
        migrateDB          -- migrate the database
        "
  exit 1
fi