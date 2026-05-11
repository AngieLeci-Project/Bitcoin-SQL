CREATE DATABASE bitcoin;

USE bitcoin;

CREATE TABLE bitcoin_price_raw (
    btc_date TEXT,
    open_price TEXT,
    high_price TEXT,
    low_price TEXT,
    close_price TEXT,
    volume TEXT,
    close_time TEXT,
    quote_asset_volume TEXT,
    number_of_trades TEXT,
    taker_buy_base_asset_volume TEXT,
    taker_buy_quote_asset_volume TEXT,
    ignore_column TEXT
);

CREATE TABLE bitcoin_price (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    btc_date DATETIME,
    open_price DECIMAL (18,2),
    high_price DECIMAL (18,2),
    low_price DECIMAL (18,2),
    close_price DECIMAL (18,2),
    volume DOUBLE,
    close_time DATETIME,
    quote_asset_volume DOUBLE,
    number_of_trades BIGINT,
    taker_buy_base_asset_volume DOUBLE,
    taker_buy_quote_asset_volume DOUBLE,
    ignore_column INT
    );

INSERT INTO bitcoin_price (
    btc_date,
    open_price,
    high_price,
    low_price,
    close_price,
    volume,
    close_time,
    quote_asset_volume,
    number_of_trades,
    taker_buy_base_asset_volume,
    taker_buy_quote_asset_volume,
    ignore_column
)

SELECT
    STR_TO_DATE(REPLACE(btc_date, ' UTC', ''), '%Y-%m-%d %H:%i:%s.%f'), #replace utc
    
    open_price,
    high_price,
    low_price,
    close_price,
    volume,

    STR_TO_DATE(REPLACE(close_time, ' UTC', ''), '%Y-%m-%d %H:%i:%s.%f'),

    quote_asset_volume,
    number_of_trades,
    taker_buy_base_asset_volume,
    taker_buy_quote_asset_volume,
    ignore_column

FROM bitcoin_price_raw;

SELECT *
FROM bitcoin_price
LIMIT 10;
#view data

SELECT COUNT(*) AS total_rows
FROM bitcoin_price;
#check total rows

SELECT *
FROM bitcoin_price
WHERE close_price IS NULL
	OR volume IS NULL;
#check missing value

SELECT
	MIN(btc_date) AS start_date,
    MAX(btc_date) AS end_date
FROM bitcoin_price;
#See date range

SELECT
    ROUND(AVG(close_price), 2) AS avg_close_price
FROM bitcoin_price;
#Aerage closing price

SELECT
	MAX(close_price) AS highest_price
FROM bitcoin_price;
#higest closing price

SELECT
	MIN(close_price) AS lowest_price
FROM bitcoin_price;
#lowest closing prce

SELECT 
	btc_date,
    open_price,
    close_price,
    ROUND(close_price - open_price, 2) AS prce_change
FROM bitcoin_price;bitcoin_price
#measure daily gain/loss

SELECT
	btc_date,
    close_price,
    LAG(close_price) OVER (
		ORDER BY btc_date
	) AS previous_close,
    ROUND (
		(
			(close_price - LAG(close_price) OVER (
            ORDER BY btc_date
            ))
            /
            LAG(close_price) OVER (
            ORDER BY btc_date
				)
			) * 100,
            2
		) AS daily_return_percentage
	FROM bitcoin_price;
#daily return percentage

SELECT 
	SUM(volume) AS total_volume
FROM bitcoin_price
ORDER by total_volume DESC;
#total trading volume

SELECT
	btc_date,
    volume
FROM bitcoin_price
ORDER BY volume DESC
LIMIT 20;
#most active trading day

SELECT
	btc_date,
    close_price,
    ROUND (AVG(close_price) OVER (
				ORDER BY btc_date
                ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
			),
            2
            ) AS MA_7D
	FROM bitcoin_price;
#7 day moving average

SELECT
    btc_date,
    ROUND(
        ((close_price - open_price) / open_price) * 100,
        2
    ) AS return_pct
FROM bitcoin_price
ORDER BY return_pct DESC
LIMIT 10;
#best performing day

SELECT
	ROUND(AVG(close_price), 2) AS average_price,
    ROUND(AVG(volume),0) AS average_volume
FROM bitcoin_price;

WITH returns AS (
    SELECT
        ROUND(((close_price - open_price) / open_price) * 100,
            2
        ) AS daily_return
    FROM bitcoin_price
)
SELECT
    ROUND(AVG(daily_return), 2) AS avg_return
FROM returns
ORDER BY avg_return DESC;
#average percentage bitcoin price change in a day