/*1. a) Faça um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal 
de vendas (ChannelName). Você deve ordenar a tabela final de acordo com SalesQuantity, 
em ordem decrescente.
b) Faça um agrupamento mostrando a quantidade total vendida (Sales Quantity) e 
quantidade total devolvida (Return Quantity) de acordo com o nome das lojas 
(StoreName).
c) Faça um resumo do valor total vendido (Sales Amount) para cada mês 
(CalendarMonthLabel) e ano (CalendarYear)*/

-- A
SELECT 
	ChannelName AS 'Canal de Venda',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM
	FactSales
INNER JOIN DimChannel
	ON FactSales.channelKey = DimChannel.ChannelKey
GROUP BY ChannelName
ORDER BY SUM(SalesQuantity) DESC

-- B
SELECT 
	StoreName AS 'Loja',
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Total Devolvido'
FROM
	FactSales
INNER JOIN DimStore
	ON FactSales.StoreKey = DimStore.StoreKey
GROUP BY StoreName
ORDER BY StoreName

-- C
SELECT
	CalendarYear AS 'Ano', 
	CalendarMonthLabel AS 'Mês',
	SUM(SalesAmount) AS 'Total Vendido'
FROM
	FactSales
INNER JOIN DimDate
	ON FactSales.DateKey = DimDate.Datekey
GROUP BY CalendarMonthLabel, CalendarYear, CalendarMonth
ORDER BY CalendarMonth

/*2. Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor 
total vendido (SalesAmount) por produto.
a) Descubra qual é a cor de produto que mais é vendida (de acordo com SalesQuantity).
b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000.*/

-- A
SELECT
	ColorName as 'Cor',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ColorName
ORDER BY SUM(SalesQuantity) DESC

-- B
SELECT
	ColorName as 'Cor',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ColorName
HAVING SUM(SalesQuantity) > 3000000
ORDER BY SUM(SalesQuantity) DESC

/*3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto 
(ProductCategoryName). Obs: Você precisará fazer mais de 1 INNER JOIN, dado que a relação 
entre FactSales e DimProductCategory não é direta.*/

SELECT
	ProductCategoryName AS 'Categoria', 
	SUM(SalesQuantity) AS 'Total Vendido'
FROM 
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
		INNER JOIN DimProductSubcategory
			ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
				INNER JOIN DimProductCategory
					ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
GROUP BY ProductCategoryName

/*4. a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o nome completo 
do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).
b) Feito isso, faça um agrupamento de produtos e descubra quais foram os top 10 produtos mais 
comprados pelo cliente da letra a, considerando o nome do produto.*/

-- A

SELECT 
	FactOnlineSales.CustomerKey AS 'Id',
	FirstName AS 'Nome', 
	LastName AS 'Sobrenome',
	SUM(SalesQuantity) AS 'Total Comprado'	
FROM
	FactOnlineSales
INNER JOIN DimCustomer
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE CustomerType = 'Person'	
GROUP BY FactOnlineSales.CustomerKey, FirstName, LastName
ORDER BY SUM(SalesQuantity) DESC

-- B
SELECT TOP(10)
	ProductName AS 'Produto',
	SUM(SalesQuantity) AS 'Qtd. Produtos'
FROM
	FactOnlineSales
		INNER JOIN DimProduct
			ON FactOnlineSales.ProductKey = DimProduct.ProductKey
WHERE CustomerKey = 7665
GROUP BY ProductName
ORDER BY SUM(SalesQuantity)  DESC

/*5. Faça um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o 
sexo dos clientes.*/

SELECT
	Gender AS 'Sexo',
	SUM(SalesQuantity) AS 'Qtd. Comprada'
FROM 
	FactOnlineSales
INNER JOIN DimCustomer
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE CustomerType = 'Person'
GROUP BY Gender

/*FACTSTRATEGYPLAN
7. Calcule a SOMA TOTAL de AMOUNT referente à tabela FactStrategyPlan destinado aos 
cenários: Actual e Budget.
Dica: A tabela DimScenario será importante para esse exercício.
8. Faça uma tabela resumo mostrando o resultado do planejamento estratégico por ano.
DIMPRODUCT/DIMPRODUCTSUBCATEGORY
9. Faça um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em 
consideração em sua análise apenas a marca Contoso e a cor Silver.
10. Faça um agrupamento duplo de quantidade de produtos por BrandName e 
ProductSubcategoryName. A tabela final deverá ser ordenada de acordo com a coluna 
BrandName*/
