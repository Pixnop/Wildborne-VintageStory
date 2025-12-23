---
title: Qualité de Vie
description: Mods QoL du modpack Wildborne
---

# :sparkles: Qualité de Vie

**10 mods** pour améliorer votre confort de jeu.

---

## Liste des Mods

| Mod | Version | Description |
|-----|---------|-------------|
| extrainfo | 1.10.1 | Informations détaillées sur les objets |
| playerlist | 2.3.4 | Liste des joueurs connectés |
| playercorpse | 1.12.0 | Corps récupérable après la mort |
| prospecttogether | 2.1.2 | Prospection partagée en équipe |
| egocaribautomapmarkers | 4.0.3 | Marqueurs de carte automatiques |
| alchemy | 1.8.0-rc.5 | Système d'alchimie et potions |
| farseer | 1.3.3 | Distance de vue étendue (~4000 blocs) |
| walkingstick | 1.0.13 | Cannes de marche craftables |
| pelaguswinds | 1.2.2 | Vent dynamique et réaliste |
| realsmoke | 1.1.10 | Fumée physique réaliste |

---

## Extra Info

![Extra Info](https://moddbcdn.vintagestory.at/ExtraInfoSplash_bac89c5a92c5d112777e7c185c234af1.png){ align=right width=100 }

Un mod côté client qui révèle toutes les informations cachées du jeu. Entièrement configurable selon vos besoins.

### Informations dans le manuel
| Catégorie | Données affichées |
|-----------|-------------------|
| Créatures | Régime alimentaire, drops, statistiques |
| Marchands | Liste complète des marchandises |
| Blocs | Temps de minage, températures de travail |
| Auges | Options d'alimentation compatibles |

### Suivi de progression
- **Bloomeries et fours** : pourcentage d'avancement
- **Fosses à charbon** : état de carbonisation
- **Meules** : progression du broyage
- **Ruches** : niveau de remplissage
- **Terres agricoles** : croissance des cultures

### Raccourcis utiles
| Touche | Fonction |
|--------|----------|
| Ctrl+T | Surbrillance des blocs renforcés |
| Shift+M | Révéler le mycélium caché |

??? info "Mods liés"
    - :material-arrow-right: [Mycodiversity](../flore/index.md) : Détection du mycélium
    - :material-arrow-right: [Wildcraft](../flore/index.md) : Infos sur les plantes sauvages

---

## Player Corpse

![Player Corpse](https://moddbcdn.vintagestory.at/playercorpse_86bd2916a59eeddb4b02df4d78a66304.png){ align=right width=100 }

Remplace le système de tombe par un corps récupérable à l'endroit de votre mort.

### Récupération
- Maintenez **clic droit** sur votre corps pour récupérer vos objets
- Seul le **propriétaire** peut collecter son corps (par défaut)
- Après 240h de jeu, le corps devient **accessible à tous**
- Un **waypoint** est automatiquement créé à chaque mort

### Outils de récupération
| Outil | Fonction |
|-------|----------|
| Boussole de corps | Localise les corps proches |
| Commande `/returnthings` | Restaure les objets des 10 dernières morts |

### Configuration
- Durée de vie du corps personnalisable
- Vulnérabilité au feu optionnelle
- Drop d'armure configurable

??? info "Mods liés"
    - :material-arrow-right: [Auto Map Markers](#auto-map-markers) : Waypoint de mort automatique
    - :material-arrow-right: [Combat Overhaul](../gameplay/combat.md#combat-overhaul) : Récupération des armures perdues

---

## Prospect Together

![Prospect Together](https://moddbcdn.vintagestory.at/prospecttogether_95d6eaa2c67c90ef5b6e51c8c6b7f1f2.png){ align=right width=100 }

Stockez, analysez et partagez vos données de prospection avec votre équipe.

### Fonctionnalités
- **Enregistrement automatique** des résultats de prospection en mode densité
- **Couche de carte** dédiée affichant les chunks prospectés
- **Mode heatmap** avec gradient de couleur selon la densité de minerai
- **Filtrage par minerai** pour cibler vos recherches

### Partage en multijoueur
- Partagez vos découvertes avec **tout le serveur** ou des joueurs spécifiques
- **Transmission automatique** des nouvelles données (optionnel)
- Parfait pour les serveurs **PvP** avec partage ciblé par équipe

??? info "Mods liés"
    - :material-arrow-right: [MN Geology](../gameplay/monde.md#material-needs-geology) : Prospection des nouvelles pierres
    - :material-arrow-right: [Auto Map Markers](#auto-map-markers) : Marquage combiné des minerais
    - :material-arrow-right: [Stone Quarry](../gameplay/artisanat.md#stone-quarry) : Localisation des sources de pierre

---

## Auto Map Markers

![Auto Map Markers](https://moddbcdn.vintagestory.at/cover-image_5325552d8de398f4a1ca786e25cc5864.png){ align=right width=100 }

Crée automatiquement des marqueurs de carte lors de vos interactions avec le monde.

### Éléments marquables
| Catégorie | Exemples |
|-----------|----------|
| Flore | Résine, baies, champignons, arbres fruitiers |
| Minerais | Cuivre, or, argent, fer, bismuth (surface et profondeur) |
| Ressources | Ruches sauvages, argile, tourbe |
| PNJ | Les 9 types de marchands |

### Configuration (Ctrl+Shift+M)
- Choix des **types d'objets** à marquer
- **Icônes et couleurs** personnalisables
- Jusqu'à **3 raccourcis** de marquage manuel
- Option d'affichage des **coordonnées XYZ**

!!! info "Activation requise"
    Le mod est désactivé par défaut. Ouvrez le menu de configuration pour l'activer.

??? info "Mods liés"
    - :material-arrow-right: [Better Ruins](../gameplay/monde.md#better-ruins) : Marquage automatique des ruines
    - :material-arrow-right: [Better Traders](../gameplay/monde.md#better-traders) : Marquage automatique des marchands
    - :material-arrow-right: [Prospect Together](#prospect-together) : Combiné pour prospection complète

---

## Alchemy

![Alchemy](https://moddbcdn.vintagestory.at/The_Alchemy_mod_logo_2873c5c666ad117a13ef58a1d15433f2.png){ align=right width=100 }

Plus de **17 types de potions** pour améliorer vos capacités temporairement.

### Potions disponibles
| Potion | Effet |
|--------|-------|
| Fiole de l'archer | Précision et dégâts à distance |
| Fiole du combattant | Force et résistance au corps à corps |
| Huile de soin | Régénération progressive |
| Délice du chasseur | Bonus contre les animaux |
| Fiole du mineur | Vitesse d'extraction accrue |

### Fabrication
1. Collectez des **fleurs** spécifiques (utilisez les mods de flore)
2. Broyez-les au **mortier et pilon** pour obtenir des bases
3. Combinez avec des **fioles** de différents matériaux

!!! warning "Attention"
    Les effets disparaissent à la mort ou en quittant le jeu !

??? info "Mods liés"
    - :material-arrow-right: [Herbarium](../flore/index.md) : Collecte des fleurs pour potions
    - :material-arrow-right: [Wildcraft Fruit](../flore/index.md) : Ingrédients naturels

---

## Farseer

Étendez votre distance de vue jusqu'à **~4000 blocs** dans toutes les directions.

- Système **LOD** (Level of Detail) pour le terrain distant
- Affiche le terrain sous forme de **heightmap** atmosphérique
- Ne montre pas les vrais chunks (arbres, bâtiments), juste le relief
- Effet de **brouillard atmosphérique** pour l'immersion
- Idéal pour l'exploration et l'orientation

??? info "Mods liés"
    - :material-arrow-right: [Terra Prety](../gameplay/monde.md#terra-prety) : Vue sur les océans et continents
    - :material-arrow-right: [Rivers](../gameplay/monde.md#rivers) : Repérage des rivières et lacs

---

## Adventurer's Walking Stick

Craftez des cannes de marche pour vos aventures.

- Plusieurs styles de cannes **personnalisables**
- Ajoutez des **décorations** à votre bâton
- Compagnon de voyage **immersif**
- Purement esthétique mais très satisfaisant

??? info "Mods liés"
    - :material-arrow-right: [Wildcraft Tree](../flore/index.md) : Bois variés pour différents styles

---

## Pelagus Winds

Le vent devient **dynamique et imprévisible**.

- Direction du vent **variable** dans le temps
- Affecte les nuages, la pluie et les particules
- Rend la navigation **plus challengeante**
- Parfait pour le gameplay sans carte

??? info "Mods liés"
    - :material-arrow-right: [Joy of Sailing](decoration.md#joy-of-sailing) : Navigation à voile impactée
    - :material-arrow-right: [Millwright](../gameplay/artisanat.md#millwright) : Moulins à vent affectés

---

## Real Smoke

La fumée devient un **élément de gameplay**.

- Fumée avec **physique réaliste** (pas juste des particules)
- La fumée **monte, se répand, contourne les obstacles**
- Nécessite une **ventilation** pour les feux intérieurs
- Construisez des **cheminées** fonctionnelles
- Défi supplémentaire pour l'aménagement intérieur

!!! warning "Ventilation"
    Sans cheminée, la fumée envahira votre maison ! Planifiez vos constructions en conséquence.

??? info "Mods liés"
    - :material-arrow-right: [Chisel Tools](../gameplay/artisanat.md#chisel-tools) : Cheminées décoratives fonctionnelles
    - :material-arrow-right: [Stick Isolation](../gameplay/artisanat.md#stick-isolation) : Isolation du toit avec évacuation
    - :material-arrow-right: [Better Firepit](../gameplay/cuisine.md) : Foyers avec gestion de fumée

---

## Conseils

!!! tip "Mort"
    Avec Player Corpse, ne paniquez pas en cas de mort ! Votre corps vous attend avec tout votre équipement.

!!! tip "Prospection"
    En multijoueur, utilisez Prospect Together pour partager les découvertes de minerais avec votre équipe.
