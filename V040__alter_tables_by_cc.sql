SET search_path TO data;

ALTER TABLE country
    ADD CONSTRAINT chk_country_time_start
    CHECK (time_start >= '1972-01-01 00:00:00'::TIMESTAMP),
    ADD CONSTRAINT chk_country_time_end
    CHECK (time_end <= '9999-01-01 00:00:00'::TIMESTAMP);

ALTER TABLE indicator
    ADD CONSTRAINT chk_indicator_time_start
    CHECK (time_start >= '1972-01-01 00:00:00'::TIMESTAMP),
    ADD CONSTRAINT chk_indicator_time_end
    CHECK (time_end <= '9999-01-01 00:00:00'::TIMESTAMP),
    ADD CONSTRAINT chk_indicator_unit CHECK (unit IN ('percent', 'human'));

ALTER TABLE country_indicator
    ADD CONSTRAINT chk_country_indicator_value
    CHECK (value >= 0),
    ALTER COLUMN value SET NOT NULL;