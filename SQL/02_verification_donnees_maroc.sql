USE Ventes;
GO

SELECT
    EmployeId,
    Nom,
    Prenom,
    Ville,
    Pays
FROM dbo.Employe
WHERE Pays = 'Maroc';


SELECT
    C.CommandeId,
    C.ClientId,
    CL.NomSociete,
    E.Nom + ' ' + E.Prenom AS Employe,
    C.DateCommande,
    C.DateExpedition
FROM dbo.Commande AS C
INNER JOIN dbo.Client AS CL
    ON C.ClientId = CL.ClientId
INNER JOIN dbo.Employe AS E
    ON C.EmployeId = E.EmployeId
WHERE C.ClientId IN ('ATLAS', 'MARRA');


SELECT
    CL.ClientId,
    CL.NomSociete,
    CL.Ville,
    COUNT(DISTINCT C.CommandeId) AS NombreCommandes,
    SUM(LC.PrixUnitaire * LC.Quantite) AS CA_Brut,
    SUM(
        LC.PrixUnitaire
        * LC.Quantite
        * (1 - LC.Remise)
    ) AS CA_Net
FROM dbo.Client AS CL
INNER JOIN dbo.Commande AS C
    ON CL.ClientId = C.ClientId
INNER JOIN dbo.LigneCommandes AS LC
    ON C.CommandeId = LC.CommandeId
WHERE CL.ClientId IN ('ATLAS', 'MARRA')
GROUP BY
    CL.ClientId,
    CL.NomSociete,
    CL.Ville
ORDER BY CA_Net DESC;