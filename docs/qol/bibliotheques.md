---
title: Bibliothèques & Dépendances
description: Bibliothèques techniques du modpack Wildborne
---

# :books: Bibliothèques & Dépendances

**10 mods** techniques nécessaires au fonctionnement des autres mods.

---

!!! warning "Important"
    Ces mods sont des **dépendances techniques**. Ne les supprimez jamais ou d'autres mods cesseront de fonctionner !

---

## Liste des Bibliothèques

| Mod | Version | Utilisé par |
|-----|---------|-------------|
| attributerenderinglibrary | 2.4.0 | Affichage d'attributs |
| commonlib | 2.8.0 | Base commune pour plusieurs mods |
| configlib | 1.10.12 | Gestion de configuration |
| overhaullib | 1.16.0 | Mods de type "overhaul" |
| vsimgui | 1.1.16 | Interfaces graphiques |
| xlib | 0.9.0-pre.2 | Système XSkills |
| em | 3.4.0 | Expanded Matter |
| bettertranslations | 0.0.35 | Traductions communautaires |
| vsinstrumentsbase | 2.0.6 | Base instruments de musique |
| vsinstruments_quackpack | 1.0.2 | Pack d'instruments |

---

## Détails

### Common Lib
Bibliothèque fondamentale pour PlayerCorpse, Stone Quarry, et d'autres mods.

??? info "Requis par"
    - :material-alert: [Player Corpse](qualite-de-vie.md#player-corpse) : Système de corps récupérable
    - :material-alert: [Stone Quarry](../gameplay/artisanat.md#stone-quarry) : Système de carrière

**Commandes utilitaires :**

| Commande | Fonction |
|----------|----------|
| `/cl config` | Modifier les paramètres en jeu |
| `/cl rtp <range>` | Téléportation aléatoire |
| `/cl rst <player>` | Restaurer la stabilité temporelle |

### Config Lib

![Config Lib](https://moddbcdn.vintagestory.at/moddb_25fa98f09cd30c_5ce9015cc02c343e081f6a80309ce7ac.png){ align=right width=80 }

Interface de configuration in-game pour les mods de contenu.

- **Éditeur GUI** centralisé pour tous les paramètres
- Support des **JSON patches** pour configuration serveur
- **Rechargement automatique** des fichiers modifiés
- Dépendance optionnelle (valeurs par défaut si absent)

Utilisé par : Status HUD, BetterRuins, Firearms, Millwright, et plus.

### Overhaul Lib

![Overhaul Lib](https://moddbcdn.vintagestory.at/moddb-thumb_2dd73811473d7e686e3a67fe850d4427.png){ align=right width=80 }

Support pour les mods de refonte :

- Combat Overhaul
- Autres refontes majeures

??? info "Requis par"
    - :material-alert: [Combat Overhaul](../gameplay/combat.md#combat-overhaul) : Refonte du système de combat

### XLib
Bibliothèque pour le système de compétences :

- XSkills
- XSkills Gilded
- Progression et perks

??? info "Requis par"
    - :material-alert: [XSkills](../gameplay/competences.md#xskills) : Système de compétences principal
    - :material-alert: [XSkills Gilded](../gameplay/competences.md#xskills-gilded) : Compétences dorées avancées

### Expanded Matter (EM)

![Expanded Matter](https://moddbcdn.vintagestory.at/modlogo_metal_ac45ddc317aa440d44cf92a17505b5a7.png){ align=right width=80 }

Bibliothèque ajoutant des formes broyées et en poudre des minerais et pierres.

- **Recettes de conversion** entre variantes de matériaux
- **Fabrication de teintures** à partir de poudres sèches
- **Saumure de salpêtre** pour conservation alimentaire (optionnel)
- **Minerais rares** accessibles via orpaillage

Requis par : Tailor's Delight, et d'autres mods de contenu.

### VS ImGui

![VS ImGui](https://moddbcdn.vintagestory.at/moddb_d63d1a26c89ea1_b7915a3745472150677092b22b6f0911.png){ align=right width=80 }

Interface graphique avancée :

- Menus personnalisés
- Fenêtres de configuration
- HUD modifié

### Better Translations

Traductions communautaires pour de nombreux mods.

- Récupère les traductions du **projet Crowdin**
- Améliore la localisation des mods en **français** et autres langues
- Mise à jour automatique des chaînes traduites

### VS Instruments

Base et pack d'instruments de musique pour le jeu.

- **vsinstrumentsbase** : Framework pour les instruments
- **vsinstruments_quackpack** : Collection d'instruments jouables
- Ajoutez de la musique à vos soirées au coin du feu !

---

## Maintenance

!!! tip "Mises à jour"
    Lors des mises à jour du modpack, mettez toujours à jour les bibliothèques **en premier** avant les autres mods.

!!! info "Compatibilité"
    Ces bibliothèques assurent la compatibilité entre mods. Elles sont maintenues par la communauté de modding Vintage Story.
