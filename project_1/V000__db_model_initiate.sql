CREATE SCHEMA IF NOT EXISTS data AUTHORIZATION data;
SET search_path TO data;

CREATE TABLE country (
  id BIGINT NOT NULL,
  name VARCHAR(100) NOT NULL,
  par_id BIGINT,
  object_type VARCHAR(50) NOT NULL DEFAULT 'country',
  CONSTRAINT pk_country_id PRIMARY KEY (id),
  CONSTRAINT fk_country_par_id FOREIGN KEY (par_id) REFERENCES country(id),
  CONSTRAINT uk_country_name_obj_type UNIQUE (name, object_type),
  CONSTRAINT chk_country_object_type CHECK (object_type IN ('country', 'continent'))
);

COMMENT ON TABLE country IS 'Hierarchical dictionary of countries and continents';
COMMENT ON COLUMN country.id IS 'Unique identifier of a country/continent';
COMMENT ON COLUMN country.name IS 'Official name of the country/continent';
COMMENT ON COLUMN country.par_id IS 'Reference to the parent continent';
COMMENT ON COLUMN country.object_type IS 'Type of the object: "country" or "continent"';

CREATE TABLE indicator (
  id BIGINT NOT NULL,
  name VARCHAR(100) NOT NULL UNIQUE,
  unit VARCHAR(50) NOT NULL,
  CONSTRAINT pk_indicator_id PRIMARY KEY (id)
);

COMMENT ON TABLE indicator IS 'Reference table of measurable metrics/indicators';
COMMENT ON COLUMN indicator.id IS 'Unique identifier for the indicator';
COMMENT ON COLUMN indicator.name IS 'Unique name for an indicator';
COMMENT ON COLUMN indicator.unit IS 'Measurement unit for an indicator';

CREATE TABLE country_indicator (
  id BIGINT NOT NULL,
  c_id BIGINT NOT NULL,
  i_id BIGINT NOT NULL,
  value NUMERIC,
  actual_date TIMESTAMP NOT NULL,
  CONSTRAINT pk_country_indicator_id PRIMARY KEY (id),
  CONSTRAINT fk_country_indicator_c_id FOREIGN KEY (c_id) REFERENCES country(id),
  CONSTRAINT fk_country_indicator_i_id FOREIGN KEY (i_id) REFERENCES indicator(id),
  CONSTRAINT uk_country_indicator_record UNIQUE (c_id, i_id, actual_date)
);

COMMENT ON TABLE country_indicator IS 'Historical measurements of indicators for specific countries with timestamps';
COMMENT ON COLUMN country_indicator.id IS 'Unique record identifier for measurement entry';
COMMENT ON COLUMN country_indicator.c_id IS 'Reference to country.id - where measurement was taken';
COMMENT ON COLUMN country_indicator.i_id IS 'Reference to indicator.id - what metric was measured';
COMMENT ON COLUMN country_indicator.value IS 'Numeric value of the measurement';
COMMENT ON COLUMN country_indicator.actual_date IS 'Timestamp when measurement was recorded';

