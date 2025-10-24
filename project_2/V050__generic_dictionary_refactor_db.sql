SET search_path TO data;

CREATE TABLE dictionary (
    id BIGINT NOT NULL,
    dic_name VARCHAR(100) NOT NULL,
    value VARCHAR(100) NOT NULL,
    order_num INTEGER NOT NULL DEFAULT 0,
    time_start TIMESTAMP NOT NULL DEFAULT '1972-01-01 00:00:00',
    time_end TIMESTAMP NOT NULL DEFAULT '9999-01-01 00:00:00',
    CONSTRAINT pk_dictionary_id PRIMARY KEY (id),
    CONSTRAINT uq_dictionary_dic_name_value UNIQUE (dic_name, value),
    CONSTRAINT chk_dictionary_time_start
    CHECK (time_start >= '1972-01-01 00:00:00'::TIMESTAMP),
    CONSTRAINT chk_dictionary_time_end
    CHECK (time_end <= '9999-01-01 00:00:00'::TIMESTAMP)
);

COMMENT ON TABLE dictionary IS 'General table for storing dictionaries';
COMMENT ON COLUMN dictionary.id IS 'Unique record identifier';
COMMENT ON COLUMN dictionary.dic_name IS 'Dictionary name';
COMMENT ON COLUMN dictionary.value IS 'Value in the dictionary';
COMMENT ON COLUMN dictionary.order_num IS 'Order number for sorting (default 0)';
COMMENT ON COLUMN dictionary.time_start IS 'Record start date';
COMMENT ON COLUMN dictionary.time_end IS 'Record end date';

INSERT INTO dictionary (id, dic_name, value, order_num)
SELECT
    COALESCE(MAX(id), 0) + 1,
    'unit',
    'human',
    0
FROM dictionary;

INSERT INTO dictionary (id, dic_name, value, order_num)
SELECT
    COALESCE(MAX(id), 0) + 1,
    'unit',
    'percent',
    1
FROM dictionary;

INSERT INTO dictionary (id, dic_name, value, order_num)
SELECT
    COALESCE(MAX(id), 0) + 1,
    'land',
    'country',
    0
FROM dictionary;

INSERT INTO dictionary (id, dic_name, value, order_num)
SELECT
    COALESCE(MAX(id), 0) + 1,
    'land',
    'continent',
    1
FROM dictionary;

INSERT INTO dictionary (id, dic_name, value, order_num)
SELECT
    COALESCE(MAX(id), 0) + 1,
    'unit',
    'square kilometer',
    2
FROM dictionary;

ALTER TABLE indicator 
    ADD COLUMN unit_id BIGINT;

UPDATE indicator i
SET unit_id = d.id
FROM dictionary d
WHERE d.dic_name = 'unit' AND d.value = i.unit;

ALTER TABLE indicator 
    DROP CONSTRAINT IF EXISTS chk_indicator_unit;

ALTER TABLE indicator 
    DROP COLUMN unit;

ALTER TABLE indicator
    ADD CONSTRAINT fk_indicator_unit_id
    FOREIGN KEY (unit_id) REFERENCES dictionary(id)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

INSERT INTO indicator (name, unit_id)
SELECT
    'Area of the land',
    d.id
FROM dictionary d
WHERE d.dic_name = 'unit' AND d.value = 'square kilometer';

ALTER TABLE country 
    ADD COLUMN object_type_id BIGINT;

UPDATE country c
SET object_type_id = d.id
FROM dictionary d
WHERE d.dic_name = 'land' AND d.value = c.object_type;

ALTER TABLE country 
    DROP CONSTRAINT IF EXISTS chk_country_object_type;

ALTER TABLE country 
    DROP COLUMN object_type;

ALTER TABLE country
    ADD CONSTRAINT fk_country_object_type_id
    FOREIGN KEY (object_type_id) REFERENCES dictionary(id)
    ON DELETE RESTRICT ON UPDATE RESTRICT;