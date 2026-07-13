## Tendência

### Vendas Últimos 7 Dias

Tendência de vendas: média últimos 7 dias

```dax
Vendas Últimos 7 Dias =
CALCULATE([Faturamento Total], TOPN(7, ALL(dCalendario[Date]), dCalendario[Date], DESC))
```

### Vendas Últimos 30 Dias

Tendência de vendas: média últimos 30 dias

```dax
Vendas Últimos 30 Dias =
CALCULATE([Faturamento Total], TOPN(30, ALL(dCalendario[Date]), dCalendario[Date], DESC))
```

### Crescimento Tendência 7d

Crescimento das vendas: últimos 7 dias vs os 7 dias anteriores (%)

```dax
Crescimento Tendência 7d =
(
    DIVIDE(
        [Vendas Últimos 7 Dias],
        CALCULATE([Vendas Últimos 7 Dias], DATEADD(dCalendario[Date], -7, DAY)),
        0
    ) - 1
) * 100
```

### Vendas Móvel 3 Meses

Média móvel das vendas nos últimos 3 meses

```dax
Vendas Móvel 3 Meses =
CALCULATE([Faturamento Total], DATESINPERIOD(dCalendario[Date], LASTDATE(dCalendario[Date]), -3, MONTH))
```

### Vendas Móvel 6 Meses

Média móvel das vendas nos últimos 6 meses

```dax
Vendas Móvel 6 Meses =
CALCULATE([Faturamento Total], DATESINPERIOD(dCalendario[Date], LASTDATE(dCalendario[Date]), -6, MONTH))
```

### Crescimento 3M vs 3M Anterior

Crescimento das vendas: últimos 3 meses vs 3 meses anteriores (%)

```dax
Crescimento 3M vs 3M Anterior =
VAR Atual = [Vendas Móvel 3 Meses]
VAR Anterior = CALCULATE([Faturamento Total], DATESINPERIOD(dCalendario[Date], DATEADD(LASTDATE(dCalendario[Date]), -3, MONTH), -3, MONTH))
RETURN DIVIDE(Atual - Anterior, ABS(Anterior), BLANK()) * 100
```

### Crescimento 30d vs 30d Anterior

Compara as vendas dos últimos 30 dias com os 30 dias anteriores (%)

```dax
Crescimento 30d vs 30d Anterior =
VAR Atual = CALCULATE([Faturamento Total], DATESINPERIOD(dCalendario[Date], LASTDATE(dCalendario[Date]), -30, DAY))
VAR Anterior = CALCULATE([Faturamento Total], DATESINPERIOD(dCalendario[Date], DATEADD(LASTDATE(dCalendario[Date]), -30, DAY), -30, DAY))
RETURN DIVIDE(Atual - Anterior, ABS(Anterior), BLANK()) * 100
```
