-- a script to remember the commands I used to prepare my database

-- for database used by life buddies, create the user and give them privilegies
-- on that database only. for now to simplify setup, only one user that has
-- full permissions on db
CREATE DATABASE redacted;

CREATE ROLE redacted LOGIN PASSWORD redacted;

REVOKE CONNECT ON DATABASE redacted FROM PUBLIC;

GRANT CONNECT ON DATABASE redacted TO redacted;

GRANT USAGE ON SCHEMA redacted TO redacted;

GRANT CREATE ON SCHEMA redacted TO redacted;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA redacted TO redacted;

ALTER DEFAULT PRIVILEGES IN SCHEMA redacted
  GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO redacted;
