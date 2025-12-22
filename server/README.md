# WildBorne Server Scripts

Scripts pour configurer et lancer un serveur Vintage Story avec le modpack WildBorne.

## Prérequis

- **Vintage Story 1.21.6** installé
- **Python 3** (pour télécharger les mods automatiquement)
- **Linux uniquement**: `mono-complete` si utilisation du .exe

## Installation

### Windows

1. Exécutez `setup_server.bat`
2. Le script va :
   - Trouver votre installation Vintage Story
   - Copier les fichiers serveur
   - Télécharger les 97 mods du modpack

### Linux

```bash
chmod +x *.sh
./setup_server.sh
```

## Utilisation

### Démarrer le serveur

| Windows | Linux |
|---------|-------|
| `start_server.bat` | `./start_server.sh` |

### Arrêter le serveur

| Windows | Linux |
|---------|-------|
| Tapez `/stop` dans la console | Tapez `/stop` dans la console |
| Ou `stop_server.bat` | Ou `./stop_server.sh` |

## Configuration Rivers (IMPORTANT)

Le mod **Rivers** nécessite des océans pour générer des rivières.

**AVANT de créer le monde**, exécutez ces commandes :

```
/worldconfig landcover 0.5
/worldconfig landcoverScale 4
```

## Structure des dossiers

```
server/
├── setup_server.bat/.sh    # Configuration initiale
├── start_server.bat/.sh    # Démarrer le serveur
├── stop_server.bat/.sh     # Arrêter le serveur
├── VintagestoryServer.exe  # (créé par setup)
├── Lib/                    # (créé par setup)
├── assets/                 # (créé par setup)
└── data/
    ├── Mods/               # Mods du modpack
    ├── ModConfig/          # Configuration des mods
    ├── Saves/              # Sauvegardes du monde
    ├── Logs/               # Logs du serveur
    └── serverconfig.json   # Configuration serveur
```

## Configuration serveur

Le fichier `data/serverconfig.json` contient les paramètres du serveur :

```json
{
  "ServerName": "WildBorne Server",
  "Port": 42420,
  "MaxClients": 16,
  "Password": null,
  "AllowPvP": true
}
```

## Commandes utiles

| Commande | Description |
|----------|-------------|
| `/whitelist add <joueur>` | Ajouter à la whitelist |
| `/whitelist remove <joueur>` | Retirer de la whitelist |
| `/player <joueur> role admin` | Donner les droits admin |
| `/ban <joueur> <raison>` | Bannir un joueur |
| `/kick <joueur>` | Expulser un joueur |
| `/stop` | Arrêter le serveur |

## Ports

Ouvrez le port **42420** (TCP et UDP) dans votre pare-feu.

### Windows (PowerShell Admin)
```powershell
netsh advfirewall firewall add rule name="VS Server" dir=in action=allow protocol=TCP localport=42420
netsh advfirewall firewall add rule name="VS Server UDP" dir=in action=allow protocol=UDP localport=42420
```

### Linux (ufw)
```bash
sudo ufw allow 42420/tcp
sudo ufw allow 42420/udp
```

## Liens

- [Wiki WildBorne](https://pixnop.github.io/Wildborne-VintageStory/)
- [Télécharger les mods](https://github.com/Pixnop/Wildborne-VintageStory/releases)
- [Wiki Vintage Story - Serveur](https://wiki.vintagestory.at/Guide:Dedicated_Server)
