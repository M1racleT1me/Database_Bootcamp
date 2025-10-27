SET search_path TO data;

CREATE SEQUENCE seq_country 
    INCREMENT 10
    OWNED BY country.id;

SELECT setval('seq_country', COALESCE(MAX(id), 0))
FROM country;

ALTER TABLE country 
    ALTER COLUMN id SET DEFAULT nextval('seq_country');

CREATE SEQUENCE seq_indicator 
    INCREMENT 10
    OWNED BY indicator.id;

SELECT setval('seq_indicator', COALESCE(MAX(id), 0))
FROM indicator;

ALTER TABLE indicator 
    ALTER COLUMN id SET DEFAULT nextval('seq_indicator');

CREATE SEQUENCE seq_country_indicator 
    INCREMENT 10
    OWNED BY country_indicator.id;

SELECT setval('seq_country_indicator', COALESCE(MAX(id), 0))
FROM country_indicator;

ALTER TABLE country_indicator 
    ALTER COLUMN id SET DEFAULT nextval('seq_country_indicator');