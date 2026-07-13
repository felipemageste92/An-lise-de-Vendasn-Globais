## Vendas Base

### Faturamento Total

Total de valor de vendas

```dax
Faturamento Total =
SUM(FactSales[SalesAmount])
```

### Quantidade Vendida

Total de unidades vendidas

```dax
Quantidade Vendida =
SUM(FactSales[SalesQuantity])
```

### Preço Médio Unitário

Preço médio por unidade

```dax
Preço Médio Unitário =
DIVIDE([Faturamento Total], [Quantidade Vendida], 0)
```

### Vendas Médias Diárias

Média de vendas diárias no período

```dax
Vendas Médias Diárias =
DIVIDE([Faturamento Total], CALCULATE(DISTINCTCOUNT(dCalendario[Date]), DATESBETWEEN(dCalendario[Date], MIN(dCalendario[Date]), MAX(dCalendario[Date]))), 0)
```

### Dias com Vendas

Contagem de dias com vendas no período

```dax
Dias com Vendas =
CALCULATE(DISTINCTCOUNT(dCalendario[Date]), FactSales)
```

### Taxa de Dias Ativos %

Percentual de dias ativos com vendas

```dax
Taxa de Dias Ativos % =
DIVIDE([Dias com Vendas], CALCULATE(DISTINCTCOUNT(dCalendario[Date]), DATESBETWEEN(dCalendario[Date], MIN(dCalendario[Date]), MAX(dCalendario[Date]))), 0) * 100
```

### Número de Transações

Número de transações (linhas de venda)

```dax
Número de Transações =
CALCULATE(COUNTA(FactSales[SalesKey]))
```

### Ticket Médio

Ticket médio por transação

```dax
Ticket Médio =
DIVIDE([Faturamento Total], [Número de Transações], 0)
```

### Participação nas Vendas %

Percentual do total de vendas em relação ao acumulado

```dax
Participação nas Vendas % =
DIVIDE([Faturamento Total], CALCULATE([Faturamento Total], ALL(dCalendario)), 0) * 100
```

### Melhor Dia (Vendas)

Melhor dia do período em vendas

```dax
Melhor Dia (Vendas) =
MAXX(CALCULATETABLE(SUMMARIZE(FactSales, dCalendario[Date]), ALL(dCalendario)), [Faturamento Total])
```

### Pior Dia (Vendas)

Pior dia do período em vendas

```dax
Pior Dia (Vendas) =
MINX(CALCULATETABLE(FILTER(SUMMARIZE(FactSales, dCalendario[Date], "Venda", [Faturamento Total]), [Venda] > 0), ALL(dCalendario)), [Venda])
```

### Amplitude de Vendas

Amplitude de variação (Melhor - Pior)

```dax
Amplitude de Vendas =
[Melhor Dia (Vendas)] - [Pior Dia (Vendas)]
```

### Vendas Dias Üteis

Vendas excluindo feriados e finais de semana (apenas dias úteis)

```dax
Vendas Dias Üteis =
CALCULATE([Faturamento Total], FILTER(dCalendario, dCalendario[É Dia Útil] = TRUE()))
```

### Vendas em Feriados

Vendas apenas em feriados

```dax
Vendas em Feriados =
CALCULATE([Faturamento Total], FILTER(dCalendario, dCalendario[É Feriado] = TRUE()))
```

### Total de Feriados

Contagem de feriados no período

```dax
Total de Feriados =
CALCULATE(DISTINCTCOUNT(dCalendario[Date]), FILTER(dCalendario, dCalendario[É Feriado] = TRUE()))
```
