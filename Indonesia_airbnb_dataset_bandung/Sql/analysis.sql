-- 1. Data Integrity: Audit Anomali Scraping

SELECT 
    location_group,
    COUNT(*) AS total_listing,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS percentage_share
FROM clean_airbnb_bandung
GROUP BY location_group;

-- 2. Market Overview: Segmentasi Tipe Properti & Benchmark Harga

SELECT 
    property_type,
    COUNT(*) AS total_listings,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price_idr)::NUMERIC, 0) AS median_price_idr,
    ROUND(AVG(price_idr), 0) AS avg_price_idr,
    MIN(price_idr) AS min_price_idr,
    MAX(price_idr) AS max_price_idr,
    ROUND(AVG(rating), 2) AS avg_rating
FROM clean_airbnb_bandung
WHERE location_group = 'Bandung Raya'
GROUP BY property_type
HAVING COUNT(*) >= 5
ORDER BY total_listings DESC;


-- 3. Geographical Pricing: Top 10 Kecamatan Terpopuler
SELECT 
    district,
    wilayah,
    COUNT(*) AS total_listings,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price_idr)::NUMERIC, 0) AS median_price_idr,
    ROUND(AVG(rating), 2) AS avg_rating,
    SUM(jumlah_review) AS total_market_reviews
FROM clean_airbnb_bandung
WHERE location_group = 'Bandung Raya'
GROUP BY district, wilayah
ORDER BY total_listings DESC
LIMIT 10;


-- 4. Opportunity Finder: Identifikasi Properti "Hidden Gem"

WITH market_benchmark AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price_idr) AS overall_median_price
    FROM clean_airbnb_bandung
    WHERE location_group = 'Bandung Raya'
)
SELECT 
    c.listing_title,
    c.property_type,
    c.district,
    c.price_idr,
    c.rating,
    c.jumlah_review,
    c.link
FROM clean_airbnb_bandung c
CROSS JOIN market_benchmark m
WHERE c.location_group = 'Bandung Raya'
  AND c.rating >= 4.90
  AND c.jumlah_review >= 20
  AND c.price_idr < m.overall_median_price
ORDER BY c.rating DESC, c.jumlah_review DESC
LIMIT 10;