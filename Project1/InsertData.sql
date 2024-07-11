
INSERT INTO Investment (Symbol, Type, indexName)
VALUES ('AGI', 'ETF', NULL),
		('QQQ', 'ETF', 'NASDAQ'),
		('SPY', 'ETF', Null),
		('MARA', 'ETF', 'NASDAQ'),
		('REGN', 'ETF', 'NASDAQ'),
		('EURUSD', 'FOREX', NULL),
		('DOGEUSD', 'CRYPTO', NULL);







INSERT INTO Orders (DATE, Symbol, Buy_Sell, Price, Number_of_Shares, Profit_Target, Market_Index)
	VALUES ('2023-01-01', 'QQQ', 'BUY', 268.65, 11, IDK, 'NASDAQ'),
		('2023-01-01', 'QQQ', 'BUY', 268.65, 16, IDK, 'NASDAQ'),
	    ('2023-01-01', 'QQQ', 'BUY', 268.65, 28, NULL, 'NASDAQ'),
		('2023-01-01', 'SPY', 'BUY', 384.37, 7, IDK, NULL),
		('2023-01-01', 'SPY', 'BUY', 384.37, 11, IDK, NULL),
		('2023-01-01', 'SPY', 'BUY', 384.37, 21, NULL, NULL),
		('2023-01-01', 'AGI', 'BUY', 10.24, 308, IDK, NULL),
		('2023-01-01', 'AGI', 'BUY', 10.24, 462, IDK, NULL),
		('2023-01-01', 'AGI', 'BUY', 10.24, 772, NULL, NULL),
		('2023-01-01', 'MARA', 'BUY', 3.58, 838, IDK, 'NASDAQ'),
		('2023-01-01', 'MARA', 'BUY', 3.58, 1257, IDK, 'NASDAQ'),
		('2023-01-01', 'MARA', 'BUY', 3.58, 2096, NULL, 'NASDAQ'),
		('2023-01-01', 'REGN', 'BUY', 721.86, 4, IDK, 'NASDAQ'),
		('2023-01-01', 'REGN', 'BUY', 721.86, 6, IDK, 'NASDAQ'),
		('2023-01-01', 'REGN', 'BUY', 721.86, 10, NULL, 'NASDAQ');





INSERT INTO Take_profit (Symbol, [Target], Hit, Number_of_Shares)
	VALUES('QQQ', 349.25, 0, 11),
			('QQQ', 456.70, 0, 16),

			('SPY', 499.68, 0, 7),
			('SPY', 653.43, 0, 11),
			
			('AGI', 13.31, 0, 308),
			('AGI', 17.41, 0, 462),

			('MARA', 4.65, 0, 838),
			('MARA', 6.09, 0, 1257),
					
			('REGN', 938.42, 0, 4),
			('REGN', 1227.16, 0, 6);