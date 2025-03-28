#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- 1. Grant privileges
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;
    
    -- 2. Create the exact table your backend needs
    CREATE TABLE IF NOT EXISTS "user" (
        id SERIAL PRIMARY KEY,
        username VARCHAR(50) UNIQUE NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL
    );
    
    -- 3. Grant table permissions
    GRANT ALL PRIVILEGES ON TABLE "user" TO $POSTGRES_USER;
    GRANT USAGE, SELECT ON SEQUENCE user_id_seq TO $POSTGRES_USER;
EOSQL