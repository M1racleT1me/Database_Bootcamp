SET search_path TO data;

WITH 
indicators AS (
    SELECT 
        (SELECT id FROM indicator WHERE name = 'Population of country') AS population_id,
        (SELECT id FROM indicator WHERE name = 'Unemployment rate') AS unemployment_id,
        (SELECT id FROM indicator WHERE name = 'Infected humans COVID-19') AS covid_id
),
countries AS (
    SELECT id AS country_id FROM country WHERE object_type = 'country'
),
population_data AS (
    SELECT
        c.country_id AS c_id,
        (SELECT population_id FROM indicators) AS i_id,
        date_series AS actual_date,
        FLOOR(RANDOM() * 1000001)::INTEGER AS value
    FROM countries c
    CROSS JOIN generate_series(
        '2019-01-01'::DATE, 
        '2019-12-01'::DATE, 
        INTERVAL '1 month'
    ) AS date_series
),
unemployment_data AS (
    SELECT
        c.country_id AS c_id,
        (SELECT unemployment_id FROM indicators) AS i_id,
        date_series AS actual_date,
        ROUND((RANDOM() * 100)::NUMERIC, 2) AS value
    FROM countries c
    CROSS JOIN generate_series(
        '2019-01-01'::DATE, 
        '2019-12-01'::DATE, 
        INTERVAL '1 month'
    ) AS date_series
),
covid_data AS (
    SELECT
        c.country_id AS c_id,
        (SELECT covid_id FROM indicators) AS i_id,
        date_series AS actual_date,
        FLOOR(RANDOM() * 51)::INTEGER AS value
    FROM countries c
    CROSS JOIN generate_series(
        '2020-05-01'::DATE, 
        '2020-08-31'::DATE, 
        INTERVAL '1 day'
    ) AS date_series
),
all_data AS (
    SELECT * FROM population_data
    UNION ALL
    SELECT * FROM unemployment_data
    UNION ALL
    SELECT * FROM covid_data
),
data_with_ids AS (
    SELECT
        (SELECT COALESCE(MAX(id), 0) FROM country_indicator) 
        + ROW_NUMBER() OVER (ORDER BY c_id, i_id, actual_date) AS new_id,
        c_id,
        i_id,
        value,
        actual_date
    FROM all_data
)
INSERT INTO country_indicator (id, c_id, i_id, value, actual_date)
SELECT new_id, c_id, i_id, value, actual_date
FROM data_with_ids;