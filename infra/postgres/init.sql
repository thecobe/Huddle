-- Eseguito solo alla prima creazione del volume.
-- huddle_owner: proprietario dello schema, usato per le migrazioni.
-- huddle_app:   ruolo applicativo, NON bypassa la Row Level Security.
CREATE ROLE huddle_app LOGIN PASSWORD 'huddle_app' NOSUPERUSER NOBYPASSRLS;
GRANT CONNECT ON DATABASE huddle TO huddle_app;

CREATE DATABASE huddle_test OWNER huddle_owner;
GRANT CONNECT ON DATABASE huddle_test TO huddle_app;
