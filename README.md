# Bitcoin Market Analysis — SQL

Analyzing Bitcoin price trends and market behavior using MySQL and window functions.

---

## Overview

This project explores historical Bitcoin price data through structured SQL queries. A MySQL database was designed from scratch to store and query BTC market data, extracting meaningful insights on price trends, trading volume, and market performance over time.

---

## Key Insights

- Extracted daily returns, 7-day moving averages, and cumulative volume trends
- Identified best and worst performing trading days using window functions
- Analyzed price volatility across multi-year historical data
- Computed average daily price change percentage across the full dataset

---


## Dataset

- **Source:** btc 1d.csv
- **Columns:** Date, Open, High, Low, Close, Volume, Number of Trades, and more

---

## 🔄 Workflow

```
1. Database Design
   - Created bitcoin_price_raw (staging table)
   - Created bitcoin_price (cleaned table with proper data types)
        ↓
2. Data Loading & Cleaning
   - Converted TEXT columns to DECIMAL, DATETIME, BIGINT
   - Parsed and cleaned UTC timestamps
        ↓
3. Exploratory Analysis
   - Total rows, date range, missing values
   - Average, highest, lowest closing price
        ↓
4. Advanced Queries
   - Daily return percentage (LAG window function)
   - 7-day moving average (ROWS BETWEEN)
   - Best/worst performing days
   - Most active trading days by volume
   - Average daily price change (CTE)
```

---

## 📂 Project Structure

```
Bitcoin-SQL/
│
├── bitcoin.sql    # Full SQL script (schema + queries)
└── README.md
```

---

## 🚀 How to Run

1. Clone this repository
   ```bash
   git clone https://github.com/AngieLeci-Project/Bitcoin-SQL.git
   ```

2. Open MySQL Workbench or any MySQL client

3. Run the script
   ```sql
   SOURCE bitcoin.sql;
   ```

4. Import your BTC dataset CSV into `bitcoin_price_raw`, then run the INSERT statement to populate `bitcoin_price`

---

## 💡 Key Queries

| Query | SQL Concept Used |
|-------|-----------------|
| Daily return % | `LAG()` window function |
| 7-day moving average | `ROWS BETWEEN 6 PRECEDING AND CURRENT ROW` |
| Best performing days | `ORDER BY return_pct DESC` |
| Average price change | CTE + `AVG()` |
| Most active trading days | `ORDER BY volume DESC` |
