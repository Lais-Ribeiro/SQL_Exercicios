 -- 1. Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela DimProductSubcategory para a tabela DimProduct.
SELECT 
	ProductKey AS 'Id do Produto',
	ProductName AS 'Nome da Produto',
	ProductSubcategoryName AS 'SubCategoria'
FROM 
	DimProduct AS Produtos
INNER JOIN DimProductSubcategory AS SubCategoria
	ON Produtos.ProductSubcategoryKey = SubCategoria.ProductSubcategoryKey

-- 2. Identifique uma coluna em comum entre as tabelas DimProductSubcategory e DimProductCategory. Utilize essa coluna para complementar informações na tabela DimProductSubcategory a partir da DimProductCategory. Utilize o LEFT JOIN.

SELECT 
	Subcategoria.ProductSubcategoryKey AS 'Id',	
	Subcategoria.ProductSubcategoryName AS 'SubCategoria',
	Produtos.ProductCategoryName AS 'Categoria'
FROM 
	DimProductSubcategory AS Subcategoria 
LEFT JOIN DimProductCategory AS Produtos
	ON Subcategoria.ProductCategoryKey = Produtos.ProductCategoryKey 

-- 3. Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do País associados (de acordo com DimGeography). Seu SELECT final deve conter apenas as seguintes colunas: StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName. Utilize o LEFT JOIN neste exercício.

SELECT 
	StoreKey AS 'Id',
	StoreName AS 'Loja',
	EmployeeCount AS 'Qtd de Funcionários',
	ContinentName AS 'Continente',
	RegionCountryName AS 'Pais'
FROM 
	DimStore AS Loja
LEFT JOIN DimGeography AS Localizacao
	ON Loja.GeographyKey = Localizacao.GeographyKey

-- 4. Complementa a tabela DimProduct com a informação de ProductCategoryDescription. Utilize o LEFT JOIN e retorne em seu SELECT apenas as 5 colunas que considerar mais relevantes.

SELECT 
	Produto.ProductKey AS 'ID',
	Produto.ProductName AS 'Nome do Produto',
	Produto.ProductDescription AS 'Descrição', 
	Categoria.ProductCategoryName AS 'Categoria', 
	SubCategoria.ProductSubcategoryName AS 'SubCategoria'
FROM 
	DimProduct AS Produto
LEFT JOIN DimProductSubcategory AS SubCategoria
	ON Produto.ProductSubcategoryKey = SubCategoria.ProductSubcategoryKey
		LEFT JOIN DimProductCategory AS Categoria
			ON SubCategoria.ProductCategoryKey = Categoria.ProductCategoryKey

-- 5. Faça um INNER JOIN para criar uma tabela contendo o AccountName para cada AccountKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas StrategyPlanKey, DateKey, AccountName, Amount

SELECT 
	 StrategyPlanKey, 
	 DateKey, 
	 AccountName, 
	 Amount
FROM 
	FactStrategyPlan
INNER JOIN DimAccount
	ON FactStrategyPlan.AccountKey = DimAccount.AccountKey

-- 6. Faça um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas: StrategyPlanKey, DateKey, scenarioName, Amount

SELECT 
	 StrategyPlanKey, 
	 DateKey, 
	 Amount,
	 ScenarioName
FROM 
	FactStrategyPlan
INNER JOIN DimScenario
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey

-- 7. Algumas subcategorias não possuem nenhum exemplar de produto. Identifique que subcategorias são essas.

SELECT TOP(100) * FROM DimProduct
SELECT TOP(100) * FROM DimProductSubcategory

SELECT 
	DimProductSubcategory.ProductSubcategoryKey,
	ProductSubcategoryName
FROM 
	DimProduct
RIGHT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE ProductKey IS NULL

