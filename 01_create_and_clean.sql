-- Toman Bike Share Data Cleaning Script
-- Tools: SQLite

-- Load raw data (assumes CSVs imported or use pandas/SQLite as done)
-- This script documents the transformation logic

-- 1. Combine year 0 (2021) and year 1 (2022) datasets
-- 2. Join with cost_table for price and COGS
-- 3. Derive calculated fields

CREATE TABLE IF NOT EXISTS cost_table (
    yr INTEGER PRIMARY KEY,
    price REAL,
    COGS REAL
);

-- Insert cost data
INSERT OR REPLACE INTO cost_table (yr, price, COGS) VALUES
(0, 3.99, 1.24),
(1, 4.99, 1.56);

-- Cleaned rides table
CREATE TABLE IF NOT EXISTS cleaned_rides AS
SELECT 
    r.dteday,
    -- Parse date (DD/MM/YYYY format)
    date(substr(r.dteday, 7, 4) || '-' || 
         printf('%02d', CAST(substr(r.dteday, instr(r.dteday, '/') + 1, 
         instr(substr(r.dteday, instr(r.dteday, '/') + 1), '/') - 1) AS INT)) || '-' ||
         printf('%02d', CAST(substr(r.dteday, 1, instr(r.dteday, '/') - 1) AS INT))) AS date,
    r.season,
    CASE r.season 
        WHEN 1 THEN 'Winter'
        WHEN 2 THEN 'Spring'
        WHEN 3 THEN 'Summer'
        WHEN 4 THEN 'Fall'
    END AS season_name,
    r.yr,
    CASE r.yr WHEN 0 THEN 2021 WHEN 1 THEN 2022 END AS year,
    r.mnth AS month,
    r.hr AS hour,
    r.holiday,
    r.weekday,
    CASE r.weekday 
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS weekday_name,
    r.workingday,
    r.weathersit,
    CASE r.weathersit
        WHEN 1 THEN 'Clear'
        WHEN 2 THEN 'Mist/Cloudy'
        WHEN 3 THEN 'Light Rain/Snow'
        WHEN 4 THEN 'Heavy Rain/Snow'
    END AS weather,
    r.temp,
    r.atemp,
    r.hum,
    r.windspeed,
    r.rider_type,
    r.riders,
    c.price,
    c.COGS,
    ROUND(r.riders * c.price, 2) AS revenue,
    ROUND(r.riders * c.COGS, 2) AS cost,
    ROUND(r.riders * (c.price - c.COGS), 2) AS profit
FROM raw_rides r
JOIN cost_table c ON r.yr = c.yr;

-- Sample KPIs
-- Total Revenue by Year
SELECT year, ROUND(SUM(revenue), 2) AS total_revenue, ROUND(SUM(profit), 2) AS total_profit
FROM cleaned_rides
GROUP BY year;

-- Hourly Revenue Analysis
SELECT hour, ROUND(SUM(revenue), 2) AS hourly_revenue, SUM(riders) AS total_riders
FROM cleaned_rides
GROUP BY hour
ORDER BY hour;

-- Seasonal Revenue
SELECT season_name, year, ROUND(SUM(revenue), 2) AS seasonal_revenue
FROM cleaned_rides
GROUP BY season_name, year
ORDER BY year, season;

-- Rider Demographics (by type)
SELECT rider_type, year, SUM(riders) AS total_riders, 
       ROUND(SUM(revenue), 2) AS revenue,
       ROUND(100.0 * SUM(riders) / (SELECT SUM(riders) FROM cleaned_rides WHERE year = c.year), 1) AS pct_of_year
FROM cleaned_rides c
GROUP BY rider_type, year;
