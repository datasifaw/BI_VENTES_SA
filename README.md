
# 📊 BI_VENTES_SA — Sales Analytics Dashboard

## 📌 Présentation du projet

**BI_VENTES_SA** est un projet de Business Intelligence réalisé avec **SQL Server, Power Query, DAX et Power BI**.

L'objectif est de construire un tableau de bord décisionnel permettant d'analyser les performances commerciales d'une entreprise à travers plusieurs axes :

* chiffre d'affaires ;
* évolution des ventes ;
* clients ;
* produits et catégories ;
* fournisseurs ;
* employés ;
* expéditions et transporteurs ;
* répartition géographique des clients et du chiffre d'affaires.

Le projet couvre l'ensemble du processus BI, depuis les données stockées dans SQL Server jusqu'à la création d'un dashboard interactif dans Power BI.

---

## 🎯 Objectifs

Le tableau de bord permet notamment de répondre aux questions suivantes :

* Quel est le chiffre d'affaires global ?
* Comment évoluent les ventes dans le temps ?
* Quels sont les meilleurs clients ?
* Quels produits génèrent le plus de chiffre d'affaires ?
* Quelles catégories sont les plus performantes ?
* Quels produits sont en rupture ou en stock faible ?
* Quels employés réalisent le plus de ventes ?
* Comment se répartissent les commandes entre les transporteurs ?
* Quels pays et quelles villes génèrent le plus de chiffre d'affaires ?
* Quels jours et quels mois présentent les meilleures performances commerciales ?

---

## 🛠️ Technologies utilisées

| Technologie         | Utilisation                             |
| ------------------- | --------------------------------------- |
| **SQL Server**      | Stockage et interrogation des données   |
| **SQL**             | Requêtes, agrégations et vues           |
| **Power Query / M** | Nettoyage et transformation des données |
| **Power BI**        | Modélisation et visualisation           |
| **DAX**             | KPI, mesures et analyses                |
| **Git / GitHub**    | Versionnement et documentation          |

---

## 🔄 Architecture du projet

Le processus BI utilisé est le suivant :

**SQL Server → Power Query → Modèle de données → DAX → Power BI Dashboard**

### 1. SQL Server

La base contient notamment les tables :

* `Client`
* `Commande`
* `LigneCommandes`
* `Produit`
* `Categorie`
* `Fournisseur`
* `Employe`
* `Transporteur`
* `Division`
* `Service`
* `HistoriqueSalaires`

### 2. Power Query

Power Query est utilisé pour préparer les données avant leur exploitation.

Exemples de transformations :

* nettoyage des données ;
* correction des types ;
* gestion des valeurs nulles ;
* création de colonnes conditionnelles ;
* création du statut de stock ;
* création du nom complet des employés ;
* construction d'une adresse complète pour la cartographie.

Exemple :

```text
Adresse + Ville + Code Postal + Pays
→ AdresseComplete
```

Le statut des produits permet également de distinguer :

```text
Disponible
Stock faible
En rupture
```

---

## 🗂️ Modélisation des données

Le modèle Power BI est organisé autour des tables transactionnelles :

* `Commande`
* `LigneCommandes`

et de plusieurs dimensions :

* Client
* Produit
* Catégorie
* Fournisseur
* Employé
* Transporteur
* Calendrier

La table `Calendrier` permet d'effectuer les analyses temporelles par :

* année ;
* trimestre ;
* mois ;
* jour ;
* jour de la semaine.

---

# 📐 Mesures DAX principales

## Chiffre d'affaires

```DAX
CA Brut =
SUMX (
    LigneCommandes,
    LigneCommandes[PrixUnitaire] * LigneCommandes[Quantite]
)
```

Le projet utilise également une mesure de **CA Net** tenant compte des remises.

---

## Montant des remises

```DAX
Montant Remise =
[CA Brut] - [CA Net]
```

---

## Taux de remise

```DAX
Taux de Remise =
DIVIDE (
    [Montant Remise],
    [CA Brut],
    0
)
```

---

## Nombre de clients

```DAX
Nombre Clients =
DISTINCTCOUNT ( Client[ClientId] )
```

---

## Nombre de commandes

```DAX
Nombre Commandes =
DISTINCTCOUNT ( Commande[CommandeId] )
```

---

## Nombre de produits

```DAX
Nombre Produits =
DISTINCTCOUNT ( Produit[ProduitId] )
```

---

## Nombre de produits en rupture

```DAX
Nombre Produits en Rupture =
CALCULATE (
    [Nombre Produits],
    Produit[EnRupture] = TRUE ()
)
```

---

## Taux de rupture

```DAX
Taux de Rupture =
DIVIDE (
    [Nombre Produits en Rupture],
    [Nombre Produits],
    0
)
```

---

# 📊 Pages du dashboard

## 1 — Vue Exécutive

Vue synthétique destinée au pilotage global de l'activité commerciale.

Principaux KPI :

* CA Brut ;
* CA Net ;
* nombre de clients ;
* quantité vendue ;
* taux de remise ;
* panier moyen ;
* nombre de commandes.

Analyses :

* évolution du CA ;
* CA par catégorie ;
* Top clients ;
* Top produits.

---

## 2 — Analyse des Ventes

Analyse temporelle détaillée des performances commerciales.

Elle contient notamment :

* CA par année ;
* CA par trimestre ;
* analyse mensuelle ;
* filtres par année, trimestre, catégorie, fournisseur et produit ;
* heatmap des ventes.

### Heatmap Mois × Jour

Une matrice avec mise en forme conditionnelle permet d'identifier les périodes générant le plus de chiffre d'affaires.

Elle croise :

**Mois × Jour de la semaine × CA Net**

---

## 3 — Analyse Clients

Cette page permet d'analyser le portefeuille clients.

KPI :

* nombre de clients ;
* clients actifs ;
* CA Net ;
* commandes moyennes par client ;
* panier moyen ;
* CA moyen par client ;
* nombre de commandes.

Une segmentation des clients est également utilisée :

* `CLIENT OCCASIONNEL`
* `CLIENT FREQUENT`
* `CLIENT FIDEL`
* `SUPER CLIENT`

Analyses :

* Top clients ;
* CA par typologie ;
* nombre de commandes ;
* détail des clients.

---

## 4 — Analyse Produits

Cette page est consacrée aux performances produits et à la gestion des stocks.

KPI :

* nombre de produits ;
* produits en rupture ;
* taux de rupture ;
* quantité vendue ;
* prix moyen.

Analyses :

* Top produits ;
* Top catégories ;
* quantité vendue par catégorie ;
* Top fournisseurs ;
* catalogue produits ;
* disponibilité et état du stock.

Le rapport permet de filtrer les produits selon :

```text
Disponible
Stock faible
En rupture
```

---

## 5 — Analyse Employés

Cette page analyse la contribution commerciale des employés.

KPI :

* nombre d'employés ;
* CA Net ;
* nombre de commandes ;
* quantité vendue ;
* CA moyen par employé ;
* commandes moyennes par employé.

Analyses :

* Top employés ;
* commandes par employé ;
* quantité vendue ;
* évolution du CA par employé ;
* tableau détaillé des performances.

---

## 6 — Expéditions & Transporteurs

Cette page analyse les commandes expédiées et l'activité des transporteurs à partir des informations disponibles dans la base.

Elle permet notamment d'étudier :

* nombre de commandes expédiées ;
* transporteurs ;
* délais d'expédition ;
* commandes expédiées à temps ;
* répartition des commandes par transporteur ;
* chiffre d'affaires associé aux transporteurs.

---

## 7 — Analyse Géographique

Cette page permet d'analyser géographiquement le portefeuille clients et les performances commerciales.

KPI :

* nombre de clients ;
* clients actifs ;
* CA Net ;
* nombre de pays ;
* nombre de villes.

Analyses :

* carte des clients ;
* répartition géographique du chiffre d'affaires ;
* CA par pays ;
* clients par pays ;
* Top villes.

Une colonne `AdresseComplete` a été créée dans Power Query pour améliorer la géolocalisation :

```text
Adresse, Ville, Code Postal, Pays
```

---

# 🔎 Exemples d'indicateurs obtenus

Sur le jeu de données utilisé, le dashboard permet notamment d'observer :

| KPI                 |    Valeur |
| ------------------- | --------: |
| CA Net              | ≈ 6,46 M€ |
| Clients             |       124 |
| Clients actifs      |        88 |
| Commandes           |     5 456 |
| Produits            |        78 |
| Quantité vendue     |    ≈ 239K |
| Produits en rupture |         8 |
| Taux de rupture     |  ≈ 10,3 % |
| Pays représentés    |        27 |
| Villes représentées |        93 |

---

# 🎨 Design et expérience utilisateur

Le dashboard utilise une identité visuelle cohérente inspirée du branding **SAZOTECH Solutions**.

Les pages utilisent principalement :

* bleu clair comme couleur principale ;
* arrière-plans clairs ;
* cartes KPI ;
* segments interactifs ;
* graphiques homogènes ;
* navigation entre les différentes analyses.

Des boutons de navigation permettent de passer rapidement entre :

**Accueil → Vue Exécutive → Ventes → Clients → Produits → Employés → Expéditions → Cartographie**

Un bouton de réinitialisation utilisant les **Bookmarks Power BI** permet également de remettre les filtres d'une page dans leur état initial.

---

# 📂 Organisation du repository

```text
BI_VENTES_SA/
│
├── README.md
│
├── .gitignore
│
├── PowerBI/
│   └── BI_VENTES_SA.pbix
│
├── SQL/
│   ├── requetes.sql
│   └── vues.sql
│
├── DAX/
│   └── mesures_dax.md
│
├── PowerQuery/
│   └── transformations.md
│
├── Documentation/
│   └── modele_donnees.png
│
└── Images/
    ├── 01_vue_executive.png
    ├── 02_analyse_ventes.png
    ├── 03_analyse_clients.png
    ├── 04_analyse_produits.png
    ├── 05_analyse_employes.png
    ├── 06_expeditions.png
    └── 07_cartographie.png
```

---

# 🚀 Compétences mises en œuvre

Ce projet met en pratique plusieurs compétences en Business Intelligence :

### SQL

* SELECT
* JOIN
* GROUP BY
* CASE
* fonctions d'agrégation
* vues SQL
* analyse de données relationnelles

### Power Query

* nettoyage des données ;
* transformation ;
* colonnes conditionnelles ;
* concaténation ;
* gestion des valeurs nulles ;
* préparation des dimensions.

### Modélisation

* relations 1:N ;
* tables de faits ;
* dimensions ;
* calendrier ;
* propagation des filtres.

### DAX

* `CALCULATE`
* `DISTINCTCOUNT`
* `SUM`
* `SUMX`
* `DIVIDE`
* `AVERAGEX`
* `FILTER`
* `SWITCH`
* `DATEDIFF`

### Data Visualization

* KPI ;
* histogrammes ;
* courbes ;
* matrices ;
* heatmap ;
* Top/Bottom N ;
* cartographie ;
* filtres interactifs ;
* tableaux détaillés.

---

# 🔐 Sécurité

Les identifiants de connexion SQL Server, mots de passe et autres informations sensibles ne sont pas inclus dans ce repository.

La connexion à la base de données doit être configurée localement avant l'actualisation du rapport.

---

# 👤 Auteur

**Sazotech**

Projet Business Intelligence — **BI_VENTES_SA**

**SQL Server • Power Query • DAX • Power BI**

---

## ⭐ À propos

Ce projet a été réalisé dans un objectif d'apprentissage et de démonstration des compétences en **Data Analytics et Business Intelligence**.

Il illustre la construction complète d'une solution décisionnelle, depuis une base SQL Server jusqu'à un tableau de bord Power BI interactif.
