# WildBorne Server - Docker

Serveur Vintage Story avec le modpack WildBorne (121 mods) containerisé avec Docker.

## Prérequis

- [Docker](https://docs.docker.com/get-docker/) installé
- [Docker Compose](https://docs.docker.com/compose/install/) installé
- ~1 Go d'espace disque

## Installation rapide

### Linux / macOS

```bash
cd server/docker
chmod +x setup.sh
./setup.sh
docker compose up -d
```

### Windows

```batch
cd server\docker
setup.bat
docker compose up -d
```

## Structure des fichiers

```
docker/
├── docker-compose.yml    # Configuration Docker
├── setup.sh              # Script d'installation (Linux/macOS)
├── setup.bat             # Script d'installation (Windows)
├── README.md             # Ce fichier
├── server/               # Fichiers serveur VS (créé par setup.sh)
│   ├── VintagestoryServer.dll
│   └── ...
└── data/                 # Données persistantes (créé par setup.sh)
    ├── Mods/             # 121 mods WildBorne
    ├── Saves/            # Sauvegardes du monde
    ├── Logs/             # Logs serveur
    └── serverconfig.json # Configuration serveur
```

## Commandes

| Action | Commande |
|--------|----------|
| Démarrer | `docker compose up -d` |
| Arrêter | `docker compose down` |
| Voir les logs | `docker compose logs -f` |
| Console interactive | `docker attach wildborne-server` |
| Quitter la console | `Ctrl+P` puis `Ctrl+Q` |
| Redémarrer | `docker compose restart` |

## Configuration

### Modifier serverconfig.json

Après le premier démarrage, éditez `data/serverconfig.json` :

```json
{
  "ServerName": "WildBorne Server",
  "Port": 42420,
  "MaxClients": 16,
  "Password": "",
  "AllowPvP": true
}
```

### Limites de ressources

Dans `docker-compose.yml`, ajustez la mémoire selon votre serveur :

```yaml
deploy:
  resources:
    limits:
      memory: 8G    # Maximum
    reservations:
      memory: 4G    # Minimum recommandé
```

## Configuration du monde (Automatique)

Le script de setup crée un `serverconfig.json` pré-configuré pour le mod **Rivers** :

| Paramètre | Valeur | Description |
|-----------|--------|-------------|
| `landcover` | 0.5 | 50% terre / 50% océan |
| `oceanscale` | 4 | Échelle des océans (400%) |

Ces paramètres sont appliqués automatiquement lors de la création du monde.

## Ajouter/Supprimer des mods

1. Placez les fichiers `.zip` dans `data/Mods/`
2. Redémarrez : `docker compose restart`

## Mise à jour du modpack

```bash
# 1. Arrêter le serveur
docker compose down

# 2. Sauvegarder les données (optionnel mais recommandé)
cp -r data/Saves data/Saves.backup

# 3. Télécharger la nouvelle version
rm data/Mods/*.zip
wget https://github.com/Pixnop/Wildborne-VintageStory/releases/latest/download/Wildborne-latest.zip
unzip Wildborne-latest.zip -d data/Mods/

# 4. Redémarrer
docker compose up -d
```

## Mise à jour de Vintage Story

1. Modifiez `VS_VERSION` dans `setup.sh`
2. Supprimez le dossier `server/`
3. Relancez `./setup.sh`

## Ports et Redirection

### Pare-feu local

Ouvrez le port **42420** (TCP et UDP) dans votre pare-feu.

```bash
# UFW (Ubuntu/Debian)
sudo ufw allow 42420/tcp
sudo ufw allow 42420/udp

# firewalld (CentOS/Fedora)
sudo firewall-cmd --permanent --add-port=42420/tcp
sudo firewall-cmd --permanent --add-port=42420/udp
sudo firewall-cmd --reload
```

```powershell
# Windows (PowerShell en admin)
New-NetFirewallRule -DisplayName "Vintage Story Server" -Direction Inbound -Protocol TCP -LocalPort 42420 -Action Allow
New-NetFirewallRule -DisplayName "Vintage Story Server" -Direction Inbound -Protocol UDP -LocalPort 42420 -Action Allow
```

### Redirection de ports (Router/Box)

Pour héberger depuis chez vous, configurez la redirection de ports sur votre routeur/box :

1. **Accédez à l'interface de votre box** :
   - Freebox : http://mafreebox.freebox.fr
   - Livebox : http://192.168.1.1
   - SFR Box : http://192.168.1.1
   - Bbox : http://192.168.1.254

2. **Trouvez la section** : "Redirection de ports" / "NAT" / "Port Forwarding"

3. **Ajoutez deux règles** :

   | Protocole | Port externe | Port interne | IP destination |
   |-----------|--------------|--------------|----------------|
   | TCP | 42420 | 42420 | IP de votre serveur |
   | UDP | 42420 | 42420 | IP de votre serveur |

4. **Trouvez l'IP locale de votre serveur** :
   ```bash
   # Linux
   ip addr show | grep "inet "

   # Windows
   ipconfig
   ```

5. **Partagez votre IP publique** aux joueurs :
   - Allez sur https://www.whatismyip.com/
   - Ou utilisez : `curl ifconfig.me`

### Hébergement Cloud (VPS)

Si vous utilisez un VPS (OVH, Scaleway, DigitalOcean, etc.), ouvrez le port dans le panel de sécurité :

- **OVH** : Firewall Network → Ajouter règle → Port 42420 TCP/UDP
- **Scaleway** : Security Groups → Ajouter règle entrante
- **DigitalOcean** : Networking → Firewalls → Ajouter règle

## Dépannage

### Le serveur ne démarre pas

```bash
# Vérifier les logs
docker compose logs

# Vérifier que les mods sont présents
ls -la data/Mods/
```

### Mémoire insuffisante

Augmentez la limite dans `docker-compose.yml` ou réduisez `MaxClients` dans `serverconfig.json`.

### Connexion refusée

- Vérifiez que le port 42420 est ouvert
- Vérifiez que le serveur est bien démarré : `docker compose ps`

## Liens

- [Wiki WildBorne](https://pixnop.github.io/Wildborne-VintageStory/)
- [Télécharger le modpack](https://github.com/Pixnop/Wildborne-VintageStory/releases)
- [Wiki Vintage Story - Serveur](https://wiki.vintagestory.at/Guide:Dedicated_Server)
