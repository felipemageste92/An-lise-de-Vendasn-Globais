## Devoluções e Descontos

### Total de Devoluções

Valor total de devoluções

```dax
Total de Devoluções =
SUM(FactSales[ReturnAmount])
```

### Total de Descontos

Valor total de descontos concedidos

```dax
Total de Descontos =
SUM(FactSales[DiscountAmount])
```

### Quantidade Devolvida

Total de unidades devolvidas

```dax
Quantidade Devolvida =
SUM(FactSales[ReturnQuantity])
```

### Taxa de Devolução %

Percentual de devolução sobre total

```dax
Taxa de Devolução % =
DIVIDE([Quantidade Devolvida], [Quantidade Vendida] + [Quantidade Devolvida], 0)
```

### Taxa de Retorno %

Taxa de retorno (devolução vs venda)

```dax
Taxa de Retorno % =
DIVIDE([Quantidade Devolvida], [Quantidade Vendida], 0) * 100
```

### % Impacto Descontos

Impacto dos descontos nas vendas

```dax
% Impacto Descontos =
DIVIDE([Total de Descontos], [Faturamento Total] + [Total de Descontos], 0) * 100
```

### % Devoluções vs Vendas

Total de devoluções como % das vendas

```dax
% Devoluções vs Vendas =
DIVIDE([Total de Devoluções], [Faturamento Total], 0) * 100
```

### % Desconto vs Venda

Variação de desconto vs venda

```dax
% Desconto vs Venda =
DIVIDE([Total de Descontos], [Faturamento Total], 0) * 100
```

### % Devolução vs Venda

Variação de devolução vs venda

```dax
% Devolução vs Venda =
DIVIDE([Total de Devoluções], [Faturamento Total], 0) * 100
```

### Vendas com Desconto

Vendas com desconto aplicado

```dax
Vendas com Desconto =
CALCULATE([Faturamento Total], FactSales[DiscountAmount] > 0)
```

### Qtd Transações com Desconto

Número de transações com desconto aplicado

```dax
Qtd Transações com Desconto =
CALCULATE([Número de Transações], FactSales[DiscountAmount] > 0)
```

### % Transações com Desconto

Percentual de transações que tiveram desconto

```dax
% Transações com Desconto =
DIVIDE([Qtd Transações com Desconto], [Número de Transações], 0) * 100
```

### Desconto Médio por Transação

Desconto médio por transação com desconto

```dax
Desconto Médio por Transação =
DIVIDE([Total de Descontos], [Qtd Transações com Desconto], 0)
```
