
INSERT INTO Investment (Symbol, Type, indexName)
VALUES ('AGI', 'ETF', NULL),
		('QQQ', 'ETF', 'NASDAQ'),
		('SPY', 'ETF', Null),
		('MARA', 'ETF', 'NASDAQ'),
		('REGN', 'ETF', 'NASDAQ'),
		('EURUSD', 'FOREX', NULL),
		('DOGEUSD', 'CRYPTO', NULL);







INSERT INTO Orders (DATE, Symbol, Buy_Sell, Price, Number_of_Shares, Profit_Target, Market_Index)
	VALUES ('2023-01-01', 'QQQ', 'BUY', 268.65, 11, 1, 'NASDAQ'),
		('2023-01-01', 'QQQ', 'BUY', 268.65, 16, 2, 'NASDAQ'),
	    ('2023-01-01', 'QQQ', 'BUY', 268.65, 28, NULL, 'NASDAQ'),
		('2023-01-01', 'SPY', 'BUY', 384.37, 7, 3, NULL),
		('2023-01-01', 'SPY', 'BUY', 384.37, 11, 4, NULL),
		('2023-01-01', 'SPY', 'BUY', 384.37, 21, NULL, NULL),
		('2023-01-01', 'AGI', 'BUY', 10.24, 308, 5, NULL),
		('2023-01-01', 'AGI', 'BUY', 10.24, 462, 6, NULL),
		('2023-01-01', 'AGI', 'BUY', 10.24, 772, NULL, NULL),
		('2023-01-01', 'MARA', 'BUY', 3.58, 838, 7, 'NASDAQ'),
		('2023-01-01', 'MARA', 'BUY', 3.58, 1257, 8, 'NASDAQ'),
		('2023-01-01', 'MARA', 'BUY', 3.58, 2096, NULL, 'NASDAQ'),
		('2023-01-01', 'REGN', 'BUY', 721.86, 4, 9, 'NASDAQ'),
		('2023-01-01', 'REGN', 'BUY', 721.86, 6, 10, 'NASDAQ'),
		('2023-01-01', 'REGN', 'BUY', 721.86, 10, NULL, 'NASDAQ'),
		('2023-01-01', 'EURUSD', 'BUY', 1.07, 14018, NULL , NULL),
		('2023-01-01', 'DOGEUSD', 'BUY', 0.07, 214285, NULL , NULL);





INSERT INTO Take_profit (Symbol, [Target], Hit, Number_of_Shares)
	VALUES('QQQ', 349.25, 1, 11),
			('QQQ', 456.70, 1, 16),

			('SPY', 499.68, 1, 7),
			('SPY', 653.43, 0, 11),
			
			('AGI', 13.31, 1, 308),
			('AGI', 17.41, 0, 462),

			('MARA', 4.65, 1, 838),
			('MARA', 6.09, 1, 1257),
					
			('REGN', 938.42, 1, 4),
			('REGN', 1227.16, 0, 6);


INSERT INTO Eco_indicators (date, unemployment, interest_rate)
VALUES
    ('2024-06-01', 4.1, 5.33),
    ('2024-05-01', 4.0, 5.33),
    ('2024-04-01', 3.9, 5.33),
    ('2024-03-01', 3.8, 5.33),
    ('2024-02-01', 3.9, 5.33),
    ('2024-01-01', 3.7, 5.33),
    ('2023-12-01', 3.7, 5.33),
    ('2023-11-01', 3.7, 5.33),
    ('2023-10-01', 3.8, 5.33),
    ('2023-09-01', 3.8, 5.33),
    ('2023-08-01', 3.8, 5.33),
    ('2023-07-01', 3.5, 5.12),
    ('2023-06-01', 3.6, 5.08),
    ('2023-05-01', 3.7, 5.06),
    ('2023-04-01', 3.4, 4.83),
    ('2023-03-01', 3.5, 4.65),
    ('2023-02-01', 3.6, 4.57),
    ('2023-01-01', 3.4, 4.33);