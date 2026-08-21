# Bandung Raya Airbnb Market Dynamics and Valuation Analysis

An end-to-end data analytics project evaluating accommodation pricing structures, amenity value add, and market demand density across Bandung Raya using PostgreSQL, Python, and statistical visualizations.

---

## Executive Summary
* **Geographical Disparity:** Highland areas command the highest pricing power, led by **Cimenyan (Rp 12.8M median)**, **Parompong (Rp 11.2M)**, and **Lembang (Rp 8.7M)** due to scenic villa clusters. Urban transit districts like **Sumur Bandung (Rp 2.9M)** and **Cicendo (Rp 3.0M)** serve high-frequency budget travelers.
* **Amenity Value Add:** Integrating **Private Pool** facilities drives a **+90.4% price premium** (Median Rp 10.8M vs Rp 5.7M), while optimizing for **Large Family/Group** accommodation yields a **+159.2% premium**.
* **Market Demand Sweet Spot:** High-transaction density (measured via total review volume proxy) heavily concentrates within the **Rp 1.5M - Rp 6.5M per night** window.
* **Data Hygiene (Scraping Bleed):** Identified and filtered **31.1% (178 rows)** of out-of-scope listings (Bogor/Puncak) mistakenly included in the raw dataset, preserving local market integrity across 394 clean Bandung listings.

---

## Market Dynamics Dashboard

<p align="center">
  <img src="./airbnb_bandung_minimalist.png" alt="Bandung Airbnb Market Dynamics" width="100%">
</p>

---

## Tech Stack and Workflow
* **Database and Ingestion:** PostgreSQL (Staging DDL, Regex Data Cleansing, Schema Constraints).
* **Analytics and NLP Extraction:** Python (Pandas, NumPy, regular expressions for unstructured text).
* **Data Visualization:** Matplotlib and Seaborn (Minimalist styling, Distribution Boxplots, Elasticity Scatter).

---

## Repository Structure
```text
├── data/
│   ├── AirBnB_BandungRaya_All.csv    # Raw scraped dataset
│   └── clean_airbnb_bandung.csv      # Processed clean dataset
├── sql/
│   ├── data_cleaning.sql             # Ingestion and cleaning DDL
│   └── analysis.sql                  # Business metric queries
├── airbnb_bandung_minimalist.png     # Visual summary asset
├── notebook.ipynb                    # Feature extraction and visualization code
└── README.md
