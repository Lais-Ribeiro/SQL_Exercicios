/*1. a) Faça um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas
(channelkey).
b) Faça um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade
total devolvida (Return Quantity) de acordo com o ID das lojas (StoreKey).
c) Faça um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas
para o ano de 2007.*/

-- A
SELECT 
	channelKey AS 'Canal de Venda',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM FactSales
GROUP BY channelKey

-- B
SELECT 
		StoreKey AS 'ID Loja',
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Qtd. Devolvida'
FROM 
	FactSales
GROUP BY StoreKey

-- C
SELECT 
	channelKey AS 'Canal de Vendas',
	SUM(SalesAmount) AS 'Total Vendido'
FROM 
	FactSales
WHERE DateKey BETWEEN '20070101' AND '20071231'
GROUP BY channelKey

/*2. Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor
total vendido (SalesAmount) por produto (ProductKey).
a) A tabela final deverá estar ordenada de acordo com a quantidade vendida e, além disso,
mostrar apenas os produtos que tiveram um resultado final de vendas maior do que
$5.000.000.
b) Faça uma adaptação no exercício anterior e mostre os Top 10 produtos com mais vendas.
Desconsidere o filtro de $5.000.000 aplicado.*/

-- A
SELECT 
	ProductKey AS 'ID do Produto', 
	SUM(SalesAmount) AS 'Total Vendido'
FROM FactSales
GROUP BY ProductKey 
HAVING SUM(SalesAmount) >= 5000000
ORDER BY SUM(SalesAmount) DESC

-- B
SELECT TOP(10)
	ProductKey AS 'ID do Produto', 
	SUM(SalesAmount) AS 'Total Vendido'
FROM 
	FactSales
GROUP BY ProductKey 
ORDER BY SUM(SalesAmount) DESC


/*3. a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o ID
(CustomerKey) do cliente que mais realizou compras online (de acordo com a coluna
SalesQuantity).
b) Feito isso, faça um agrupamento de total vendido (SalesQuantity) por ID do produto
e descubra quais foram os top 3 produtos mais comprados pelo cliente da letra a).*/

SELECT * FROM FACTONLINESALES
-- A
SELECT TOP(1)
	CustomerKey AS 'Id do Cliente',
	SUM(SalesQuantity) AS 'Total de Compra'
FROM 
	FACTONLINESALES
GROUP BY CustomerKey
ORDER BY SUM(SalesQuantity) DESC

-- B
SELECT TOP(3)
	ProductKey AS 'Id do Produto',
	SUM(SalesQuantity) AS 'Total de Compra'
FROM 
	FACTONLINESALES
WHERE CustomerKey = 19037
GROUP BY ProductKey
ORDER BY SUM(SalesQuantity) DESC

/*4. a) Faça um agrupamento e descubra a quantidade total de produtos por marca.
b) Determine a média do preço unitário (UnitPrice) para cada ClassName.
c) Faça um agrupamento de cores e descubra o peso total que cada cor de produto possui.*/

-- A
SELECT
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Qtd de produtos'
FROM
	DimProduct
GROUP BY BrandName

-- B
SELECT 
	ClassName AS 'Classe do Produto', 
	AVG(UnitPrice) AS 'Média de preço'
FROM	
	DimProduct
GROUP BY ClassName

-- C
SELECT 
	ColorName AS 'Cor', 
	SUM(Weight) AS 'Soma do Peso'
FROM 
	DimProduct
GROUP BY ColorName


/*5. Você deverá descobrir o peso total para cada tipo de produto (StockTypeName).
A tabela final deve considerar apenas a marca ‘Contoso’ e ter os seus valores classificados em
ordem decrescente.*/
SELECT 
	StockTypeName AS 'Tipo de Produto',
	SUM(Weight) AS 'Peso do Produto'
FROM 
	DimProduct
WHERE BrandName = 'Contoso'
GROUP BY StockTypeName
ORDER BY SUM(Weight) DESC

/*6. Você seria capaz de confirmar se todas as marcas dos produtos possuem à disposição todas as
16 opções de cores?*/
SELECT DISTINCT
	BrandName AS 'COR',
	COUNT(DISTINCT ColorName) AS 'Qtd. de Cores'
FROM 
	DimProduct
GROUP BY BrandName
HAVING COUNT(DISTINCT ColorName) < 16

/*7. Faça um agrupamento para saber o total de clientes de acordo com o Sexo e também a média
salarial de acordo com o Sexo. Corrija qualquer resultado “inesperado” com os seus
conhecimentos em SQL.*/

SELECT 
	Gender AS 'SEXO',
	COUNT(GENDER) AS 'Qtd de Clientes',
	AVG(YearlyIncome) AS 'Média Salarial'
FROM 
	DIMCUSTOMER
WHERE Gender IS NOT NULL
GROUP BY Gender

/*8. Faça um agrupamento para descobrir a quantidade total de clientes e a média salarial de
acordo com o seu nível escolar. Utilize a coluna Education da tabela DimCustomer para fazer
esse agrupamento.*/

SELECT 
	Education AS 'Nível Escolar',
	COUNT(CustomerKey) AS 'Qtd de Clientes',
	AVG(YearlyIncome) AS 'Média Salarial'
FROM 
	DIMCUSTOMER
WHERE Education IS NOT NULL
GROUP BY Education

/*9. Faça uma tabela resumo mostrando a quantidade total de funcionários de acordo com o
Departamento (DepartmentName). Importante: Você deverá considerar apenas os
funcionários ativos.*/

SELECT 
	DepartmentName as 'Nome do Departamento',
	COUNT(DepartmentName) AS 'Qtd de Funcionarios'
FROM 
	DIMEMPLOYEE
WHERE EndDate IS NULL
GROUP BY DepartmentName

/*10. Faça uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Você
deve considerar apenas as mulheres, dos departamentos de Production, Marketing,
Engineering e Finance, para os funcionários contratados entre os anos de 1999 e 2000.*/

SELECT 
	Title AS 'Cargo',
	SUM(VacationHours) AS 'Total'
FROM 
	DIMEMPLOYEE
WHERE Gender = 'F' AND DepartmentName IN ('Production','Marketing' , 'Engineering', 'Finance')  AND HireDate BETWEEN '1999-01-01' AND '2000-12-31'
GROUP BY Title