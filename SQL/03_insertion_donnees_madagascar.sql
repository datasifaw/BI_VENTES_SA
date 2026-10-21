USE Ventes;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @EmployeAndryId INT;
    DECLARE @EmployeFanjaId INT;
    DECLARE @FournisseurMadagascarId INT;
    DECLARE @ProduitMadagascarId INT;

    DECLARE @Commande1 INT;
    DECLARE @Commande2 INT;
    DECLARE @Commande3 INT;
    DECLARE @Commande4 INT;

    ------------------------------------------------------------
    -- 1. CLIENTS DE MADAGASCAR
    ------------------------------------------------------------

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.Client
        WHERE ClientId = 'MAD01'
    )
    BEGIN
        INSERT INTO dbo.Client
        (
            ClientId,
            NomSociete,
            ContactNom,
            ContactTitre,
            Adresse,
            Ville,
            Region,
            CodePostal,
            Pays,
            Telephone,
            Fax
        )
        VALUES
        (
            'MAD01',
            'Tana Distribution',
            'Hery Rakoto',
            'Directeur Commercial',
            '25 Avenue de l''Independance',
            'Antananarivo',
            'Analamanga',
            '101',
            'Madagascar',
            '+261202212345',
            '+261202212346'
        );
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.Client
        WHERE ClientId = 'MAD02'
    )
    BEGIN
        INSERT INTO dbo.Client
        (
            ClientId,
            NomSociete,
            ContactNom,
            ContactTitre,
            Adresse,
            Ville,
            Region,
            CodePostal,
            Pays,
            Telephone,
            Fax
        )
        VALUES
        (
            'MAD02',
            'Toamasina Market',
            'Nadia Razafy',
            'Responsable Achats',
            '18 Boulevard Joffre',
            'Toamasina',
            'Atsinanana',
            '501',
            'Madagascar',
            '+261205312345',
            '+261205312346'
        );
    END;

    ------------------------------------------------------------
    -- 2. EMPLOYÉ ANDRY
    ------------------------------------------------------------

    SELECT @EmployeAndryId = EmployeId
    FROM dbo.Employe
    WHERE Nom = 'Rakotomalala'
      AND Prenom = 'Andry';

    IF @EmployeAndryId IS NULL
    BEGIN
        INSERT INTO dbo.Employe
        (
            Nom,
            Prenom,
            Titre,
            Civilite,
            Sexe,
            DateNaissance,
            DateEmbauche,
            Adresse,
            Ville,
            Region,
            CodePostal,
            Pays,
            TelephonePersonnel,
            Extension,
            DependDe,
            SalaireActuel,
            Prime,
            DivisionId,
            ServiceId
        )
        VALUES
        (
            'Rakotomalala',
            'Andry',
            'Commercial',
            'M.',
            'M',
            DATEFROMPARTS(1991, 4, 12),
            DATEFROMPARTS(2006, 2, 15),
            '14 Rue Rainandriamampandry',
            'Antananarivo',
            'Analamanga',
            '101',
            'Madagascar',
            '+261341234567',
            '401',
            NULL,
            7200,
            800,
            2,
            300
        );

        SET @EmployeAndryId = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- 3. EMPLOYÉE FANJA
    ------------------------------------------------------------

    SELECT @EmployeFanjaId = EmployeId
    FROM dbo.Employe
    WHERE Nom = 'Rasoanaivo'
      AND Prenom = 'Fanja';

    IF @EmployeFanjaId IS NULL
    BEGIN
        INSERT INTO dbo.Employe
        (
            Nom,
            Prenom,
            Titre,
            Civilite,
            Sexe,
            DateNaissance,
            DateEmbauche,
            Adresse,
            Ville,
            Region,
            CodePostal,
            Pays,
            TelephonePersonnel,
            Extension,
            DependDe,
            SalaireActuel,
            Prime,
            DivisionId,
            ServiceId
        )
        VALUES
        (
            'Rasoanaivo',
            'Fanja',
            'Resp. commerciale',
            'Mme',
            'F',
            DATEFROMPARTS(1988, 11, 25),
            DATEFROMPARTS(2005, 6, 10),
            '32 Avenue de France',
            'Toamasina',
            'Atsinanana',
            '501',
            'Madagascar',
            '+261321234568',
            '402',
            NULL,
            9800,
            1500,
            2,
            300
        );

        SET @EmployeFanjaId = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- CONTRÔLE DES EMPLOYÉS
    ------------------------------------------------------------

    IF @EmployeAndryId IS NULL
        THROW 50001, 'EmployeId de Andry introuvable.', 1;

    IF @EmployeFanjaId IS NULL
        THROW 50002, 'EmployeId de Fanja introuvable.', 1;

    ------------------------------------------------------------
    -- 4. FOURNISSEUR DE MADAGASCAR
    ------------------------------------------------------------

    SELECT @FournisseurMadagascarId = FournisseurId
    FROM dbo.Fournisseur
    WHERE NomSociete = 'Vanille Madagascar';

    IF @FournisseurMadagascarId IS NULL
    BEGIN
        INSERT INTO dbo.Fournisseur
        (
            NomSociete,
            ContactNom,
            ContactTitre,
            Adresse,
            Ville,
            Region,
            CodePostal,
            Pays,
            Telephone,
            Fax,
            SiteWeb
        )
        VALUES
        (
            'Vanille Madagascar',
            'Jean Randria',
            'Directeur',
            '8 Route de Sambava',
            'Sambava',
            'Sava',
            '208',
            'Madagascar',
            '+261208812345',
            '+261208812346',
            'www.vanille-madagascar.mg'
        );

        SET @FournisseurMadagascarId = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- 5. PRODUIT MALGACHE
    -- CategorieId 3 = Sucreries
    ------------------------------------------------------------

    SELECT @ProduitMadagascarId = ProduitId
    FROM dbo.Produit
    WHERE NomProduit = 'Vanille de Madagascar';

    IF @ProduitMadagascarId IS NULL
    BEGIN
        INSERT INTO dbo.Produit
        (
            NomProduit,
            FournisseurId,
            CategorieId,
            UniteContionnement,
            PrixUnitaire,
            QuantiteEnStock,
            QuantiteEnCommande,
            NiveauReappro,
            EnRupture
        )
        VALUES
        (
            'Vanille de Madagascar',
            @FournisseurMadagascarId,
            3,
            'Boite de 20 sachets',
            55.00,
            120,
            0,
            15,
            0
        );

        SET @ProduitMadagascarId = SCOPE_IDENTITY();
    END;

    IF @ProduitMadagascarId IS NULL
        THROW 50003, 'Produit malgache introuvable.', 1;

    ------------------------------------------------------------
    -- 6. COMMANDE 1 : TANA / ANDRY
    ------------------------------------------------------------

    SELECT @Commande1 = CommandeId
    FROM dbo.Commande
    WHERE ClientId = 'MAD01'
      AND EmployeId = @EmployeAndryId
      AND DateCommande = DATEFROMPARTS(2008, 2, 12);

    IF @Commande1 IS NULL
    BEGIN
        INSERT INTO dbo.Commande
        (
            ClientId,
            EmployeId,
            DateCommande,
            DateDemandee,
            DateExpedition,
            TransporteurId,
            Transport
        )
        VALUES
        (
            'MAD01',
            @EmployeAndryId,
            DATEFROMPARTS(2008, 2, 12),
            DATEFROMPARTS(2008, 2, 22),
            DATEFROMPARTS(2008, 2, 16),
            1,
            65.00
        );

        SET @Commande1 = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- 7. COMMANDE 2 : TANA / FANJA
    ------------------------------------------------------------

    SELECT @Commande2 = CommandeId
    FROM dbo.Commande
    WHERE ClientId = 'MAD01'
      AND EmployeId = @EmployeFanjaId
      AND DateCommande = DATEFROMPARTS(2008, 4, 18);

    IF @Commande2 IS NULL
    BEGIN
        INSERT INTO dbo.Commande
        (
            ClientId,
            EmployeId,
            DateCommande,
            DateDemandee,
            DateExpedition,
            TransporteurId,
            Transport
        )
        VALUES
        (
            'MAD01',
            @EmployeFanjaId,
            DATEFROMPARTS(2008, 4, 18),
            DATEFROMPARTS(2008, 4, 28),
            DATEFROMPARTS(2008, 4, 22),
            2,
            78.00
        );

        SET @Commande2 = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- 8. COMMANDE 3 : TOAMASINA / ANDRY
    ------------------------------------------------------------

    SELECT @Commande3 = CommandeId
    FROM dbo.Commande
    WHERE ClientId = 'MAD02'
      AND EmployeId = @EmployeAndryId
      AND DateCommande = DATEFROMPARTS(2008, 6, 10);

    IF @Commande3 IS NULL
    BEGIN
        INSERT INTO dbo.Commande
        (
            ClientId,
            EmployeId,
            DateCommande,
            DateDemandee,
            DateExpedition,
            TransporteurId,
            Transport
        )
        VALUES
        (
            'MAD02',
            @EmployeAndryId,
            DATEFROMPARTS(2008, 6, 10),
            DATEFROMPARTS(2008, 6, 20),
            DATEFROMPARTS(2008, 6, 14),
            1,
            72.00
        );

        SET @Commande3 = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- 9. COMMANDE 4 : TOAMASINA / FANJA
    ------------------------------------------------------------

    SELECT @Commande4 = CommandeId
    FROM dbo.Commande
    WHERE ClientId = 'MAD02'
      AND EmployeId = @EmployeFanjaId
      AND DateCommande = DATEFROMPARTS(2008, 8, 5);

    IF @Commande4 IS NULL
    BEGIN
        INSERT INTO dbo.Commande
        (
            ClientId,
            EmployeId,
            DateCommande,
            DateDemandee,
            DateExpedition,
            TransporteurId,
            Transport
        )
        VALUES
        (
            'MAD02',
            @EmployeFanjaId,
            DATEFROMPARTS(2008, 8, 5),
            DATEFROMPARTS(2008, 8, 15),
            DATEFROMPARTS(2008, 8, 9),
            3,
            85.00
        );

        SET @Commande4 = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- 10. LIGNES DE LA COMMANDE 1
    ------------------------------------------------------------

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande1
          AND ProduitId = @ProduitMadagascarId
    )
    BEGIN
        INSERT INTO dbo.LigneCommandes
        (
            CommandeId,
            ProduitId,
            PrixUnitaire,
            Quantite,
            Remise
        )
        VALUES
            (@Commande1, @ProduitMadagascarId, 55.00, 20, 0.00);
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande1
          AND ProduitId = 11
    )
    BEGIN
        INSERT INTO dbo.LigneCommandes
        (
            CommandeId,
            ProduitId,
            PrixUnitaire,
            Quantite,
            Remise
        )
        VALUES
            (@Commande1, 11, 21.00, 15, 0.05);
    END;

    ------------------------------------------------------------
    -- 11. LIGNES DE LA COMMANDE 2
    ------------------------------------------------------------

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande2
          AND ProduitId = @ProduitMadagascarId
    )
    BEGIN
        INSERT INTO dbo.LigneCommandes
        (
            CommandeId,
            ProduitId,
            PrixUnitaire,
            Quantite,
            Remise
        )
        VALUES
            (@Commande2, @ProduitMadagascarId, 55.00, 25, 0.10);
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande2
          AND ProduitId = 14
    )
    BEGIN
        INSERT INTO dbo.LigneCommandes
        (
            CommandeId,
            ProduitId,
            PrixUnitaire,
            Quantite,
            Remise
        )
        VALUES
            (@Commande2, 14, 23.25, 20, 0.00);
    END;

    ------------------------------------------------------------
    -- 12. LIGNES DE LA COMMANDE 3
    ------------------------------------------------------------

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande3
          AND ProduitId = @ProduitMadagascarId
    )
    BEGIN
        INSERT INTO dbo.LigneCommandes
        (
            CommandeId,
            ProduitId,
            PrixUnitaire,
            Quantite,
            Remise
        )
        VALUES
            (@Commande3, @ProduitMadagascarId, 55.00, 30, 0.05);
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande3
          AND ProduitId = 31
    )
    BEGIN
        INSERT INTO dbo.LigneCommandes
        (
            CommandeId,
            ProduitId,
            PrixUnitaire,
            Quantite,
            Remise
        )
        VALUES
            (@Commande3, 31, 12.50, 25, 0.00);
    END;

    ------------------------------------------------------------
    -- 13. LIGNES DE LA COMMANDE 4
    ------------------------------------------------------------

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande4
          AND ProduitId = @ProduitMadagascarId
    )
    BEGIN
        INSERT INTO dbo.LigneCommandes
        (
            CommandeId,
            ProduitId,
            PrixUnitaire,
            Quantite,
            Remise
        )
        VALUES
            (@Commande4, @ProduitMadagascarId, 55.00, 40, 0.10);
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande4
          AND ProduitId = 1
    )
    BEGIN
        INSERT INTO dbo.LigneCommandes
        (
            CommandeId,
            ProduitId,
            PrixUnitaire,
            Quantite,
            Remise
        )
        VALUES
            (@Commande4, 1, 18.00, 20, 0.05);
    END;

    COMMIT TRANSACTION;

    PRINT 'Insertion Madagascar réussie.';

END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    SELECT
        ERROR_NUMBER() AS NumeroErreur,
        ERROR_LINE() AS LigneErreur,
        ERROR_MESSAGE() AS MessageErreur;

END CATCH;
GO