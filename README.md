# Bitcoin Market Analysis — SQL

Analyzing Bitcoin price trends and market behavior using MySQL and window functions.

---

## Overview

This project explores historical Bitcoin (BTC/USDT) price data through structured SQL queries. A MySQL database was designed from scratch to store and query 2,997 daily candlestick records spanning **2018–2026**, extracting meaningful insights on price trends, trading volume, and market performance over time.

---

## Key Insights

- Extracted daily returns, 7-day moving averages, and cumulative volume trends across 8 years of BTC data
- Identified best and worst performing trading days using window functions
- Computed average daily price change percentage across the full dataset
- Handled full ETL pipeline — raw text ingestion → type-cast cleaned table → analytics

---

## Dataset

- **Source:** btc 1d.csv
- **Columns:** Open, High, Low, Close, Volume, Number of Trades, Quote Asset Volume, and more

---

## Workflow

```
1. Database Design
   - Created bitcoin_price_raw (staging table, all TEXT)
   - Created bitcoin_price (cleaned table with proper data types)
        ↓
2. Data Loading & Cleaning
   - Converted TEXT → DECIMAL, DATETIME, BIGINT, DOUBLE
   - Parsed and stripped UTC timestamps using STR_TO_DATE()
        ↓
3. Exploratory Analysis
   - Total rows, date range, missing values
   - Average, highest, lowest closing price
        ↓
4. Advanced Queries
   - Daily return % (LAG window function)
   - 7-day moving average (ROWS BETWEEN)
   - Best/worst performing days
   - Most active trading days by volume
   - Average daily price change (CTE)
```

---

## Key Queries

| Query | SQL Concept Used |
|-------|-----------------|
| Daily return % | `LAG()` window function |
| 7-day moving average | `ROWS BETWEEN 6 PRECEDING AND CURRENT ROW` |
| Best performing days | `ORDER BY return_pct DESC` |
| Average price change | CTE + `AVG()` |
| Most active trading days | `ORDER BY volume DESC LIMIT 20` |
