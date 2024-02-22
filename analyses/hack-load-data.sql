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
CREATE OR REPLACE EXTERNAL TABLE `influential-bit-412922.trips_data_all.fhv_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://week3-data-ware-house/fhv/fhv_tripdata_2019-*.parquet']
);