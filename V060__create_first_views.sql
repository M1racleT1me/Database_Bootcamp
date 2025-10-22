SET search_path TO data;

CREATE OR REPLACE VIEW v_dictionary_unit AS
SELECT
    d.id,
    d.value
FROM dictionary d
WHERE dic_name = 'unit' 
    AND time_start <= CURRENT_TIMESTAMP 
    AND time_end >= CURRENT_TIMESTAMP
ORDER BY order_num;

COMMENT ON VIEW v_dictionary_unit IS 'View for actual measurement units, sorted by order_num';
COMMENT ON COLUMN v_dictionary_unit.id IS 'Unique dictionary record identifier';
COMMENT ON COLUMN v_dictionary_unit.value IS 'Measurement unit value';

CREATE OR REPLACE VIEW v_dictionary_land AS
SELECT
    d.id,
    d.value
FROM dictionary d
WHERE dic_name = 'land' 
    AND time_start <= CURRENT_TIMESTAMP 
    AND time_end >= CURRENT_TIMESTAMP
ORDER BY order_num;

COMMENT ON VIEW v_dictionary_land IS 'View for actual object types (land), sorted by order_num';
COMMENT ON COLUMN v_dictionary_land.id IS 'Unique dictionary record identifier';
COMMENT ON COLUMN v_dictionary_land.value IS 'Object type (country/continent)';