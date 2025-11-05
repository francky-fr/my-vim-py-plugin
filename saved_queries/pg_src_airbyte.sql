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

SHOW wal_level
SHOW wal_keep_size
SHOW  max_slot_wal_keep_size
SELECT pg_current_wal_lsn();

SELECT pg_walfile_name(pg_current_wal_lsn());
SHOW rds.logical_wal_cache;

SELECT version();
SHOW apg_write_forward.idle_session_timeout;
SHOW max_wal_size

SELECT * FROM pg_replication_slots WHERE slot_name = ('airbyte_slot') AND plugin = ('pgoutput') AND database = ('skcr_db')

SELECT CASE WHEN pg_is_in_recovery() THEN pg_last_wal_receive_lsn() ELSE pg_current_wal_lsn() END AS pg_current_wal_lsn;

SELECT pg_last_wal_receive_lsn()
SELECT pg_current_wal_lsn()

-- From https://stormatics.tech/blogs/logical-replication-in-postgresql#:~:text=confirmed_flush_lsn%20is%20the%20wal%20lsn,record%20number%20on%20the%20publisher.
SELECT slot_name, active, confirmed_flush_lsn, Pg_current_wal_lsn(),
	Pg_size_pretty(Pg_wal_lsn_diff(Pg_current_wal_lsn(), restart_lsn)) AS retained_walsize,
	Pg_size_pretty(Pg_wal_lsn_diff(Pg_current_wal_lsn(), confirmed_flush_lsn)) AS subscriber_lag
FROM pg_replication_slots

SELECT
  slot_name,
  active,
  confirmed_flush_lsn,
  pg_wal_lsn_diff(confirmed_flush_lsn, '0/0') AS confirmed_flush_lsn_int,
  pg_current_wal_lsn() AS current_lsn,
  pg_wal_lsn_diff(pg_current_wal_lsn(), '0/0') AS current_lsn_int,
  pg_size_pretty(pg_wal_lsn_diff(pg_current_wal_lsn(), restart_lsn)) AS retained_walsize,
  pg_size_pretty(pg_wal_lsn_diff(pg_current_wal_lsn(), confirmed_flush_lsn)) AS subscriber_lag
FROM pg_replication_slots;


ALTER TABLE api_match REPLICA IDENTITY DEFAULT;
ALTER PUBLICATION airbyte_publication ADD TABLE api_match;

ALTER TABLE api_team REPLICA IDENTITY DEFAULT;
ALTER PUBLICATION airbyte_publication ADD TABLE api_team;

ALTER TABLE api_competition REPLICA IDENTITY DEFAULT;
ALTER PUBLICATION airbyte_publication ADD TABLE api_competition;

ALTER TABLE api_competitionedition REPLICA IDENTITY DEFAULT;
ALTER PUBLICATION airbyte_publication ADD TABLE api_competitionedition;

ALTER TABLE api_season REPLICA IDENTITY DEFAULT;
ALTER PUBLICATION airbyte_publication ADD TABLE api_season;
