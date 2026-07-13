## Lojas e Produtos

### Ranking Vendas

Ranking das vendas para identificação de produtos top

```dax
Ranking Vendas =
RANKX(ALLSELECTED(DimProduct[ProductKey]), [Faturamento Total], , DESC)
```

### Curva Acumulada %

Percentual acumulado para análise ABC de produtos

```dax
Curva Acumulada % =
VAR TotalVendas = CALCULATE([Faturamento Total], ALL(DimProduct))
 VAR VendasProduto = [Faturamento Total] 
 
 RETURN SUMX(FILTER(ALL(DimProduct[ProductKey]), [Faturamento Total] >= VendasProduto), DIVIDE([Faturamento Total], TotalVendas, 0)) * 100
```

### Número de SKUs Vendidos

Quantidade de produtos/SKUs vendidos

```dax
Número de SKUs Vendidos =
CALCULATE(DISTINCTCOUNT(DimProduct[ProductKey]), FactSales)
```

### Número de Lojas Ativas

Quantidade de lojas que venderam

```dax
Número de Lojas Ativas =
CALCULATE(DISTINCTCOUNT(DimStore[StoreKey]), FactSales)
```

### Venda Média por Loja

Venda por loja em média

```dax
Venda Média por Loja =
DIVIDE([Faturamento Total], [Número de Lojas Ativas], 0)
```

### Venda Média por SKU

Venda por SKU em média

```dax
Venda Média por SKU =
DIVIDE([Faturamento Total], [Número de SKUs Vendidos], 0)
```

### Penetração de Mercado %

Penetração de vendas em relação ao total

```dax
Penetração de Mercado % =
DIVIDE([Faturamento Total], CALCULATE([Faturamento Total], ALL(FactSales)), 0) * 100
```

### Velocidade de Venda

Velocidade de venda (unidades por dia)

```dax
Velocidade de Venda =
DIVIDE([Quantidade Vendida], [Dias com Vendas], 0)
```

### Produtividade Lojas

Produtividade de lojas (vendas por loja por dia)

```dax
Produtividade Lojas =
DIVIDE([Faturamento Total], [Número de Lojas Ativas] * [Dias com Vendas] + 0.01, 0)
```

### Concentração Top 10% Produtos

Concentração de vendas nos top 10% de produtos

```dax
Concentração Top 10% Produtos =
CALCULATE([Faturamento Total], TOPN(INT(CALCULATE(DISTINCTCOUNT(DimProduct[ProductKey]), FactSales) * 0.1), ALL(DimProduct[ProductKey]), [Faturamento Total], DESC)) / [Faturamento Total] * 100
```

### Concentração Top 20% Lojas

Concentração de vendas nos top 20% de lojas

```dax
Concentração Top 20% Lojas =
CALCULATE([Faturamento Total], TOPN(INT(CALCULATE(DISTINCTCOUNT(DimStore[StoreKey]), FactSales) * 0.2), ALL(DimStore[StoreKey]), [Faturamento Total], DESC)) / [Faturamento Total] * 100
```

### SKUs Sem Venda

Quantidade de produtos distintos sem nenhuma venda no período

```dax
SKUs Sem Venda =
CALCULATE(DISTINCTCOUNT(DimProduct[ProductKey]), ALL(FactSales)) - [Número de SKUs Vendidos]
```

### Mix Ativo de SKUs %

% de SKUs ativos com venda sobre o total de SKUs cadastrados

```dax
Mix Ativo de SKUs % =
DIVIDE([Número de SKUs Vendidos], CALCULATE(DISTINCTCOUNT(DimProduct[ProductKey]), ALL(FactSales)), 0) * 100
```

### Lojas Sem Venda

Lojas cadastradas sem nenhuma venda no período

```dax
Lojas Sem Venda =
CALCULATE(DISTINCTCOUNT(DimStore[StoreKey]), ALL(FactSales)) - [Número de Lojas Ativas]
```

### Taxa de Atividade Lojas %

% de atividade das lojas: lojas com venda / total de lojas

```dax
Taxa de Atividade Lojas % =
DIVIDE([Número de Lojas Ativas], CALCULATE(DISTINCTCOUNT(DimStore[StoreKey]), ALL(FactSales)), 0) * 100
```

### Receita Líquida por Unidade

Receita gerada por unidade vendida (venda líquida / qtde)

```dax
Receita Líquida por Unidade =
DIVIDE([Faturamento Total] - [Total de Devoluções], [Quantidade Vendida] - [Quantidade Devolvida], 0)
```

### Classificação ABC

Classifica o produto em A, B ou C conforme a curva acumulada de vendas

```dax
Classificação ABC =
VAR Curva = [Curva Acumulada %]
RETURN
    IF(ISBLANK(Curva), BLANK(),
    IF(Curva <= 80, "A",
    IF(Curva <= 95, "B", "C")))
```

### Performance vs Média

Identifica se o produto/loja está acima da média de vendas do período

```dax
Performance vs Média =
VAR Media = CALCULATE(AVERAGEX(VALUES(DimProduct[ProductKey]), [Faturamento Total]), ALL(DimProduct[ProductKey]))
RETURN IF([Faturamento Total] >= Media, "Acima da Média", "Abaixo da Média")
```

### Share de Venda por Produto %

Percentual de participação do produto nas vendas totais sem filtros de contexto

```dax
Share de Venda por Produto % =
DIVIDE([Faturamento Total], CALCULATE([Faturamento Total], ALL(DimProduct)), 0) * 100
```

### Share de Venda por Loja %

Percentual de participação da loja nas vendas totais

```dax
Share de Venda por Loja % =
DIVIDE([Faturamento Total], CALCULATE([Faturamento Total], ALL(DimStore)), 0) * 100
```
