# 📊 BI_VENTES_SA | Sales Analytics Dashboard

### 🚀 End-to-End Business Intelligence Project

**SQL Server • Power Query • Data Modeling • DAX • Power BI • GitHub**

---

## 🌟 Présentation du projet :

**BI_VENTES_SA** est un projet complet de Business Intelligence consacré à l'analyse des performances commerciales d'une entreprise.

Il repose sur une base de données relationnelle **SQL Server** et un tableau de bord interactif développé avec **Microsoft Power BI**.

L'objectif est de transformer les données transactionnelles en indicateurs décisionnels pour faciliter le suivi de l'activité commerciale, l'identification des tendances et l'analyse des performances.

Le dashboard couvre sept domaines d'analyse : ventes, clients, produits, employés, expéditions, transporteurs et géographie.


### 🎯 Objectifs métier

- Suivre le chiffre d'affaires brut et net.
- Analyser l'évolution des ventes dans le temps.
- Identifier les clients les plus rentables.
- Étudier les performances des produits et catégories.
- Surveiller les ruptures de stock.
- Évaluer la contribution commerciale des employés.
- Analyser les délais d'expédition et les transporteurs.
- Visualiser la répartition géographique des clients et du chiffre d'affaires.

---

## 📸 Aperçu du dashboard

### Vue Exécutive

![Vue Exécutive](Dashboard_POWER_BI_VENTES/01_vue_executive.png)

*Vue synthétique des principaux indicateurs commerciaux.*

---

## 📈 Key Performance Indicators

Les résultats suivants correspondent au jeu de données utilisé dans le projet.

| Indicateur | Valeur |
|:---|---:|
| 💰 Chiffre d'affaires net | **≈ 6,46 M€** |
| 🧾 Nombre de commandes | **5 456** |
| 👥 Nombre de clients | **124** |
| ✅ Clients actifs | **88** |
| 📦 Nombre de produits | **78** |
| 🛒 Quantité vendue | **≈ 239 K** |
| ⚠️ Produits en rupture | **8** |
| 📉 Taux de rupture | **≈ 10,3 %** |
| 👨‍💼 Employés | **9** |
| 🌍 Pays représentés | **27** |
| 🏙️ Villes représentées | **93** |

> Les indicateurs sont calculés à partir des données du projet et peuvent varier selon les filtres appliqués dans Power BI.

---

## 🛠️ Stack technique

| Technologie | Rôle dans le projet |
|:---|:---|
| **Microsoft SQL Server** | Stockage des données relationnelles |
| **SQL** | Requêtes, contrôles et préparation des données |
| **Power Query (M)** | Transformation et enrichissement des données |
| **Power BI Desktop** | Modélisation et développement du dashboard |
| **DAX** | Calcul des mesures et indicateurs de performance |
| **GitHub Desktop** | Gestion des versions et publication |
| **GitHub** | Documentation et partage du projet |

---

## 🏗️ Architecture BI

Le projet suit une chaîne de traitement complète :

```text
                 ┌───────────────────────┐
                 │      SQL SERVER       │
                 │      Base Ventes      │
                 └───────────┬───────────┘
                             │
                             ▼
                 ┌───────────────────────┐
                 │      POWER QUERY      │
                 │ Nettoyage & Enrich.   │
                 └───────────┬───────────┘
                             │
                             ▼
                 ┌───────────────────────┐
                 │    DATA MODELING      │
                 │ Tables & Relations    │
                 └───────────┬───────────┘
                             │
                             ▼
                 ┌───────────────────────┐
                 │          DAX          │
                 │  KPI & Calculs métier │
                 └───────────┬───────────┘
                             │
                             ▼
                 ┌───────────────────────┐
                 │       POWER BI        │
                 │ Dashboard interactif  │
                 └───────────────────────┘
```

### Étapes de réalisation

**1. Extraction des données**

Connexion de Power BI à la base SQL Server `Ventes`.

**2. Transformation**

Préparation et enrichissement des données dans Power Query.

**3. Modélisation**

Création des relations entre les tables transactionnelles et les dimensions.

**4. Calcul des indicateurs**

Développement des mesures DAX nécessaires aux analyses.

**5. Visualisation**

Création de sept pages analytiques interactives avec une identité visuelle cohérente.

---

## 🗂️ Modèle de données Power BI

Le modèle relationnel s'articule autour des tables **Commande** et **LigneCommandes**, associées aux différentes dimensions métier.

### 📸 Schéma relationnel

![Modèle de données Power BI](Documentation/modele_donnees.png)

*Vue du modèle relationnel réalisée dans Power BI Desktop.*

### 🔗 Relations principales

| Dimension / Table | Relation avec |
|:---|:---|
| `Client` | `Commande` |
| `Employe` | `Commande` |
| `Transporteur` | `Commande` |
| `Calendrier` | `Commande` |
| `Commande` | `LigneCommandes` |
| `Produit` | `LigneCommandes` |
| `Categorie` | `Produit` |
| `Fournisseur` | `Produit` |

La table `Calendrier` permet d'analyser les performances par année, trimestre, mois et jour de la semaine.

---

## 🔄 Data Preparation — Power Query

Power Query est utilisé pour créer des champs métiers et préparer les données à l'analyse.

### Transformations principales

| Table | Transformation | Objectif |
|:---|:---|:---|
| `LigneCommandes` | `Montant Ligne` | Calcul du montant net après remise |
| `Employe` | `Nom complet` | Identification lisible des employés |
| `Produit` | `Statut Stock` | Classification des produits selon leur disponibilité |
| `Client` | `AdresseComplete` | Préparation des données pour la cartographie |

### Exemple — Montant net d'une ligne

```powerquery
[PrixUnitaire] * [Quantite] * (1 - [Remise])
```

### Exemple — Nom complet d'un employé

```powerquery
[Prenom] & " " & [Nom]
```

📄 **Documentation détaillée :** [Transformations Power Query](PowerQuery/transformations.md)

---

## 📐 DAX — Business Metrics

Les indicateurs sont calculés à l'aide de mesures DAX regroupées dans une table dédiée `_Mesures`.

### Chiffre d'affaires net

```DAX
CA Total =
SUM ( LigneCommandes[Montant Ligne] )
```

### Chiffre d'affaires brut

```DAX
CA Brut =
SUMX (
    LigneCommandes,
    LigneCommandes[PrixUnitaire] *
    LigneCommandes[Quantite]
)
```

### Taux de remise

```DAX
Taux de Remise =
DIVIDE (
    [CA Brut] - [CA Total],
    [CA Brut],
    0
)
```

### Nombre de commandes

```DAX
Nombre Commandes =
DISTINCTCOUNT ( Commande[CommandeId] )
```

### Clients actifs

```DAX
Clients Actifs =
DISTINCTCOUNT ( Commande[ClientId] )
```

### Panier moyen

```DAX
Panier Moyen =
DIVIDE (
    [CA Total],
    [Nombre Commandes],
    0
)
```

### Taux de rupture

```DAX
Taux de Rupture =
DIVIDE (
    [Nombre Produits en Rupture],
    [Nombre Produits],
    0
)
```

### Analyse temporelle

Le projet intègre également des mesures de comparaison et de cumul temporel :

- Chiffre d'affaires de l'année précédente.
- Évolution du chiffre d'affaires.
- Évolution du chiffre d'affaires en pourcentage.
- Chiffre d'affaires cumulé depuis le début de l'année (YTD).
- Chiffre d'affaires cumulé depuis le début du mois (MTD).

📄 **Toutes les formules :** [Documentation des mesures DAX](DAX/mesures_dax.md)

---

# 🖥️ Dashboard — 7 pages d'analyse

## 01 | 📊 Vue Exécutive

**Objectif :** fournir une vision globale et synthétique de l'activité commerciale.

**Indicateurs et analyses :**

- CA brut et net.
- Nombre de commandes.
- Nombre de clients.
- Quantité vendue.
- Taux de remise.
- Panier moyen.
- Évolution mensuelle des ventes.
- Répartition du chiffre d'affaires par catégorie.
- Classement des meilleurs clients et produits.

![Vue Exécutive](Dashboard_POWER_BI_VENTES/01_vue_executive.png)

---

## 02 | 💰 Analyse des Ventes

**Objectif :** identifier les tendances commerciales et les périodes de forte activité.

**Analyses :**

- Évolution annuelle du chiffre d'affaires.
- Analyse trimestrielle et mensuelle.
- Répartition des ventes par période.
- Heatmap des ventes par mois et jour de la semaine.
- Filtres interactifs par période, catégorie et produit.

![Analyse des Ventes](Dashboard_POWER_BI_VENTES/02_analyse_ventes.png)

---

## 03 | 👥 Analyse Clients

**Objectif :** comprendre la structure du portefeuille clients et identifier les clients stratégiques.

**Analyses :**

- Nombre total de clients.
- Clients actifs.
- Chiffre d'affaires par client.
- Top 5 clients.
- Nombre de commandes par client.
- Panier moyen.
- Segmentation selon la fréquence des commandes.

**Typologie utilisée :**

- CLIENT OCCASIONNEL
- CLIENT FREQUENT
- CLIENT FIDEL
- SUPER CLIENT

![Analyse Clients](Dashboard_POWER_BI_VENTES/03_analyse_clients.png)

---

## 04 | 📦 Analyse Produits

**Objectif :** évaluer les performances du catalogue et surveiller la disponibilité des produits.

**Analyses :**

- Nombre total de produits.
- Produits en rupture.
- Taux de rupture.
- Quantité vendue.
- Prix moyen.
- Top produits.
- Performance des catégories.
- Analyse des fournisseurs.
- Catalogue détaillé et statut des stocks.

**États de stock :** Disponible • Stock faible • En rupture

![Analyse Produits](Dashboard_POWER_BI_VENTES/04_analyse_produits.png)

---

## 05 | 👨‍💼 Analyse Employés

**Objectif :** analyser la contribution commerciale des employés.

**Analyses :**

- Nombre d'employés.
- CA net.
- Nombre de commandes.
- Quantité vendue.
- CA moyen par employé.
- Commandes moyennes par employé.
- Classement des employés.
- Évolution des performances.

![Analyse Employés](Dashboard_POWER_BI_VENTES/05_analyse_employes.png)

---

## 06 | 🚚 Expéditions & Transporteurs

**Objectif :** analyser le processus d'expédition et l'activité des transporteurs.

**Analyses :**

- Nombre de commandes expédiées.
- Commandes non expédiées.
- Délais moyens d'expédition.
- Commandes expédiées à temps.
- Répartition des commandes par transporteur.
- Chiffre d'affaires associé aux transporteurs.

**Note :** les délais étudiés reposent sur les dates de commande, d'expédition et les dates demandées. Ils ne représentent pas nécessairement les délais réels de livraison au client.

![Expéditions et Transporteurs](Dashboard_POWER_BI_VENTES/06_expeditions.png)

---

## 07 | 🌍 Cartographie

**Objectif :** analyser la répartition géographique des clients et du chiffre d'affaires.

**Analyses :**

- Carte géographique des clients.
- Nombre de clients par pays.
- Chiffre d'affaires par pays.
- Top villes.
- Nombre de pays et de villes.
- Filtres géographiques.
- Tableau détaillé des adresses clients.

![Cartographie](Dashboard_POWER_BI_VENTES/07_cartographie.png)

---

## 🎨 UI/UX — Design du dashboard

Le rapport adopte une identité visuelle inspirée de **SAZOTECH SOLUTIONS**.

### Principes de design

- Palette principale bleue et cyan.
- Arrière-plan clair.
- Présentation homogène des KPI.
- Graphiques interactifs.
- Navigation entre les pages.
- Filtres contextuels.
- Organisation par domaine métier.

### Navigation

Le dashboard propose un parcours structuré :

**Accueil → Vue Exécutive → Ventes → Clients → Produits → Employés → Expéditions → Cartographie**

La réinitialisation des filtres peut être gérée avec les signets Power BI (*Bookmarks*).

---

## 🔎 Analyses et constats

Les indicateurs du jeu de données mettent notamment en évidence les éléments suivants :

### 1. Activité commerciale

Le chiffre d'affaires net atteint environ **6,46 M€**, pour **5 456 commandes**.

### 2. Portefeuille clients

Sur **124 clients**, **88 ont passé au moins une commande** dans les données analysées.

### 3. Gestion des produits

Le catalogue comprend **78 produits**, dont **8 signalés en rupture**, soit environ **10,3 %**.

### 4. Couverture géographique

Le portefeuille clients couvre **27 pays** et **93 villes**.

Ces résultats constituent des observations descriptives. L'identification des causes, des tendances et des actions commerciales nécessite une analyse complémentaire des graphiques et des filtres.

---

## 📁 Structure du repository

```text
BI_VENTES_SA/
│
├── README.md
├── .gitignore
│
├── PowerBI/
│   └── BI_VENTES_SA.pbix
│
├── SQL/
│   ├── 01_insertion_donnees_maroc.sql
│   ├── 02_verification_donnees_maroc.sql
│   ├── 03_insertion_donnees_madagascar.sql
│   ├── 04_verification_donnees_madagascar.sql
│   ├── 05_analyse_ventes_madagascar.sql
│   └── 06_mise_a_jour_adresses_maroc_madagascar.sql
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

## 🚀 Installation et utilisation

### Prérequis

- Microsoft Power BI Desktop.
- SQL Server, pour l'actualisation depuis la base source.
- Accès à la base de données `Ventes` ou à une base compatible.

### Étapes

**1. Cloner le repository**

```bash
git clone https://github.com/UTILISATEUR/BI_VENTES_SA.git
```

Remplacer `UTILISATEUR` par le nom du compte GitHub.

**2. Ouvrir le rapport**

Ouvrir le fichier :

`PowerBI/BI_VENTES_SA.pbix`

**3. Configurer la source de données**

Dans Power BI Desktop :

**Fichier → Options et paramètres → Paramètres des sources de données**

Configurer la connexion SQL Server et les autorisations nécessaires.

**4. Actualiser les données**

Cliquer sur **Accueil → Actualiser**, après avoir vérifié que la base source est accessible et que son schéma est compatible.

> Le rapport peut être consultable avec ses données déjà importées, si elles sont incluses dans le fichier PBIX. L'actualisation nécessite une connexion valide à la source SQL Server.

---

## 🧠 Compétences développées

### Data Engineering & Preparation

- Manipulation de données SQL.
- Préparation des données avec Power Query.
- Création de colonnes personnalisées.
- Vérification des types et de la qualité des données.

### Data Modeling

- Modélisation relationnelle.
- Relations un-à-plusieurs.
- Tables transactionnelles et dimensions.
- Table calendrier.
- Gestion des filtres.

### DAX & Business Analytics

- `SUM`, `SUMX`, `CALCULATE`.
- `DISTINCTCOUNT`, `DIVIDE`, `AVERAGEX`.
- `FILTER`, `SWITCH`.
- Fonctions d'intelligence temporelle.
- Calcul et interprétation des KPI.

### Data Visualization

- Construction de dashboards interactifs.
- Cartes KPI.
- Histogrammes et courbes.
- Heatmaps.
- Cartographie.
- Segments et navigation.
- Présentation d'indicateurs métier.

### Version Control

- Organisation d'un repository.
- Documentation Markdown.
- Commits Git.
- Publication avec GitHub Desktop.

---

## 🔐 Confidentialité et sécurité

Les informations sensibles de connexion ne doivent pas être publiées dans le repository.

Avant toute publication publique, il convient de vérifier :

- l'absence de mots de passe et de tokens ;
- l'absence de données personnelles ou confidentielles non autorisées ;
- les données éventuellement intégrées au fichier PBIX ;
- les scripts SQL et leurs éventuelles données d'exemple.

---

## 🔮 Perspectives d'amélioration

Plusieurs évolutions peuvent être envisagées :

- Publication du dashboard dans Power BI Service.
- Actualisation planifiée des données.
- Gestion des droits d'accès.
- Optimisation des performances DAX.
- Versionnement au format Power BI Project (`.pbip`).
- Ajout d'indicateurs commerciaux avancés.
- Automatisation du déploiement.

---

## 👤 Auteur

**Projet :** BI_VENTES_SA  
**Domaine :** Business Intelligence & Data Analytics  
**Technologies :** SQL Server • Power Query • DAX • Power BI

---

### ⭐ Conclusion

**BI_VENTES_SA** illustre la réalisation d'un projet décisionnel de bout en bout, de la préparation des données SQL Server à la conception d'un dashboard Power BI interactif.

Il met en pratique les compétences essentielles de la Business Intelligence : **préparation des données, modélisation, calcul d'indicateurs, visualisation et analyse métier**.

**Si ce projet vous intéresse, n'hésitez pas à explorer le repository !**
