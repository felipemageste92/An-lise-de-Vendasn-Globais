## Rentabilidade

### Total de Custo

Custo total das vendas

```dax
Total de Custo =
SUM(FactSales[TotalCost])
```

### Lucro Bruto

Lucro bruto (Vendas - Custo)

```dax
Lucro Bruto =
[Faturamento Total] - [Total de Custo]
```

### Margem de Lucro %

Percentual de margem de lucro

```dax
Margem de Lucro % =
DIVIDE([Lucro Bruto], [Faturamento Total], 0) * 100
```

### Lucro YTD

Lucro líquido acumulado no ano

```dax
Lucro YTD =
CALCULATE([Lucro Líquido], DATESYTD(dCalendario[Date]))
```

### Margem YTD %

Margem de lucro líquida acumulada no ano

```dax
Margem YTD % =
DIVIDE(CALCULATE([Lucro Líquido], DATESYTD(dCalendario[Date])), CALCULATE([Faturamento Total], DATESYTD(dCalendario[Date])), 0) * 100
```

### Custo Unitário Médio

Custo médio por unidade

```dax
Custo Unitário Médio =
DIVIDE([Total de Custo], [Quantidade Vendida], 0)
```

### Markup %

Markup percentual sobre custo

```dax
Markup % =
DIVIDE([Faturamento Total] - [Total de Custo], [Total de Custo], 0) * 100
```

### Custo Total com Devoluções

Custo total + custo de processamento de devoluções (10%)

```dax
Custo Total com Devoluções =
[Total de Custo] + ([Total de Devoluções] * 0.1)
```

### Lucro Líquido

Lucro líquido descontando devoluções e descontos

```dax
Lucro Líquido =
[Faturamento Total] - [Total de Custo] - [Total de Devoluções] - [Total de Descontos]
```

### Margem Líquida %

Margem líquida descontando devoluções e descontos

```dax
Margem Líquida % =
DIVIDE([Lucro Líquido], [Faturamento Total], 0) * 100
```

### ROI de Vendas %

ROI: Lucro líquido / Investimento (Custo)

```dax
ROI de Vendas % =
DIVIDE([Lucro Líquido], [Total de Custo], 0) * 100
```

### % Custo vs Venda

Variação de custo vs venda

```dax
% Custo vs Venda =
DIVIDE([Total de Custo], [Faturamento Total], 0) * 100
```

### Margem Média do Período

Média da Margem de Lucro % no período

```dax
Margem Média do Período =
AVERAGEX(CALCULATETABLE(SUMMARIZE(FactSales, dCalendario[Date]), ALL(dCalendario)), [Margem de Lucro %])
```

### Receita Líquida

Vendas líquidas: Vendas - Devoluções - Descontos

```dax
Receita Líquida =
[Faturamento Total] - [Total de Devoluções] - [Total de Descontos]
```

### Margem sobre Receita Líquida %

Margem calculada sobre a receita líquida (descontando devoluções e descontos)

```dax
Margem sobre Receita Líquida % =
DIVIDE([Lucro Líquido], [Receita Líquida], 0) * 100
```

### Evolução Margem vs Mês Anterior

Compara a margem atual com a do período anterior em pontos percentuais

```dax
Evolução Margem vs Mês Anterior =
VAR MargemAtual = [Margem de Lucro %]
VAR MargemAnterior = CALCULATE([Margem de Lucro %], PREVIOUSMONTH(dCalendario[Date]))
RETURN MargemAtual - MargemAnterior
```

### Break-Even Estimado

Ponto de equilíbrio estimado: custo total / margem líquida %

```dax
Break-Even Estimado =
DIVIDE([Total de Custo], DIVIDE([Margem Líquida %], 100, 1), 0)
```

### Categoria Mais Rentável

Identifica a categoria de produto com a maior margem líquida %. Use em Card sem filtro de categoria.

```dax
Categoria Mais Rentável =
VAR TabelaMargens = ADDCOLUMNS( VALUES(DimProduct[ProductCategoryName]), "@Margem", CALCULATE([Margem Líquida %]) ) 
VAR TabelaValida = FILTER(TabelaMargens, NOT ISBLANK([@Margem])) 
VAR CategoriaTop = MAXX(TOPN(1, TabelaValida, [@Margem], DESC), DimProduct[ProductCategoryName])
RETURN IF(ISBLANK(CategoriaTop), "Sem dados", CategoriaTop)
```

### Categoria Menos Rentável

Identifica a categoria de produto com a menor margem líquida %. Use em Card sem filtro de categoria.

```dax
Categoria Menos Rentável =
VAR TabelaMargens = ADDCOLUMNS( VALUES(DimProduct[ProductCategoryName]), "@Margem", CALCULATE([Margem Líquida %]) ) VAR TabelaValida = FILTER(TabelaMargens, NOT ISBLANK([@Margem])) VAR CategoriaBottom = MINX(TOPN(1, TabelaValida, [@Margem], ASC), DimProduct[ProductCategoryName]) RETURN IF(ISBLANK(CategoriaBottom), "Sem dados", CategoriaBottom)
```

### Alerta Categoria Mais Rentável

Texto pronto para card: categoria mais rentável + margem líquida %.

```dax
Alerta Categoria Mais Rentável =
VAR Categoria = [Categoria Mais Rentável] 
VAR Margem = CALCULATE([Margem Líquida %], DimProduct[ProductCategoryName] = Categoria) 

RETURN IF(ISBLANK(Margem), "Sem dados suficientes", Categoria & " (" & FORMAT(Margem, "0.00") & "%)")
```

### Alerta Categoria Menos Rentável

Texto pronto para card: categoria menos rentável + margem líquida %.

```dax
Alerta Categoria Menos Rentável =
VAR Categoria = [Categoria Menos Rentável] VAR Margem = CALCULATE([Margem Líquida %], DimProduct[ProductCategoryName] = Categoria) RETURN IF(ISBLANK(Margem), "Sem dados suficientes", Categoria & " (" & FORMAT(Margem, "0.00") & "%)")
```

### Margem vs Média da Empresa (pp)

Diferença entre a margem líquida da categoria em contexto e a margem líquida média da empresa (ignorando filtro de categoria). Positivo = categoria mais rentável que a média; negativo = menos rentável.

```dax
Margem vs Média da Empresa (pp) =
VAR MargemCategoria = [Margem Líquida %] VAR MargemMediaEmpresa = CALCULATE([Margem Líquida %], ALL(DimProduct)) RETURN MargemCategoria - MargemMediaEmpresa
```

### Alerta Rentabilidade Perdida

Texto pronto para card: destaca que a categoria com maior perda de faturamento (Categoria Crítica) também tinha margem acima da média — ou seja, a empresa perdeu justamente uma linha rentável.

```dax
Alerta Rentabilidade Perdida =
VAR CategoriaCritica = [Categoria Crítica - Período Total] 
VAR MargemCategoria = CALCULATE([Margem Líquida %], DimProduct[ProductCategoryName] = CategoriaCritica) 
VAR MargemMedia = CALCULATE([Margem Líquida %], ALL(DimProduct)) VAR Diferenca = MargemCategoria - MargemMedia
 
RETURN IF(ISBLANK(MargemCategoria), "Sem dados", CategoriaCritica & ": " & FORMAT(MargemCategoria, "0.00") & "% de margem (" & IF(Diferenca >= 0, "+", "") & FORMAT(Diferenca, "0.0") & "pp vs média da empresa)")
```
