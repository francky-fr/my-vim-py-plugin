-- Setup phase
CREATE USER airbyte PASSWORD <>;

GRANT USAGE ON SCHEMA public TO airbyte;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO airbyte;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO airbyte;

-- ALTER USER airbyte REPLICATION => What docs provides, but N/A on RDS, use instead :
GRANT rds_replication TO airbyte;

SELECT pg_create_logical_replication_slot('airbyte_slot', 'pgoutput');
ALTER TABLE api_player REPLICA IDENTITY DEFAULT;
CREATE PUBLICATION airbyte_publication FOR TABLE api_player;


-- Monitoring
SELECT * FROM pg_replication_slots WHERE slot_name = 'airbyte_slot';

SHOW wal_keep_size
SHOW  max_slot_wal_keep_size
SELECT pg_current_wal_lsn();

SELECT pg_walfile_name(pg_current_wal_lsn());
