CREATE DATABASE InvestmentPortfolio;
GO

use InvestmentPortfolio;

-- Dimension Tables
CREATE TABLE Investment (
    Symbol NVARCHAR(10) PRIMARY KEY,
    Type NVARCHAR(20),
    IndexName NVARCHAR(20)  
);
GO

CREATE TABLE Monthly_Data (
    Symbol NVARCHAR(10),
    Date DATE,
    [Open] DECIMAL(18, 2),  
    [Close] DECIMAL(18, 2),  
    High DECIMAL(18, 2),  
    Low DECIMAL(18, 2),  
    PRIMARY KEY (Symbol, Date),
    FOREIGN KEY (Symbol) REFERENCES Investment(Symbol)
);
GO

CREATE TABLE Take_Profit (
    Target_ID INT IDENTITY PRIMARY KEY,
    Symbol NVARCHAR(10),
    Target DECIMAL(18, 2),
    Hit BIT,
    Number_of_Shares INT,
    FOREIGN KEY (Symbol) REFERENCES Investment(Symbol)
);
GO

CREATE TABLE Index_Monthly (
    Symbol NVARCHAR(10),
    Date DATE,
    [Open] DECIMAL(18, 2),  
    [Close] DECIMAL(18, 2),  
    High DECIMAL(18, 2),  
    Low DECIMAL(18, 2),  
    PRIMARY KEY (Symbol, Date)
);
GO

CREATE TABLE SMA_100_Day (
    Symbol NVARCHAR(10),
    Date DATE,
    value INT,
    PRIMARY KEY (Symbol, Date)
);
GO

CREATE TABLE SMA_10_Day (
    Symbol NVARCHAR(10),
    Date DATE,
    value INT,
    PRIMARY KEY (Symbol, Date)
);
GO

-- Fact Table
CREATE TABLE Orders (
    OrderID INT IDENTITY PRIMARY KEY,
    [Date] DATE,  
    Symbol NVARCHAR(10),
    Buy_Sell NVARCHAR(4) CHECK (Buy_Sell IN ('buy', 'sell')),
    Price DECIMAL(18, 2),
    Number_of_Shares INT,
    Profit_Target INT,
    Market_Index NVARCHAR(10), 
    FOREIGN KEY (Symbol) REFERENCES Investment(Symbol),
    FOREIGN KEY (Profit_Target) REFERENCES Take_Profit(Target_ID),
    FOREIGN KEY (Symbol, [Date]) REFERENCES Monthly_Data(Symbol, [Date]),
    --FOREIGN KEY (Market_Index, [Date]) REFERENCES Index_Monthly(Symbol, [Date])
);
GO