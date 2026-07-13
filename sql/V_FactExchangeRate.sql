-- CRIANDO A TABELA DE EXCHANGE RATE COM AS INFORMAÇÕES DAS TAXAS DE CÂMBIO.

SELECT * FROM FactExchangeRate
SELECT * FROM DimCurrency


CREATE VIEW dbo.V_FactExchangeRate AS
SELECT
	ExchangeRateKey,
	FactExchangeRate.CurrencyKey,
	DateKey,
	AverageRate,
	EndOfDayRate,
	DimCurrency.CurrencyName
FROM 
	FactExchangeRate
INNER JOIN DimCurrency 
	ON FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
