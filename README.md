# Dashboard de Análise de Vendas — Power BI

Dashboard de BI (SQL Server + Power BI + DAX) para diagnóstico de vendas, perdas, rentabilidade e sazonalidade em varejo.

Este projeto apresenta um dashboard analítico construído em Power BI para diagnosticar o desempenho comercial de uma rede de varejo entre 2007 e 2009. O objetivo foi ir além de indicadores estáticos: cada página do relatório responde a uma pergunta de negócio específica — como está o desempenho geral, onde a empresa está perdendo faturamento, quais categorias são mais rentáveis e como as vendas se comportam ao longo do ano.

O projeto cobre toda a cadeia de construção de um produto analítico: extração e modelagem de dados em SQL Server, tratamento em Power Query, modelagem dimensional em Power BI e criação de medidas DAX.

### Stack utilizada


SQL Server — extração, views e modelagem inicial das tabelas de origem

Power Query (Power BI) — limpeza e transformação dos dados

Power BI Desktop — modelagem dimensional (esquema estrela) e construção do relatório

DAX — medidas de negócio (152 medidas)

Claude (via MCP Server para Power BI) — utilizado como copiloto no processo de criação e revisão das medidas DAX e na validação do modelo semântico


Metodologia

## 1. Camada de dados (SQL Server)

A base de dados de origem (ContosoRetailDW) foi tratada em SQL Server através da criação de views (dbo.V_DimProduct, dbo.V_DimStore, dbo.V_FactSales, entre outras), unindo as tabelas de dimensão de produto (DimProduct, DimProductSubcategory, DimProductCategory) e de loja/geografia (DimStore, DimGeography) já com as colunas necessárias para as análises planejadas, evitando trazer para o Power BI colunas não utilizadas pelo relatório.

<img width="1913" height="974" alt="Criação das views no SQL Server" src="https://github.com/user-attachments/assets/7abe5c73-bb5a-457b-9240-59b55bebf530" />


## 2. Tratamento em Power Query

A partir das views do SQL Server, os dados foram conectados ao Power BI e passaram por um processo de limpeza em Power Query, incluindo:


Remoção de colunas em branco e não utilizadas nas análises
Remoção de duplicatas
Padronização de tipos de dados
Ajustes de nomenclatura de colunas para facilitar o uso nas medidas DAX


## 3. Modelagem dimensional (esquema estrela)

No Power BI, as tabelas foram relacionadas seguindo o modelo estrela (star schema), com uma tabela fato central (FactSales) conectada às dimensões de Produto, Loja/Geografia e Calendário, além de uma tabela calendário customizada (dCalendario) para suportar inteligência de tempo (comparativos YoY, YTD, MTD, QTD).

## 4. Camada semântica (medidas DAX)

O modelo semântico foi construído com 152 medidas DAX, organizadas em pastas de exibição (Vendas Base, Rentabilidade, Devoluções e Descontos, Comparativos e Crescimento, Alertas Dinâmicos, Eficiência e Score, Lojas e Produtos, Tendência, Acumulados).

O processo de criação e revisão das medidas foi conduzido com apoio do Claude, conectado diretamente ao modelo semântico do Power BI Desktop através de um servidor MCP (Model Context Protocol). Essa integração permitiu:


Criar medidas DAX diretamente no modelo, sem necessidade de copiar e colar fórmulas manualmente
Consultar a definição exata de qualquer medida existente para auditoria
Executar queries DAX diretamente contra o modelo para validar o resultado de uma medida antes de utilizá-la em um visual
Identificar inconsistências na lógica de algumas medidas (detalhado na seção "Qualidade de dados" abaixo)


O uso da ferramenta funcionou como um copiloto técnico: toda medida criada foi revisada e testada com consultas DAX diretas ao modelo antes de ser considerada válida, e as decisões de negócio sobre o que cada medida deveria calcular partiram da análise do autor do projeto, Felipe Mageste.

Estrutura do relatório

O relatório é composto por quatro páginas analíticas, cada uma respondendo a uma pergunta de negócio específica.

## Página 1 — Análise de Vendas

Visão executiva do desempenho comercial: oito indicadores-chave (Faturamento Total, Lucro Bruto, Lucro Líquido, Margem de Lucro %, Ticket Médio, Quantidade Vendida, Taxa de Devolução %, Perda no Faturamento), um comparativo anual de Faturamento e Lucro Bruto (2007-2009) e uma Curva ABC de marcas.

<img width="1319" height="727" alt="Página 1 - Análise de Vendas" src="https://github.com/user-attachments/assets/0086ad80-a075-43a2-9d71-1b6e6a44cb6e" />
Indicadores

IndicadorValorFaturamento Total$ 12,41 Bi (-9,0% vs. período anterior)Lucro Bruto$ 7,05 Bi (-9,5%)Lucro Líquido$ 6,69 BiMargem de Lucro %56,78% Ticket Médio $ 3,64 MilQuantidade Vendida 53 Mi de unidadesTaxa de Devolução 0,92%

### Problemas identificados

Durante a construção da página, a medida Taxa de Devolução % apresentou um erro de dupla conversão percentual: a fórmula DAX multiplicava o resultado por 100 e, em seguida, o formato de exibição (0.00%) aplicava uma segunda multiplicação por 100, inflando o valor exibido (chegando a mostrar 91,72% em vez de 0,92%). O problema foi corrigido removendo a multiplicação redundante na fórmula.

O cartão "Perda no Fat ($)" também exibia o rótulo "NA" por falta de tratamento de erro na medida quando não havia contexto de comparação disponível.

### Análise e possíveis decisões

O Lucro Bruto caiu proporcionalmente mais que o Faturamento Total (-9,5% vs. -9,0%), indicando compressão de margem, não apenas queda de volume. A série anual ($ 4,6 Bi em 2007, $ 4,1 Bi em 2008, $ 3,7 Bi em 2009) mostra retração em três anos consecutivos, o que sugere uma tendência estrutural e não um evento pontual.

A Curva ABC mostra concentração relevante: as duas primeiras marcas (Contoso e Fabrikam) respondem por aproximadamente 41% do faturamento acumulado, e as quatro primeiras por cerca de 64%. Isso implica que qualquer perda de desempenho nessas marcas tem efeito desproporcional sobre o resultado total, o que justifica tratá-las como prioridade de monitoramento comercial.

Recomenda-se investigar a origem da queda de margem (custo de produto vendido versus política de descontos) e estabelecer uma meta de faturamento por ano como referência visual, para diferenciar sazonalidade normal de tendência de queda.

## Página 2 — Onde Está a Perda

Página de diagnóstico, com objetivo de identificar em que país, marca, categoria e subcategoria a empresa está deixando de faturar. Utiliza um visual de decomposição (drill País → Marca → Categoria → Subcategoria) e um mapa de faturamento por país.

<img width="1071" height="601" alt="Página 2 - Onde Está a Perda" src="https://github.com/user-attachments/assets/2e78226d-0525-46ee-b16d-22f6e472fad5" />
Alertas identificados no período completo (2007 vs. 2009)


### Categoria crítica: Cameras and camcorders, com queda de $ 461.267.893 (-41,83%)
País crítico: United States, com queda de $ 815.919.085 (-29,48%)
Perda acumulada total da empresa: $ 821.457.835,84


### Análise

A perda acumulada dos Estados Unidos ($ 815,92 Mi) corresponde a aproximadamente 99,3% da perda acumulada total da empresa ($ 821,46 Mi), o que indica que a retração de faturamento identificada na Página 1 está concentrada quase inteiramente nesse mercado.

No drill por país, dentro dos Estados Unidos a marca Contoso concentra a maior perda ($ 234,83 Mi), e dentro de Contoso a subcategoria Cameras and camcorders é a principal responsável, reforçando de forma consistente o alerta de categoria crítica identificado na visão global.

### Possíveis decisões

Abrir uma investigação específica sobre o mercado dos Estados Unidos, dado que ele concentra praticamente toda a perda de faturamento da empresa. Revisar o mix de produtos da categoria Cameras and camcorders, identificada como crítica tanto na visão global quanto no drill por país e marca. Estabelecer o uso do drill País → Marca → Categoria como rotina periódica de monitoramento, e não apenas como análise pontual.

## Página 3 — Análise de Rentabilidade

Cruza volume de vendas e margem líquida por categoria de produto, com o objetivo de identificar quais categorias são mais e menos rentáveis, e como a margem líquida varia por país.

<img width="1076" height="603" alt="Página 3 - Análise de Rentabilidade" src="https://github.com/user-attachments/assets/d79caeb3-c207-4054-bc88-45844384e030" />
Indicadores

IndicadorValorLucro Líquido$ 6,69 BiMargem Líquida %53,87%Categoria menos rentávelGames and Toys (51,51%)Categoria mais rentávelMusic, Movies and Audio Books (57,98%)

### Análise

A categoria Cameras and camcorders opera com margem de 57,19%, 3,3 pontos percentuais acima da média da empresa, e acumula $ 2,56 Bi em vendas no período — é a segunda categoria mais rentável do portfólio. Ao mesmo tempo, é a categoria com a queda de volume mais severa identificada na Página 2 (-41,83%). A combinação desses dois fatos indica que a empresa está perdendo participação exatamente na categoria mais lucrativa, o que eleva a prioridade de qualquer ação de retenção nessa linha de produto.

Todas as categorias operam em uma faixa relativamente estreita de margem (51,5% a 58%), sugerindo uma estrutura de custos padronizada entre categorias. A categoria de maior faturamento (Home Appliances, $ 3,92 Bi) apresenta margem abaixo da média (52,15%), indicando que volume alto não está associado à maior rentabilidade relativa nesse caso.

No ranking por país, a diferença de margem líquida entre o primeiro colocado (Estados Unidos, 54,32%) e o sexto colocado (Reino Unido, 53,12%) é de aproximadamente 1,2 ponto percentual, o que indica rentabilidade relativamente homogênea entre os principais mercados.

### Possíveis decisões

Tratar a retenção de clientes na categoria Cameras and camcorders como prioridade, por ser simultaneamente a categoria mais ameaçada e uma das mais lucrativas do portfólio. Revisar a estratégia de custo e precificação de Home Appliances, que tem o maior faturamento da empresa mas rentabilidade abaixo da média. Investigar a queda de crescimento de -49,95% na categoria Music, Movies and Audio Books, que apesar de ser a mais rentável apresenta a maior perda de crescimento — possivelmente associada a uma transformação estrutural do mercado (digitalização) e não apenas a um fator comercial pontual.

## Página 4 — Análise Sazonal

Analisa o comportamento de vendas e devolução ao longo dos doze meses do ano, comparando os três anos disponíveis na base (2007, 2008, 2009), com foco no período de pico de vendas de fim de ano.

<img width="1077" height="597" alt="Página 4 - Análise Sazonal" src="https://github.com/user-attachments/assets/fdc181e2-af6e-40f1-8b64-0c7801923019" />
Alertas identificados


Pico sazonal (novembro + dezembro), comparando 2007 com 2009: queda de $ 226.710.135 (-25,77%)
Mês crítico: janeiro de 2008, com queda de $ 146.399.736 (-34,38%) em relação ao mês anterior

### Análise

O período de pico de vendas de fim de ano (novembro e dezembro) apresenta queda consistente ano após ano: em 2007 esse período chega perto de $ 0,45 Bi por mês, e em 2009 não ultrapassa $ 0,40 Bi. O trimestre T4 (outubro a dezembro), tradicionalmente o mais forte do ano, caiu de $ 1,3 Bi em 2007 para $ 1,0 Bi em 2009, uma redução de aproximadamente 23% no período mais relevante do calendário comercial. Esse padrão indica erosão estrutural do principal período de vendas, e não uma variação sazonal esperada.

A Taxa de Devolução % por mês mostra picos recorrentes em março e outubro, e quedas consistentes em julho e no período de novembro e dezembro, em praticamente todos os anos da base.

### Possíveis decisões

Investigar a causa raiz da erosão do pico de fim de ano — perda de participação de mercado, mudança de comportamento de compra ou problema de estoque/logística na alta temporada. Aprofundar a análise da queda específica de janeiro de 2008, que pode indicar um evento pontual relevante de documentar. Cruzar os picos de devolução (março e outubro) com o calendário de campanhas promocionais e lançamentos de produto, para verificar se há relação entre promoções e aumento de devolução.

### Qualidade de dados e validação do modelo

Após a construção das quatro páginas, foi realizado um cruzamento entre os indicadores de todas as páginas para validar a consistência interna do modelo semântico. Os principais pontos verificados:


O Faturamento Total exibido na Página 1 ($ 12,41 Bi) é igual à soma do Faturamento Total por categoria na Página 3 e à soma dos trimestres de 2007 na Página 4.
A perda acumulada total exibida na Página 1 ($ 821,46 Mi) é igual ao valor exibido na Página 2 e à soma da perda/ganho de todas as categorias individuais.
A perda acumulada dos Estados Unidos, isolada, corresponde a aproximadamente 99,3% da perda acumulada total da empresa, confirmando a consistência entre a Página 1 (visão geral) e a Página 2 (detalhamento por país).
As medidas de margem bruta (Página 1) e margem líquida (Página 3) diferem conforme esperado, pois representam cálculos distintos (margem sobre lucro bruto e margem sobre lucro líquido, respectivamente).


Não foram identificadas inconsistências de dado entre as páginas. As divergências encontradas durante o desenvolvimento foram de natureza técnica (fórmulas DAX e formatação), que foram corrigidas e testadas.
