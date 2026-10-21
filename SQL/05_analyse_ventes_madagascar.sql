SELECT
    CL.ClientId,
    CL.NomSociete,
    CL.Ville,
    CL.Pays,

    COUNT(DISTINCT C.CommandeId) AS NombreCommandes,

    SUM(
        LC.PrixUnitaire * LC.Quantite
    ) AS CA_Brut,

    SUM(
        LC.PrixUnitaire
        * LC.Quantite
        * LC.Remise
    ) AS MontantRemises,

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

WHERE CL.Pays = 'Madagascar'

GROUP BY
    CL.ClientId,
    CL.NomSociete,
    CL.Ville,
    CL.Pays

ORDER BY CA_Net DESC;