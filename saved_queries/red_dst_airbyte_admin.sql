CREATE USER airbyte WITH PASSWORD <>;

GRANT CREATE ON DATABASE dev TO airbyte; 
GRANT usage, create on SCHEMA public TO airbyte;
GRANT SELECT ON TABLE SVV_TABLE_INFO TO airbyte;

SELECT  current_database()
