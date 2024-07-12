-- Create the view
CREATE VIEW Account_summary AS
WITH LatestData AS (
    SELECT
        Symbol,
        [Date],
        [Close],
        ROW_NUMBER() OVER (PARTITION BY Symbol ORDER BY [Date] DESC) AS RowNum
    FROM
        Monthly_Data
),
LatestClose AS (
    SELECT
        Symbol,
        [Close] as Current_value
    FROM
        LatestData
    WHERE
        RowNum = 1
),
AggregatedData AS (
    SELECT
        Symbol,
        SUM(CASE WHEN Buy_Sell = 'BUY' THEN Number_of_Shares ELSE 0 END) OVER (PARTITION BY Symbol) AS Total_Bought,
        SUM(CASE WHEN Buy_Sell = 'SELL' THEN Number_of_Shares ELSE 0 END) OVER (PARTITION BY Symbol) AS Total_Sold,
        AVG(CASE WHEN Buy_Sell = 'SELL' THEN Price ELSE NULL END) OVER (PARTITION BY Symbol) AS Avg_Sell_Price,
        SUM(CASE WHEN Buy_Sell = 'BUY' THEN Price * Number_of_Shares ELSE 0 END) OVER (PARTITION BY Symbol) / NULLIF(SUM(CASE WHEN Buy_Sell = 'BUY' THEN Number_of_Shares ELSE 0 END) OVER (PARTITION BY Symbol), 0) AS Avg_Buy_Price
    FROM
        Orders
),
AggregatedResults AS (
    SELECT DISTINCT
        Symbol,
        Total_Bought AS Shares_Bought,
        Total_Sold AS Shares_Sold,
        Avg_Buy_Price,
        Avg_Sell_Price,
        (Avg_Sell_Price - Avg_Buy_Price) * Total_Sold AS Profit
    FROM
        AggregatedData
)

SELECT
    L.Symbol,
    L.Current_value,
    A.Shares_Bought,
    A.Shares_Sold,
    A.Avg_Buy_Price,
    A.Avg_Sell_Price,
    A.Profit
FROM
    LatestClose L
    JOIN AggregatedResults A ON L.Symbol = A.Symbol;