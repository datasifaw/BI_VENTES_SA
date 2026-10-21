USE Ventes;
GO

SELECT *
FROM dbo.Client
WHERE Pays = 'Madagascar';

SELECT *
FROM dbo.Employe
WHERE Pays = 'Madagascar';

SELECT *
FROM dbo.Fournisseur
WHERE Pays = 'Madagascar';

SELECT *
FROM dbo.Produit
WHERE NomProduit = 'Vanille de Madagascar';