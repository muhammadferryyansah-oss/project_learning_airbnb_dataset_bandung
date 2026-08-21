
DROP TABLE IF EXISTS clean_airbnb_bandung;

CREATE TABLE clean_airbnb_bandung AS
SELECT
    
    SPLIT_PART(nama, ' in ', 1) AS property_type,
    
    
    TRIM(REPLACE(SPLIT_PART(SPLIT_PART(nama, ' in ', 2), ' - ', 1), 'Kecamatan ', '')) AS district,
    TRIM(SUBSTRING(nama FROM POSITION(' - ' IN nama) + 3)) AS listing_title,
    REGEXP_REPLACE(harga, '[^0-9]', '', 'g')::BIGINT AS price_idr,
    
    CASE 
        WHEN rating ~ '^[0-9]+(\.[0-9]+)?$' THEN rating::NUMERIC(3, 2)
        ELSE NULL 
    END AS rating,
    
    CASE 
        WHEN rating ILIKE '%New%' THEN TRUE 
        ELSE FALSE 
    END AS is_new_listing,
    
    jumlah_review,
    link,
    wilayah,
    
    CASE 
        WHEN TRIM(REPLACE(SPLIT_PART(SPLIT_PART(nama, ' in ', 2), ' - ', 1), 'Kecamatan ', '')) 
             IN ('Megamendung', 'Cisarua', 'Babakan Madang', 'Bogor Selatan', 'Bogor Timur', 'Bogor Tengah', 'Bogor Barat', 'Pamijahan', 'Caringin')
        THEN 'Non-Bandung (Bogor/Puncak)'
        ELSE 'Bandung Raya'
    END AS location_group

FROM stg_airbnb_bandung;