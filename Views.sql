--1.
-- a) A partir da tabela DimProduct, crie uma View contendo as informações de ProductName, ColorName, UnitPrice e UnitCost, da tabela DimProduct. Chame essa View de vwProdutos.

GO
CREATE VIEW vwProdutos AS
SELECT 
	ProductName AS 'Nome do Produto',
	ColorName AS 'Cor', 
	UnitPrice AS 'Preço Unitário',
	UnitCost AS 'Preço de Custo'
FROM
	DimProduct
GO

--b) A partir da tabela DimEmployee, crie uma View mostrando FirstName, BirthDate,DepartmentName. Chame essa View de vwFuncionarios.

GO
CREATE VIEW vwFuncionarios AS
SELECT 
	FirstName AS 'Nome',
	BirthDate AS 'Data de Nascimento',
	DepartmentName AS 'Departamento'
FROM
	DimEmployee
GO

--c) A partir da tabela DimStore, crie uma View mostrando StoreKey, StoreName e OpenDate. Chame essa View de vwLojas.

GO
CREATE VIEW vwLojas AS
SELECT
	StoreKey AS 'Id',
	StoreName AS 'Loja',
	OpenDate AS 'Data de Abertura'
FROM
	DimStore
GO

-- 2. Crie uma View contendo as informações de Nome Completo (FirstName + LastName), Gênero (por extenso), E-mail e Renda Anual (formatada com R$).Utilize a tabela DimCustomer. Chame essa View de vwClientes.

GO
CREATE VIEW vwClientes AS
SELECT
	CONCAT(FirstName, ' ', LastName) AS 'Nome completo',
	REPLACE(REPLACE(Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'Gênero',
	EmailAddress AS 'E-mail', 
	FORMAT(YearlyIncome, 'C') AS 'Renda Atual' 
FROM
	DimCustomer
GO
select * from DimCustomer

--3. a) A partir da tabela DimStore, crie uma View que considera apenas as lojas ativas. Faça um SELECT de todas as colunas. Chame essa View de vwLojasAtivas.

GO
CREATE VIEW vwLojasAtivas AS
SELECT
	*
FROM
	DimStore
WHERE Status = 'On'
GO

-- b) A partir da tabela DimEmployee, crie uma View de uma tabela que considera apenas os funcionários da área de Marketing. Faça um SELECT das colunas: FirstName, EmailAddress e DepartmentName. Chame essa de vwFuncionariosMkt.

GO
CREATE VIEW vwFuncionariosMkt AS
SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'E-mail',
	DepartmentName AS 'Departamento'
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing'
GO

--c) Crie uma View de uma tabela que considera apenas os produtos das marcas Contoso e Litware. Além disso, a sua View deve considerar apenas os produtos de cor Silver. Faça um SELECT de todas as colunas da tabela DimProduct. Chame essa View de vwContosoLitwareSilver.

GO
CREATE VIEW vwContosoLitwareSilver AS 
SELECT
	*
FROM
	DimProduct
WHERE ColorName = 'Silver' AND BrandName IN ('Contoso', 'Litware')
GO

--4. Crie uma View que seja o resultado de um agrupamento da tabela FactSales. Este agrupamento deve considerar o SalesQuantity (Quantidade Total Vendida) por Nome do Produto. Chame esta View de vwTotalVendidoProdutos. OBS: Para isso, você terá que utilizar um JOIN para relacionar as tabelas FactSales e DimProduct.

GO 
CREATE VIEW vwTotalVendidoProdutos AS
SELECT 
	ProductName AS 'Nome do Produto',
	SUM(SalesQuantity) AS 'Quantidade Total Vendida'
FROM 
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ProductName
GO

--5. Faça as seguintes alterações nas tabelas da questão 1.
--a. Na View criada na letra a da questão 1, adicione a coluna de BrandName.

ALTER VIEW vwProdutos AS
SELECT 
	ProductName AS 'Nome do Produto',
	ColorName AS 'Cor', 
	UnitPrice AS 'Preço Unitário',
	UnitCost AS 'Preço de Custo',
	BrandName AS 'Marca'
FROM
	DimProduct

--b. Na View criada na letra b da questão 1, faça um filtro e considere apenas os funcionários do sexo feminino.

GO
ALTER VIEW vwFuncionarios AS
SELECT 
	FirstName AS 'Nome',
	BirthDate AS 'Data de Nascimento',
	DepartmentName AS 'Departamento'
FROM
	DimEmployee
WHERE Gender = 'F'
GO
--c. Na View criada na letra c da questão 1, faça uma alteração e filtre apenas as lojas ativas.

GO
ALTER VIEW vwLojas AS
SELECT
	StoreKey AS 'Id',
	StoreName AS 'Loja',
	OpenDate AS 'Data de Abertura'
FROM
	DimStore
WHERE Status = 'ON'
GO