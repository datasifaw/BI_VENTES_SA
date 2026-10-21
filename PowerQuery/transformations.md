# 🔄 Transformations Power Query — BI_VENTES_SA

## 1. Présentation

Ce document présente les transformations de données réalisées avec **Power Query** dans le cadre du projet de Business Intelligence `BI_VENTES_SA`.

**Source des données :** SQL Server — Base `Ventes`

**Outils :** Power BI Desktop, Power Query, langage M

### Objectifs

- Préparer les données issues de SQL Server.
- Créer des colonnes nécessaires aux analyses.
- Faciliter les calculs des indicateurs de performance.
- Améliorer la lisibilité des données.
- Préparer les informations géographiques.
- Alimenter le modèle de données Power BI.

---

## 2. Table `LigneCommandes`

### Création de la colonne `Montant Ligne`

**Objectif :** calculer le montant net de chaque ligne de commande en tenant compte de la remise.

**Colonnes utilisées :**

- `PrixUnitaire`
- `Quantite`
- `Remise`

**Formule Power Query :**

```powerquery
[PrixUnitaire] * [Quantite] * (1 - [Remise])
```

**Exemple :**

| Prix unitaire | Quantité | Remise | Montant Ligne |
|---:|---:|---:|---:|
| 100 | 5 | 0,10 | 450 |
| 50 | 4 | 0 | 200 |
| 80 | 3 | 0,20 | 192 |

**Utilisation dans Power BI :**

Cette colonne est utilisée pour calculer le chiffre d'affaires net.

```DAX
CA Total =
SUM ( LigneCommandes[Montant Ligne] )
```

**Type recommandé :** Nombre décimal fixe ou nombre décimal, selon la précision nécessaire.

---

## 3. Table `Employe`

### Création de la colonne `Nom complet`

**Objectif :** regrouper le prénom et le nom des employés dans un seul champ.

**Colonnes utilisées :**

- `Prenom`
- `Nom`

**Formule Power Query :**

```powerquery
[Prenom] & " " & [Nom]
```

**Exemple :**

| Prenom | Nom | Nom complet |
|---|---|---|
| Jean | Dupont | Jean Dupont |
| Marie | Martin | Marie Martin |

*Les noms ci-dessus sont des exemples illustratifs.*

**Utilisation dans Power BI :**

- Classement des employés par chiffre d'affaires.
- Nombre de commandes par employé.
- Quantité vendue par employé.
- Tableau détaillé des performances commerciales.
- Filtres par employé.

**Type de données :** Texte.

---

## 4. Table `Produit`

### Création de la colonne `Statut Stock`

**Objectif :** classer les produits selon leur disponibilité.

**Colonnes utilisées :**

- `EnRupture`
- `QuantiteEnStock`
- `NiveauReappro`

### Règles de classification

| Condition | Statut |
|---|---|
| Produit signalé en rupture ou stock nul | En rupture |
| Stock inférieur ou égal au niveau de réapprovisionnement | Stock faible |
| Stock supérieur au seuil | Disponible |

### Exemple de formule Power Query

```powerquery
if [EnRupture] = true or [QuantiteEnStock] = 0 then
    "En rupture"
else if [QuantiteEnStock] <= [NiveauReappro] then
    "Stock faible"
else
    "Disponible"
```

**Attention :** cette formule illustre la logique de classification. Dans le fichier Power BI, la condition exacte dépend notamment du type de la colonne `EnRupture` : booléen (`true/false`) ou numérique (`1/0`).

**Utilisation dans Power BI :**

- Segmentation des produits par état du stock.
- Identification des produits en rupture.
- Analyse des produits nécessitant un réapprovisionnement.
- Filtrage du catalogue produits.

**Type de données :** Texte.

---

## 5. Table `Client`

### Création de la colonne `AdresseComplete`

**Objectif :** regrouper les informations géographiques pour améliorer l'exploitation des adresses dans les cartes Power BI.

**Colonnes utilisées :**

- `Adresse`
- `Ville`
- `CodePostal`
- `Pays`

### Exemple de formule Power Query

```powerquery
Text.Combine(
    List.RemoveNulls({
        [Adresse],
        [Ville],
        Text.From([CodePostal]),
        [Pays]
    }),
    ", "
)
```

Cette formule construit une adresse à partir des champs disponibles et ignore les valeurs nulles.

**Exemple :**

| Adresse | Ville | Pays | AdresseComplete |
|---|---|---|---|
| 10 rue Exemple | Paris | France | 10 rue Exemple, Paris, 75000, France |
| 20 avenue Exemple | Casablanca | Maroc | 20 avenue Exemple, Casablanca, 20000, Maroc |

*Les adresses sont fictives.*

**Utilisation dans Power BI :**

- Cartographie des clients.
- Répartition géographique du chiffre d'affaires.
- Analyse par pays et par ville.
- Tableau détaillé des adresses clients.

**Type de données :** Texte.

---

## 6. Vérification des types de données

Les types de données doivent être cohérents avec leur utilisation dans le modèle.

| Table | Colonnes | Type attendu |
|---|---|---|
| Client | ClientId | Nombre entier |
| Client | NomSociete, Ville, Pays | Texte |
| Client | CodePostal | Texte |
| Commande | CommandeId, ClientId, EmployeId | Nombre entier |
| Commande | DateCommande, DateDemandee, DateExpedition | Date ou Date/Heure |
| LigneCommandes | PrixUnitaire, Remise, Montant Ligne | Numérique |
| LigneCommandes | Quantite | Nombre entier |
| Produit | ProduitId, CategorieId, FournisseurId | Nombre entier |
| Produit | PrixUnitaire | Numérique |
| Produit | QuantiteEnStock, NiveauReappro | Nombre entier |
| Employe | EmployeId | Nombre entier |
| Employe | DateEmbauche, DateNaissance | Date ou Date/Heure |
| Transporteur | TransporteurId | Nombre entier |

**Remarque :** ce tableau décrit les types attendus. Il ne confirme pas que chaque conversion a été réalisée manuellement dans Power Query.

---

## 7. Vérification des valeurs nulles

Les champs à contrôler comprennent notamment :

- `Commande[DateExpedition]` : une valeur vide peut représenter une commande non encore expédiée.
- `Commande[DateDemandee]` : nécessaire pour certaines analyses de respect des délais.
- `Client[Region]` : peut être vide selon le pays.
- `Client[CodePostal]` : peut être absent.
- `Client[Adresse]` : utilisé pour construire l'adresse complète.

Il est important de ne pas remplacer systématiquement les valeurs nulles par zéro ou par une date fictive.

Par exemple, une date d'expédition vide peut être une information métier significative.

---

## 8. Préparation des données temporelles

Le projet utilise les dates de la table `Commande`, principalement :

- `DateCommande`
- `DateDemandee`
- `DateExpedition`

Elles servent à analyser :

- l'évolution des ventes ;
- les délais d'expédition ;
- les commandes expédiées ;
- les commandes non expédiées ;
- les expéditions par transporteur.

### Table Calendrier

La table `Calendrier` est créée dans **Power BI avec DAX**, et non dans Power Query.

Elle comprend notamment :

- Date
- Année
- Mois N°
- Nom du mois
- Mois Court
- Trimestre
- Jour
- Jour Semaine
- Num Jour Semaine
- Année-Mois

Cette distinction est importante pour documenter correctement les technologies utilisées.

---

## 9. Préparation du modèle relationnel

Après les transformations Power Query, les données sont chargées dans le modèle Power BI.

Les principales relations utilisées sont :

- `Client` → `Commande`
- `Employe` → `Commande`
- `Transporteur` → `Commande`
- `Commande` → `LigneCommandes`
- `Produit` → `LigneCommandes`
- `Categorie` → `Produit`
- `Fournisseur` → `Produit`
- `Calendrier` → `Commande`

Les relations sont configurées dans la **vue Modèle de Power BI**, et ne constituent pas des transformations Power Query.

---

## 10. Utilisation des données transformées

| Table | Transformation ou préparation | Page Power BI |
|---|---|---|
| LigneCommandes | Montant Ligne | Vue Exécutive, Ventes, Clients, Produits |
| Employe | Nom complet | Analyse Employés |
| Produit | Statut Stock | Analyse Produits |
| Client | AdresseComplete | Cartographie |
| Commande | Vérification des dates | Ventes, Expéditions |
| Calendrier | Table créée en DAX | Analyses temporelles |

---

## 11. Contrôles de qualité recommandés

Avant la publication du projet :

- Vérifier les types des identifiants et des dates.
- Vérifier les valeurs nulles dans les colonnes utilisées.
- Contrôler la cohérence des montants calculés.
- Vérifier que les remises sont exprimées dans le format attendu.
- Contrôler les statuts de stock.
- Vérifier les adresses utilisées dans les cartes.
- Vérifier les relations entre les tables.
- Tester l'actualisation depuis SQL Server.

Ces contrôles sont des recommandations et ne constituent pas un historique certifié des étapes exécutées.

---

## 12. Résultat

Les transformations Power Query permettent de préparer les données pour les différentes analyses du dashboard :

1. Vue Exécutive
2. Analyse des Ventes
3. Analyse Clients
4. Analyse Produits
5. Analyse Employés
6. Expéditions & Transporteurs
7. Cartographie

**Chaîne de traitement :**

SQL Server → Power Query → Modèle de données → DAX → Power BI

---

## 13. Limites de la documentation

Ce document décrit les transformations connues du projet et les contrôles recommandés.

Pour obtenir une documentation exhaustive et strictement identique au fichier `.pbix`, il faut consulter le code M de chaque requête dans **Power BI Desktop → Transformer les données → Éditeur avancé**.

Les formules données à titre d'exemple doivent être comparées aux étapes réellement appliquées avant d'être présentées comme le code source exact du projet.
