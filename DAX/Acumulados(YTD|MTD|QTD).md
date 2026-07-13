## Acumulados (YTD/MTD/QTD)

### Vendas YTD

Vendas acumuladas no ano atual até a data selecionada

```dax
Vendas YTD =
CALCULATE([Faturamento Total], DATESYTD(dCalendario[Date]))
```

### Vendas MTD

Vendas acumuladas no mês atual até a data selecionada

```dax
Vendas MTD =
CALCULATE([Faturamento Total], DATESMTD(dCalendario[Date]))
```

### Vendas QTD

Vendas acumuladas no trimestre atual até a data selecionada

```dax
Vendas QTD =
CALCULATE([Faturamento Total], DATESQTD(dCalendario[Date]))
```

### Custo MTD

Custo acumulado no mês atual

```dax
Custo MTD =
CALCULATE([Total de Custo], DATESMTD(dCalendario[Date]))
```

### Lucro MTD

Lucro líquido acumulado no mês atual

```dax
Lucro MTD =
CALCULATE([Lucro Líquido], DATESMTD(dCalendario[Date]))
```

### Quantidade Vendida YTD

Unidades vendidas acumuladas no ano

```dax
Quantidade Vendida YTD =
CALCULATE([Quantidade Vendida], DATESYTD(dCalendario[Date]))
```

### Custo YTD

Custo acumulado no ano

```dax
Custo YTD =
CALCULATE([Total de Custo], DATESYTD(dCalendario[Date]))
```
