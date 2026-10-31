# Toman Bike Share Dashboard

![Dashboard Preview](images/dashboard_preview.png)

## Project Overview

This project delivers a comprehensive performance dashboard for **Toman Bike Share**, designed to support informed decision-making through key performance metrics.

The dashboard answers critical business questions around hourly revenue patterns, profit and revenue trends, seasonal performance, and rider demographics. It was built in response to a formal request for a preliminary analytics solution that could be delivered quickly while remaining easy to navigate and visually consistent with professional standards.

**Project Purpose:** Portfolio project demonstrating end-to-end data analysis skills — from data cleaning with SQL to interactive dashboard creation in Excel.

---

## Key Performance Indicators (KPIs)

| KPI                    | 2021          | 2022          | YoY Change |
|------------------------|---------------|---------------|------------|
| Total Riders           | 1,243,103     | 2,049,576     | +64.9%     |
| Total Revenue          | $4,959,981    | $10,227,384   | +106.2%    |
| Total Profit           | $3,418,533    | $7,030,046    | +105.6%    |
| Profit Margin          | ~68.9%        | ~68.7%        | Stable     |
| Avg Revenue per Ride   | $3.99         | $4.99         | +$1.00     |
| Casual Riders          | 247,252       | 372,765       | +50.8%     |
| Registered Riders      | 995,851       | 1,676,811     | +68.4%     |

**Overall (2021–2022):**
- **Total Riders:** 3,292,679
- **Total Revenue:** $15,187,365
- **Total Profit:** $10,448,579
- **Overall Profit Margin:** ~68.8%

---

## Dashboard

The interactive Excel dashboard (`dashboard/Toman_Bike_Share_Dashboard.xlsx`) contains four sheets:

1. **Dashboard** – Executive view with KPI cards, hourly revenue analysis, seasonal comparison, rider mix, and monthly trend charts.
2. **Cleaned Data** – Sample of the prepared dataset (full cleaned CSV available in `/data`).
3. **Key Insights & Recommendations** – Narrative findings and pricing recommendation for the following year.
4. **KPI Summary** – Clean comparison table of year-over-year metrics.

**Design notes:** Professional teal color palette, clear visual hierarchy, and easy navigation across sheets.

---

## Business Questions Answered

1. **Hourly Revenue Analysis**  
   When are the peak and off-peak hours? How should staffing and fleet distribution respond?

2. **Profit and Revenue Trends**  
   How did revenue and profit evolve month-by-month and year-over-year? What was the impact of the 2022 price increase?

3. **Seasonal Revenue**  
   Which seasons drive the most revenue? How can the business mitigate winter seasonality?

4. **Rider Demographics**  
   What is the split between casual and registered riders? How is each segment growing?

5. **Pricing Recommendation**  
   Should Toman Bike Share raise prices again next year? By how much?

---

## Dataset

Two yearly ride-level files plus a cost table:

| File                     | Description                                      | Records   |
|--------------------------|--------------------------------------------------|-----------|
| `bike_share_yr_0.csv`    | Hourly rides for 2021 (yr = 0)                   | 17,290    |
| `bike_share_yr_1.csv`    | Hourly rides for 2022 (yr = 1)                   | 17,468    |
| `cost_table.csv`         | Price & COGS by year                             | 2         |

**Key fields:**
- `dteday`, `season`, `yr`, `mnth`, `hr`
- `holiday`, `weekday`, `workingday`
- `weathersit`, `temp`, `atemp`, `hum`, `windspeed`
- `rider_type` (casual / registered)
- `riders` (count)

**Derived metrics:**
- `revenue` = riders × price
- `cost` = riders × COGS
- `profit` = revenue − cost

---

## Tools Used

| Stage              | Tool          | Purpose                                      |
|--------------------|---------------|----------------------------------------------|
| Data Cleaning      | **SQL (SQLite)** | Combining years, joining cost table, deriving revenue/profit, standardizing labels |
| Dashboard & Viz    | **Microsoft Excel** | KPI cards, charts (bar, line, pie), insights, formatting |
| Supporting analysis| Python (pandas) | Validation, aggregation, and Excel generation |

---

## Workbook Structure

```
Toman_Bike_Share_Dashboard.xlsx
├── Dashboard                 ← Main interactive view (KPIs + charts)
├── Cleaned Data              ← Sample of prepared records
├── Key Insights & Recommendations
└── KPI Summary               ← Year-over-year comparison table
```

---

## Data Preparation

1. Combined `bike_share_yr_0.csv` and `bike_share_yr_1.csv` into a single table.
2. Joined with `cost_table.csv` on `yr` to attach price and COGS.
3. Created derived columns:
   - `year` (2021 / 2022)
   - `season_name` (Winter / Spring / Summer / Fall)
   - `weekday_name`
   - `weather` (Clear / Mist/Cloudy / Light Rain/Snow / Heavy Rain/Snow)
   - `revenue`, `cost`, `profit`
4. Validated nulls, date formats, and aggregate totals.
5. Exported cleaned dataset as `data/cleaned_bike_share.csv` and SQLite database `data/bike_share.db`.

SQL transformation logic is documented in `sql/01_create_and_clean.sql`.

---

## Analysis Areas

- **Hourly Revenue Analysis** – Revenue, riders, and profit by hour of day (0–23).
- **Profit & Revenue Trends** – Monthly time series comparison between 2021 and 2022.
- **Seasonal Revenue** – Performance by season and year.
- **Rider Demographics** – Casual vs Registered volume, revenue share, and growth rates.
- **Pricing Impact** – Effect of moving from $3.99 to $4.99 on volume and profitability.

---

## Selected Observations

1. **Peak demand windows** are clearly visible at 08:00 and 17:00–18:00, aligning with typical commute patterns.
2. **Summer and Fall** are the strongest seasons; Winter underperforms significantly.
3. **Registered riders** account for roughly 80% of total rides and the bulk of revenue, yet **casual riders** showed strong absolute growth in 2022.
4. The **25% price increase** in 2022 was accompanied by a **65% increase in ridership**, indicating robust demand.
5. Profit margins remained stable (~69%), suggesting the higher price did not materially increase relative costs.

**Pricing Recommendation for Next Year:**  
A moderate increase of **8–12%** (target range $5.49–$5.69) is recommended, paired with loyalty incentives for registered users and off-peak pricing experiments. Large jumps should be avoided to protect casual volume.

**Estimated Timeline:**
- Preliminary dashboard (current deliverable): 3–5 days
- Full interactive version with filters & live connections: 2–3 weeks
- Monthly refresh + forecasting module: ~1 week per cycle

---

## Files

```
Toman-Bike-Share-Dashboard/
├── README.md
├── data/
│   ├── cleaned_bike_share.csv      # Fully prepared dataset
│   ├── bike_share.db               # SQLite database
│   ├── bike_share_yr_0.csv         # Original 2021 data
│   ├── bike_share_yr_1.csv         # Original 2022 data
│   └── cost_table.csv              # Price & COGS
├── sql/
│   └── 01_create_and_clean.sql     # Cleaning & transformation script
├── dashboard/
│   └── Toman_Bike_Share_Dashboard.xlsx
└── images/                         # Optional screenshots
```

---

## Project Purpose

This repository was created as a **portfolio project** to demonstrate practical data analysis skills required in industry:

- Translating a business request into concrete analytical deliverables
- Cleaning and transforming real-world data with SQL
- Building a clear, professional Excel dashboard
- Extracting actionable insights and making a pricing recommendation
- Documenting the entire process for reproducibility and stakeholder communication

---

## Author

**Adewunmi Joseph**  
Data Analysis Student  
Boycode Africa · Stellar Academy  

---

*Built in response to the Toman Bike Share dashboard request. Preliminary version delivered for rapid decision support.*
