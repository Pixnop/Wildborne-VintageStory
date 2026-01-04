# Wildborne

**Modpack ultime pour Vintage Story** - 121 mods soigneusement sélectionnés pour une expérience de survie immersive.

[![Wiki](https://img.shields.io/badge/Wiki-Documentation-blue)](https://pixnop.github.io/Wildborne-VintageStory/)
[![Release](https://img.shields.io/github/v/release/Pixnop/Wildborne-VintageStory)](https://github.com/Pixnop/Wildborne-VintageStory/releases/latest)
[![VS Version](https://img.shields.io/badge/Vintage%20Story-1.21.6+-green)](https://vintagestory.at/)

## Installation

### Client (Solo ou Multijoueur)

1. **Téléchargez** la [dernière release](https://github.com/Pixnop/Wildborne-VintageStory/releases/latest)
2. **Extrayez** le contenu dans votre dossier `Mods` :
   - Windows : `%appdata%\VintagestoryData\Mods`
   - Linux : `~/.config/VintagestoryData/Mods`
   - macOS : `~/Library/Application Support/VintagestoryData/Mods`
3. **Lancez** Vintage Story et créez un nouveau monde

### Serveur (Docker)

```bash
cd server/docker
./setup.sh        # Linux/macOS
# ou setup.bat    # Windows
docker compose up -d
```

Voir la [documentation serveur](server/docker/README.md) pour plus de détails.

## Contenu du Modpack

| Catégorie | Mods | Description |
|-----------|------|-------------|
| **Faune** | 26 | Mammifères, oiseaux, reptiles, créatures marines |
| **Flore** | 14 | 7 régions florales, arbres fruitiers, champignons |
| **Gameplay** | 40 | Combat, cuisine, compétences, artisanat |
| **QoL** | 40+ | Stockage, décorations, qualité de vie |

### Points Forts

- **Régions Biogéographiques** - 7 zones florales inspirées de vraies régions
- **Faune Réaliste** - Familles taxonomiques complètes (félins, canidés, cervidés...)
- **Combat Refait** - Arbalètes, armes à feu, combat coopératif
- **Cuisine Élaborée** - Nouveaux aliments, fours, casseroles, hydratation
- **Océans & Rivières** - Génération de monde améliorée avec le mod Rivers

## Configuration Recommandée

Pour profiter pleinement du mod Rivers, utilisez ces paramètres lors de la création du monde :

```
/worldconfig landcover 0.5
/worldconfig oceanscale 4
```

Ces paramètres sont appliqués automatiquement sur le serveur Docker.

## Structure du Projet

```
Wildborne-VintageStory/
├── modlist.txt          # Liste des 121 mods
├── mod/                 # Mod Wildborne Handbook (guide in-game)
├── docs/                # Source du wiki (MkDocs)
├── scripts/             # Scripts de build et téléchargement
└── server/docker/       # Configuration serveur Docker
```

## Documentation

- **[Wiki Wildborne](https://pixnop.github.io/Wildborne-VintageStory/)** - Guide complet de tous les mods
- **[Installation Serveur](server/docker/README.md)** - Docker setup

## Contribuer

Les contributions sont les bienvenues :

- Signaler des bugs ou incompatibilités
- Proposer de nouveaux mods
- Améliorer la documentation

## Liens

- [Vintage Story](https://vintagestory.at/) - Site officiel
- [Mod Database](https://mods.vintagestory.at/) - Base de données des mods
- [Wiki VS](https://wiki.vintagestory.at/) - Wiki officiel

## Licence

Ce projet est sous licence MIT. Les mods individuels conservent leurs licences respectives.

---

*Wildborne - Une expérience Vintage Story enrichie*
