# 📊 Mesures DAX — BI_VENTES_SA

Documentation des principales mesures DAX utilisées dans le dashboard Power BI **BI_VENTES_SA**.

## 1. Analyse des ventes

### CA Total (CA Net)

```DAX
CA Total =
SUM ( LigneCommandes[Montant Ligne] )
```

Le montant des lignes tient compte des remises appliquées.

### CA Brut

```DAX
CA Brut =
SUMX (
    LigneCommandes,
    LigneCommandes[PrixUnitaire] * LigneCommandes[Quantite]
)
```

### Montant Remise

```DAX
Montant Remise =
[CA Brut] - [CA Total]
```

### Taux de Remise

```DAX
Taux de Remise =
DIVIDE (
    [Montant Remise],
    [CA Brut],
    0
)
```

### Nombre Commandes

```DAX
Nombre Commandes =
DISTINCTCOUNT ( Commande[CommandeId] )
```

### Quantité Vendue

```DAX
Quantité Vendue =
SUM ( LigneCommandes[Quantite] )
```

### Panier Moyen

```DAX
Panier Moyen =
DIVIDE (
    [CA Total],
    [Nombre Commandes],
    0
)
```

---

## 2. Analyse des clients

### Nombre Clients

```DAX
Nombre Clients =
DISTINCTCOUNT ( Client[ClientId] )
```

### Clients Actifs

```DAX
Clients Actifs =
DISTINCTCOUNT ( Commande[ClientId] )
```

### CA Moyen par Client

```DAX
CA Moyen par Client =
DIVIDE (
    [CA Total],
    [Clients Actifs],
    0
)
```

### Commandes Moyennes par Client

```DAX
Commandes Moyennes par Client =
DIVIDE (
    [Nombre Commandes],
    [Clients Actifs],
    0
)
```

### Nombre Commandes Client

*Colonne calculée dans la table `Client`.*

```DAX
Nombre Commandes Client =
CALCULATE (
    DISTINCTCOUNT ( Commande[CommandeId] )
)
```

### Typologie Client

*Colonne calculée dans la table `Client`.*

```DAX
Typologie Client =
VAR NbCommandes = Client[Nombre Commandes Client]
RETURN
    SWITCH (
        TRUE (),
        NbCommandes <= 10, "CLIENT OCCASIONNEL",
        NbCommandes <= 20, "CLIENT FREQUENT",
        NbCommandes <= 30, "CLIENT FIDEL",
        "SUPER CLIENT"
    )
```

---

## 3. Analyse des produits

### Nombre Produits

```DAX
Nombre Produits =
DISTINCTCOUNT ( Produit[ProduitId] )
```

### Nombre Produits en Rupture

```DAX
Nombre Produits en Rupture =
CALCULATE (
    [Nombre Produits],
    Produit[EnRupture] = 1
)
```

*Si `EnRupture` est de type booléen, remplacer `1` par `TRUE()`.*

### Taux de Rupture

```DAX
Taux de Rupture =
DIVIDE (
    [Nombre Produits en Rupture],
    [Nombre Produits],
    0
)
```

### Prix Moyen Produit

```DAX
Prix Moyen Produit =
AVERAGE ( Produit[PrixUnitaire] )
```

---

## 4. Analyse des employés

### Nombre Employés

```DAX
Nombre Employés =
DISTINCTCOUNT ( Employe[EmployeId] )
```

### CA Moyen par Employé

```DAX
CA Moyen par Employé =
DIVIDE (
    [CA Total],
    [Nombre Employés],
    0
)
```

### Commandes Moyennes par Employé

```DAX
Commandes Moyennes par Employé =
DIVIDE (
    [Nombre Commandes],
    [Nombre Employés],
    0
)
```

---

## 5. Analyse temporelle

Ces mesures utilisent la table `Calendrier`, reliée à `Commande[DateCommande]`.

### CA Année Précédente

```DAX
CA Année Précédente =
CALCULATE (
    [CA Total],
    SAMEPERIODLASTYEAR ( Calendrier[Date] )
)
```

### Évolution CA

```DAX
Évolution CA =
[CA Total] - [CA Année Précédente]
```

### Évolution CA %

```DAX
Évolution CA % =
DIVIDE (
    [Évolution CA],
    [CA Année Précédente]
)
```

### CA YTD

```DAX
CA YTD =
TOTALYTD (
    [CA Total],
    Calendrier[Date]
)
```

### CA MTD

```DAX
CA MTD =
TOTALMTD (
    [CA Total],
    Calendrier[Date]
)
```

---

## 6. Expéditions et transporteurs

### Nombre Transporteurs

```DAX
Nombre Transporteurs =
DISTINCTCOUNT ( Transporteur[TransporteurId] )
```

### Commandes Expédiées

```DAX
Commandes Expédiées =
CALCULATE (
    [Nombre Commandes],
    NOT ISBLANK ( Commande[DateExpedition] )
)
```

### Commandes Non Expédiées

```DAX
Commandes Non Expédiées =
CALCULATE (
    [Nombre Commandes],
    ISBLANK ( Commande[DateExpedition] )
)
```

### Taux Expédition

```DAX
Taux Expédition =
DIVIDE (
    [Commandes Expédiées],
    [Nombre Commandes],
    0
)
```

### Délai Moyen Expédition

```DAX
Délai Moyen Expédition =
AVERAGEX (
    FILTER (
        Commande,
        NOT ISBLANK ( Commande[DateExpedition] )
    ),
    DATEDIFF (
        Commande[DateCommande],
        Commande[DateExpedition],
        DAY
    )
)
```

### Commandes Expédiées à Temps

```DAX
Commandes Expédiées à Temps =
CALCULATE (
    [Nombre Commandes],
    FILTER (
        Commande,
        NOT ISBLANK ( Commande[DateExpedition] )
            && NOT ISBLANK ( Commande[DateDemandee] )
            && Commande[DateExpedition] <= Commande[DateDemandee]
    )
)
```

### Taux Expédition à Temps

```DAX
Taux Expédition à Temps =
DIVIDE (
    [Commandes Expédiées à Temps],
    [Commandes Expédiées],
    0
)
```

### Commandes Expédiées en Retard

```DAX
Commandes Expédiées en Retard =
[Commandes Expédiées] - [Commandes Expédiées à Temps]
```

*Attention : ces mesures comparent la date d'expédition à la date demandée. Elles ne mesurent pas la date réelle de livraison.*

---

## 7. Analyse géographique

### Nombre de Pays

```DAX
Nombre de Pays =
DISTINCTCOUNT ( Client[Pays] )
```

### Nombre de Villes

```DAX
Nombre de Villes =
DISTINCTCOUNT ( Client[Ville] )
```

---

## 8. Colonne calculée dans Power Query

### Montant Ligne

Cette colonne est créée dans Power Query, et non avec DAX.

```powerquery
[PrixUnitaire] * [Quantite] * (1 - [Remise])
```

Elle constitue la base de calcul du chiffre d'affaires net.

---

## Notes techniques

- Les mesures sont regroupées dans une table dédiée `_Mesures`.
- Les indicateurs financiers reposent sur `LigneCommandes`.
- Les analyses temporelles utilisent la table `Calendrier`.
- Les mesures réagissent au contexte de filtre du rapport Power BI.
- Les mesures de pourcentage doivent être formatées en `%`.
- Les mesures monétaires doivent utiliser un format monétaire cohérent.
- Les formules présentées correspondent à la documentation de notre projet et doivent être vérifiées par rapport aux noms exacts utilisés dans le fichier `.pbix` final.
