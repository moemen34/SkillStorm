CREATE TABLE Investment(
    ID IDENTITY,
    Symbol VARCHAR(10),
    order_type VARCHAR(4) Check in ('buy', 'sell')
    shares_num INT,
    price Numeric idk,
    order_date DateTime
)

CREATE TABLE Daily_Data (
    Symbol VARCHAR(10),
    day DateTime,
    day_open Numeric,
    day_close numeric,
    day_high numeric,
    day_low numeric
)

CREATE TABLE Account(
    
)