CREATE TABLE `influential-bit-412922.trips_data_all.green_tripdata` as
  SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2019`;

SELECT * FROM `influential-bit-412922.trips_data_all.green_tripdata` LIMIT 100;

CREATE TABLE `influential-bit-412922.trips_data_all.yellow_tripdata` as
  SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`;

SELECT * FROM `influential-bit-412922.trips_data_all.green_tripdata` LIMIT 100;

INSERT INTO `influential-bit-412922.trips_data_all.green_tripdata`
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2020`;

INSERT INTO `influential-bit-412922.trips_data_all.yellow_tripdata`
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2020`;


-- Fixes yellow table schema
-- Run no more than 4 at a time
ALTER TABLE `influential-bit-412922.trips_data_all.yellow_tripdata`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `influential-bit-412922.trips_data_all.yellow_tripdata`
  RENAME COLUMN pickup_datetime TO tpep_pickup_datetime;
ALTER TABLE `influential-bit-412922.trips_data_all.yellow_tripdata`
  RENAME COLUMN dropoff_datetime TO tpep_dropoff_datetime;
ALTER TABLE `influential-bit-412922.trips_data_all.yellow_tripdata`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `influential-bit-412922.trips_data_all.yellow_tripdata`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `influential-bit-412922.trips_data_all.yellow_tripdata`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `influential-bit-412922.trips_data_all.yellow_tripdata`
  RENAME COLUMN dropoff_location_id TO DOLocationID;

-- Fixes green table schema
-- Run no more than 4 at a time
ALTER TABLE `influential-bit-412922.trips_data_all.green_tripdata`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `influential-bit-412922.trips_data_all.green_tripdata`
  RENAME COLUMN pickup_datetime TO lpep_pickup_datetime;
ALTER TABLE `influential-bit-412922.trips_data_all.green_tripdata`
  RENAME COLUMN dropoff_datetime TO lpep_dropoff_datetime;
ALTER TABLE `influential-bit-412922.trips_data_all.green_tripdata`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `influential-bit-412922.trips_data_all.green_tripdata`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `influential-bit-412922.trips_data_all.green_tripdata`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `influential-bit-412922.trips_data_all.green_tripdata`
  RENAME COLUMN dropoff_location_id TO DOLocationID;

-- fhv trip data
CREATE OR REPLACE EXTERNAL TABLE `influential-bit-412922.trips_data_all.fhv_tripdata_2019` 
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://week3-data-ware-house/fhv/fhv_tripdata_2019-*.parquet']
);

CREATE OR REPLACE EXTERNAL TABLE `influential-bit-412922.trips_data_all.fhv_tripdata` (
  dispatching_base_num STRING,
  pickup_datetime DATETIME,
  dropoff_datetime DATETIME,
  PUlocationID FLOAT64,
  DOlocationID FLOAT64,
  SR_Flag FLOAT64,
  Affiliated_base_number STRING
)
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://week3-data-ware-house/fhv/fhv_tripdata_2019-*.parquet']
);

SELECT COUNT(1) FROM `influential-bit-412922.trips_data_all.fhv_tripdata`;

SELECT * FROM `influential-bit-412922.trips_data_all.fhv_tripdata` LIMIT 500;

SELECT * REPLACE (
  CAST(0 AS FLOAT64) AS SR_Flag
) FROM `influential-bit-412922.trips_data_all.fhv_tripdata` LIMIT 500;


SELECT COUNT(1) FROM `influential-bit-412922.dbt_dj_production.fact_trips`;
SELECT COUNT(1) FROM `influential-bit-412922.dbt_dj_production.taxi_zone_lookup`;

SELECT COUNT(1) FROM `influential-bit-412922.dbt_ny_taxi.stg_green_tripdata`;
SELECT COUNT(1) FROM `influential-bit-412922.dbt_ny_taxi.stg_yellow_tripdata`;

SELECT DISTINCT (Payment_type) FROM `influential-bit-412922.trips_data_all.green_tripdata`;
SELECT DISTINCT (Payment_type) FROM `influential-bit-412922.trips_data_all.yellow_tripdata`;

