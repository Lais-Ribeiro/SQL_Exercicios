/*1. a) Fa�a um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal 
de vendas (ChannelName). Voc� deve ordenar a tabela final de acordo com SalesQuantity, 
em ordem decrescente.
b) Fa�a um agrupamento mostrando a quantidade total vendida (Sales Quantity) e 
quantidade total devolvida (Return Quantity) de acordo com o nome das lojas 
(StoreName).
c) Fa�a um resumo do valor total vendido (Sales Amount) para cada m�s 
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
	CalendarMonthLabel AS 'M�s',
	SUM(SalesAmount) AS 'Total Vendido'
FROM
	FactSales
INNER JOIN DimDate
	ON FactSales.DateKey = DimDate.Datekey
GROUP BY CalendarMonthLabel, CalendarYear, CalendarMonth
ORDER BY CalendarMonth

/*2. Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor 
total vendido (SalesAmount) por produto.
a) Descubra qual � a cor de produto que mais � vendida (de acordo com SalesQuantity).
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
(ProductCategoryName). Obs: Voc� precisar� fazer mais de 1 INNER JOIN, dado que a rela��o 
entre FactSales e DimProductCategory n�o � direta.*/

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

/*4. a) Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o nome completo 
do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).
b) Feito isso, fa�a um agrupamento de produtos e descubra quais foram os top 10 produtos mais 
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

/*5. Fa�a um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o 
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
7. Calcule a SOMA TOTAL de AMOUNT referente � tabela FactStrategyPlan destinado aos 
cen�rios: Actual e Budget.
Dica: A tabela DimScenario ser� importante para esse exerc�cio.
8. Fa�a uma tabela resumo mostrando o resultado do planejamento estrat�gico por ano.
DIMPRODUCT/DIMPRODUCTSUBCATEGORY
9. Fa�a um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em 
considera��o em sua an�lise apenas a marca Contoso e a cor Silver.
10. Fa�a um agrupamento duplo de quantidade de produtos por BrandName e 
ProductSubcategoryName. A tabela final dever� ser ordenada de acordo com a coluna 
BrandName*/
