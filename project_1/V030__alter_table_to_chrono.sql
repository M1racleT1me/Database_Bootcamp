SET search_path TO data;

ALTER TABLE country
    ADD COLUMN time_start TIMESTAMP NOT NULL DEFAULT '1972-01-01 00:00:00',
    ADD COLUMN time_end TIMESTAMP NOT NULL DEFAULT '9999-01-01 00:00:00';

COMMENT ON COLUMN country.time_start IS 'Represents the first contact with humanity';
COMMENT ON COLUMN country.time_end IS 'Default value represents an open-ended period';

ALTER TABLE indicator
    ADD COLUMN time_start TIMESTAMP NOT NULL DEFAULT '1972-01-01 00:00:00',
    ADD COLUMN time_end TIMESTAMP NOT NULL DEFAULT '9999-01-01 00:00:00';

COMMENT ON COLUMN indicator.time_start IS 'Represents the first contact with humanity';
COMMENT ON COLUMN indicator.time_end IS 'Default value represents an open-ended period';