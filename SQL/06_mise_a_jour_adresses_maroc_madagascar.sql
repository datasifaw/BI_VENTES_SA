USE Ventes;
GO

--------------------------------------------------
-- CLIENTS MAROC
--------------------------------------------------

UPDATE dbo.Client
SET
    Adresse = 'Prestigia - Ryad Al Andalous, Av. Attarfaa',
    Ville = 'Rabat',
    Region = 'Rabat-Sale',
    CodePostal = '10104',
    Pays = 'Maroc'
WHERE ClientId = 'ATLAS';


UPDATE dbo.Client
SET
    Adresse = 'Twin Center, Boulevard Zerktouni',
    Ville = 'Casablanca',
    Region = 'Casablanca',
    CodePostal = '20100',
    Pays = 'Maroc'
WHERE ClientId = 'MARRA';

--------------------------------------------------
-- EMPLOYES MAROC
--------------------------------------------------

UPDATE dbo.Employe
SET
    Adresse = 'Prestigia - Ryad Al Andalous, Av. Attarfaa',
    Ville = 'Rabat',
    Region = 'Rabat-Sale',
    CodePostal = '10104',
    Pays = 'Maroc'
WHERE Nom = 'Alaoui'
  AND Prenom = 'Hamza';


UPDATE dbo.Employe
SET
    Adresse = 'Twin Center, Boulevard Zerktouni',
    Ville = 'Casablanca',
    Region = 'Casablanca',
    CodePostal = '20100',
    Pays = 'Maroc'
WHERE Nom = 'Bennani'
  AND Prenom = 'Sara';

--------------------------------------------------
-- FOURNISSEUR MAROC
--------------------------------------------------

UPDATE dbo.Fournisseur
SET
    Adresse = 'Technopark Casablanca, Route de Nouasseur',
    Ville = 'Casablanca',
    Region = 'Casablanca',
    CodePostal = '20190',
    Pays = 'Maroc'
WHERE NomSociete = 'Agro Maroc';

--------------------------------------------------
-- CLIENTS MADAGASCAR
--------------------------------------------------

UPDATE dbo.Client
SET
    Adresse = 'Moufadal Center, Anosizato',
    Ville = 'Antananarivo',
    Region = 'Analamanga',
    CodePostal = '101',
    Pays = 'Madagascar'
WHERE ClientId = 'MAD01';


UPDATE dbo.Client
SET
    Adresse = '3GXC+HRF, Rue Rasamimanana',
    Ville = 'Antananarivo',
    Region = 'Analamanga',
    CodePostal = '101',
    Pays = 'Madagascar'
WHERE ClientId = 'MAD02';

--------------------------------------------------
-- EMPLOYES MADAGASCAR
--------------------------------------------------

UPDATE dbo.Employe
SET
    Adresse = 'Moufadal Center, Anosizato',
    Ville = 'Antananarivo',
    Region = 'Analamanga',
    CodePostal = '101',
    Pays = 'Madagascar'
WHERE Nom = 'Rakotomalala'
  AND Prenom = 'Andry';


UPDATE dbo.Employe
SET
    Adresse = '3GXC+HRF, Rue Rasamimanana',
    Ville = 'Antananarivo',
    Region = 'Analamanga',
    CodePostal = '101',
    Pays = 'Madagascar'
WHERE Nom = 'Rasoanaivo'
  AND Prenom = 'Fanja';

--------------------------------------------------
-- FOURNISSEUR MADAGASCAR
--------------------------------------------------

UPDATE dbo.Fournisseur
SET
    Adresse = 'Moufadal Center, Anosizato',
    Ville = 'Antananarivo',
    Region = 'Analamanga',
    CodePostal = '101',
    Pays = 'Madagascar'
WHERE NomSociete = 'Vanille Madagascar';
GO