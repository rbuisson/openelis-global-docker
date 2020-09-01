#!/bin/bash

set -eu

function create_user_and_database() {
	local database=$1
	local user=$2
	local password=$3
	echo "  Creating '$user' user and '$database' database..."
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" $POSTGRES_DB <<-EOSQL
	    CREATE USER $user WITH UNENCRYPTED PASSWORD '$password';
			ALTER ROLE $user WITH superuser;
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $user;
EOSQL
}

create_user_and_database ${OPENELIS_DB_NAME} ${OPENELIS_DB_USER} ${OPENELIS_DB_PASSWORD}

import_dump() {
	psql -v ON_ERROR_STOP=1 --username "$OPENELIS_DB_USER" $OPENELIS_DB_NAME -f /var/postgresql/resources/OpenELIS-Global.sql
}

import_dump ${OPENELIS_DB_NAME} ${OPENELIS_DB_USER} ${OPENELIS_DB_PASSWORD}
