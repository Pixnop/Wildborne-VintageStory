---
title: Téléchargement
description: Téléchargez le modpack Wildborne pour Vintage Story
hide:
  - navigation
  - toc
---

<style>
.download-hero {
    text-align: center;
    padding: 3rem 0;
    margin-bottom: 2rem;
}

.download-hero h1 {
    font-size: 3rem;
    margin-bottom: 0.5rem;
    background: linear-gradient(135deg, #e8e8e8 0%, #90EE90 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.download-hero .subtitle {
    font-size: 1.25rem;
    color: #a0a0b0;
    margin-bottom: 2rem;
}

.download-btn {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    background: #8B4513;
    color: white !important;
    padding: 1rem 2rem;
    border-radius: 8px;
    font-size: 1.1rem;
    font-weight: 600;
    text-decoration: none !important;
    transition: all 0.2s;
}

.download-btn:hover {
    background: #6B3410;
    transform: translateY(-2px);
    box-shadow: 0 10px 30px rgba(139, 69, 19, 0.3);
}

.version-badge {
    display: inline-block;
    background: #8B4513;
    color: white;
    padding: 0.25rem 0.75rem;
    border-radius: 50px;
    font-size: 0.875rem;
    margin-bottom: 1rem;
}

.stats-row {
    display: flex;
    justify-content: center;
    gap: 3rem;
    margin: 2rem 0;
    flex-wrap: wrap;
}

.stat-item {
    text-align: center;
}

.stat-number {
    display: block;
    font-size: 2rem;
    font-weight: 700;
    color: #90EE90;
}

.stat-label {
    color: #a0a0b0;
    font-size: 0.9rem;
}

.install-section {
    margin-top: 3rem;
}

.install-tabs {
    display: flex;
    gap: 0.5rem;
    margin-bottom: 1rem;
    border-bottom: 2px solid #3a3a5a;
}

.tab-link {
    padding: 0.75rem 1.5rem;
    background: none;
    border: none;
    color: #a0a0b0;
    cursor: pointer;
    font-size: 1rem;
    border-bottom: 2px solid transparent;
    margin-bottom: -2px;
    transition: all 0.2s;
}

.tab-link:hover {
    color: white;
}

.tab-link.active {
    color: white;
    border-bottom-color: #8B4513;
}
</style>

<div class="download-hero" markdown>

<span class="version-badge">Version 1.21.6</span>

# Wildborne

<p class="subtitle">Le modpack ultime pour Vintage Story</p>

<div class="stats-row">
<div class="stat-item">
<span class="stat-number">97</span>
<span class="stat-label">Mods</span>
</div>
<div class="stat-item">
<span class="stat-number">26</span>
<span class="stat-label">Espèces animales</span>
</div>
<div class="stat-item">
<span class="stat-number">7</span>
<span class="stat-label">Régions florales</span>
</div>
</div>

<a href="https://github.com/Pixnop/Wildborne-VintageStory/releases/latest" class="download-btn">
:material-download: Télécharger le Modpack
</a>

</div>

---

## Installation

### Prérequis

!!! info "Configuration requise"
    - **Vintage Story** version 1.21.6 ou supérieure
    - ~500 Mo d'espace disque pour les mods

### Installation Client (Solo / Rejoindre un serveur)

=== ":material-monitor: Windows"

    1. **Téléchargez** le modpack depuis le bouton ci-dessus
    2. **Localisez** le dossier Mods :
        - Ouvrez Vintage Story → `Paramètres` → `Ouvrir le dossier Mods`
        - Ou directement : `%appdata%\VintagestoryData\Mods`
    3. **Extrayez** le contenu de l'archive dans le dossier `Mods`
    4. **Lancez** Vintage Story et créez un nouveau monde

=== ":material-linux: Linux"

    1. **Téléchargez** le modpack depuis le bouton ci-dessus
    2. **Localisez** le dossier Mods :
        ```bash
        ~/.config/VintagestoryData/Mods
        ```
    3. **Extrayez** le contenu :
        ```bash
        unzip Wildborne-*.zip -d ~/.config/VintagestoryData/Mods/
        ```
    4. **Lancez** Vintage Story et créez un nouveau monde

=== ":material-apple: macOS"

    1. **Téléchargez** le modpack depuis le bouton ci-dessus
    2. **Localisez** le dossier Mods :
        ```
        ~/Library/Application Support/VintagestoryData/Mods
        ```
    3. **Extrayez** le contenu de l'archive dans le dossier `Mods`
    4. **Lancez** Vintage Story et créez un nouveau monde

!!! warning "Important"
    Supprimez vos anciens mods avant d'installer Wildborne pour éviter les conflits !

### Installation Serveur

=== ":material-server: Serveur Dédié"

    **Prérequis serveur :**

    - Vintage Story Server version 1.21.6
    - Minimum 4 Go de RAM dédiés
    - ~500 Mo d'espace disque

    **Étapes :**

    1. **Téléchargez** le modpack
    2. **Placez** les mods dans le dossier serveur :
        ```
        [dossier-serveur]/data/Mods
        ```
    3. **Configurez** `serverconfig.json` (optionnel) :
        ```json
        {
          "MaxClients": 20,
          "TickRate": 60,
          "PassTimeWhenEmpty": false
        }
        ```
    4. **Démarrez** le serveur

    !!! tip "Pour vos joueurs"
        Partagez le lien de téléchargement avec vos joueurs - ils doivent avoir les mêmes mods installés !

---

## Besoin d'aide ?

Consultez le wiki pour des guides détaillés sur chaque mod du pack.

<div class="grid cards" markdown>

-   :lion: **Faune**

    ---

    Découvrez les 26 espèces animales ajoutées

    [:octicons-arrow-right-24: Explorer](faune/index.md)

-   :herb: **Flore**

    ---

    7 régions florales uniques à découvrir

    [:octicons-arrow-right-24: Explorer](flore/index.md)

-   :crossed_swords: **Gameplay**

    ---

    Combat, cuisine, compétences et plus

    [:octicons-arrow-right-24: Explorer](gameplay/index.md)

</div>
