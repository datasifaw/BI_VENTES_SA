USE Ventes;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @HamzaId INT;
    DECLARE @SaraId INT;

    DECLARE @Commande1 INT;
    DECLARE @Commande2 INT;
    DECLARE @Commande3 INT;
    DECLARE @Commande4 INT;

    ------------------------------------------------------------
    -- 1. EMPLOYÉ HAMZA
    ------------------------------------------------------------

    SELECT @HamzaId = EmployeId
    FROM dbo.Employe
    WHERE Nom = 'Alaoui'
      AND Prenom = 'Hamza';

    IF @HamzaId IS NULL
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
            'Alaoui',
            'Hamza',
            'Commercial',
            'M.',
            'M',
            DATEFROMPARTS(1992, 5, 10),
            DATEFROMPARTS(2007, 1, 15),
            '45 Avenue Mohammed VI',
            'Rabat',
            'Rabat-Sale',
            '10000',
            'Maroc',
            '+212661234567',
            '301',
            NULL,
            8500,
            1000,
            2,
            300
        );

        SET @HamzaId = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- 2. EMPLOYÉE SARA
    ------------------------------------------------------------

    SELECT @SaraId = EmployeId
    FROM dbo.Employe
    WHERE Nom = 'Bennani'
      AND Prenom = 'Sara';

    IF @SaraId IS NULL
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
            'Bennani',
            'Sara',
            'Resp. commerciale',
            'Mme',
            'F',
            DATEFROMPARTS(1989, 9, 18),
            DATEFROMPARTS(2006, 3, 10),
            '22 Boulevard Zerktouni',
            'Casablanca',
            'Casablanca',
            '20100',
            'Maroc',
            '+212662345678',
            '302',
            NULL,
            12000,
            2000,
            2,
            300
        );

        SET @SaraId = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- CONTRÔLE DES IDENTIFIANTS EMPLOYÉS
    ------------------------------------------------------------

    IF @HamzaId IS NULL
        THROW 50001, 'Impossible de récupérer EmployeId de Hamza.', 1;

    IF @SaraId IS NULL
        THROW 50002, 'Impossible de récupérer EmployeId de Sara.', 1;

    ------------------------------------------------------------
    -- 3. COMMANDE 1 : ATLAS / HAMZA
    ------------------------------------------------------------

    SELECT @Commande1 = CommandeId
    FROM dbo.Commande
    WHERE ClientId = 'ATLAS'
      AND EmployeId = @HamzaId
      AND DateCommande = DATEFROMPARTS(2008, 1, 10);

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
            'ATLAS',
            @HamzaId,
            DATEFROMPARTS(2008, 1, 10),
            DATEFROMPARTS(2008, 1, 20),
            DATEFROMPARTS(2008, 1, 13),
            1,
            45.00
        );

        SET @Commande1 = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- 4. COMMANDE 2 : ATLAS / SARA
    ------------------------------------------------------------

    SELECT @Commande2 = CommandeId
    FROM dbo.Commande
    WHERE ClientId = 'ATLAS'
      AND EmployeId = @SaraId
      AND DateCommande = DATEFROMPARTS(2008, 3, 5);

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
            'ATLAS',
            @SaraId,
            DATEFROMPARTS(2008, 3, 5),
            DATEFROMPARTS(2008, 3, 15),
            DATEFROMPARTS(2008, 3, 9),
            2,
            60.00
        );

        SET @Commande2 = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- 5. COMMANDE 3 : MARRAKECH / HAMZA
    ------------------------------------------------------------

    SELECT @Commande3 = CommandeId
    FROM dbo.Commande
    WHERE ClientId = 'MARRA'
      AND EmployeId = @HamzaId
      AND DateCommande = DATEFROMPARTS(2008, 5, 12);

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
            'MARRA',
            @HamzaId,
            DATEFROMPARTS(2008, 5, 12),
            DATEFROMPARTS(2008, 5, 22),
            DATEFROMPARTS(2008, 5, 16),
            1,
            55.00
        );

        SET @Commande3 = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- 6. COMMANDE 4 : MARRAKECH / SARA
    ------------------------------------------------------------

    SELECT @Commande4 = CommandeId
    FROM dbo.Commande
    WHERE ClientId = 'MARRA'
      AND EmployeId = @SaraId
      AND DateCommande = DATEFROMPARTS(2008, 7, 8);

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
            'MARRA',
            @SaraId,
            DATEFROMPARTS(2008, 7, 8),
            DATEFROMPARTS(2008, 7, 18),
            DATEFROMPARTS(2008, 7, 11),
            3,
            72.00
        );

        SET @Commande4 = SCOPE_IDENTITY();
    END;

    ------------------------------------------------------------
    -- 7. LIGNES DE LA COMMANDE 1
    ------------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande1
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
            (@Commande1, 1, 18.00, 20, 0.00);
    END;

    IF NOT EXISTS
    (
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
    -- 8. LIGNES DE LA COMMANDE 2
    ------------------------------------------------------------

    IF NOT EXISTS
    (
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
            (@Commande2, 14, 23.25, 25, 0.10);
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande2
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
            (@Commande2, 31, 12.50, 30, 0.00);
    END;

    ------------------------------------------------------------
    -- 9. LIGNES DE LA COMMANDE 3
    ------------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande3
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
            (@Commande3, 1, 18.00, 40, 0.05);
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande3
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
            (@Commande3, 14, 23.25, 10, 0.00);
    END;

    ------------------------------------------------------------
    -- 10. LIGNES DE LA COMMANDE 4
    ------------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande4
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
            (@Commande4, 11, 21.00, 50, 0.10);
    END;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.LigneCommandes
        WHERE CommandeId = @Commande4
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
            (@Commande4, 31, 12.50, 20, 0.05);
    END;

    COMMIT TRANSACTION;

    PRINT 'Insertion Maroc réussie.';

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