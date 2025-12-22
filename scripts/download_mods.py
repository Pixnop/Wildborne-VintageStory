#!/usr/bin/env python3
"""
Wildborne Modpack - Mod Downloader
Downloads mods from the Vintage Story mod database API.
"""

import json
import os
import sys
import time
import urllib.request
import urllib.error
from pathlib import Path
from typing import Optional

API_BASE = "https://mods.vintagestory.at/api"
DOWNLOAD_BASE = "https://mods.vintagestory.at"

# Target game version
TARGET_VERSION = "1.21.6"


def log(message: str, level: str = "INFO"):
    """Print a log message."""
    prefix = {"INFO": "→", "OK": "✓", "WARN": "⚠", "ERROR": "✗"}
    print(f"{prefix.get(level, '→')} {message}")


def fetch_json(url: str) -> Optional[dict]:
    """Fetch JSON from URL."""
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Wildborne-Modpack/1.0"})
        with urllib.request.urlopen(req, timeout=30) as response:
            return json.loads(response.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        log(f"HTTP Error {e.code}: {url}", "ERROR")
        return None
    except urllib.error.URLError as e:
        log(f"URL Error: {e.reason}", "ERROR")
        return None
    except json.JSONDecodeError:
        log(f"Invalid JSON from {url}", "ERROR")
        return None


def download_file(url: str, dest: Path) -> bool:
    """Download a file from URL to destination."""
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Wildborne-Modpack/1.0"})
        with urllib.request.urlopen(req, timeout=120) as response:
            with open(dest, "wb") as f:
                f.write(response.read())
        return True
    except Exception as e:
        log(f"Download failed: {e}", "ERROR")
        return False


def version_matches(release_tags: list, target: str) -> bool:
    """Check if release supports target game version."""
    if not release_tags:
        return False

    for tag in release_tags:
        # Exact match
        if tag == target:
            return True
        # Range match (e.g., "1.21.0-1.21.6")
        if "-" in tag:
            parts = tag.split("-")
            if len(parts) == 2:
                try:
                    start = tuple(map(int, parts[0].split(".")))
                    end = tuple(map(int, parts[1].split(".")))
                    current = tuple(map(int, target.split(".")))
                    if start <= current <= end:
                        return True
                except (ValueError, IndexError):
                    pass
    return False


def find_compatible_release(releases: list, target_version: str) -> Optional[dict]:
    """Find the most recent release compatible with target version."""
    for release in releases:
        tags = release.get("tags", [])
        if version_matches(tags, target_version):
            return release
    return None


def get_mod_info(modid: str) -> Optional[dict]:
    """Fetch mod information from API."""
    url = f"{API_BASE}/mod/{modid}"
    data = fetch_json(url)
    if data and "mod" in data:
        return data["mod"]
    return None


def download_mod(modid: str, output_dir: Path, target_version: str) -> bool:
    """Download a specific mod."""
    log(f"Fetching info for '{modid}'...")

    mod_info = get_mod_info(modid)
    if not mod_info:
        log(f"Mod '{modid}' not found in database", "ERROR")
        return False

    mod_name = mod_info.get("name", modid)
    releases = mod_info.get("releases", [])

    if not releases:
        log(f"No releases found for '{mod_name}'", "ERROR")
        return False

    # Find compatible release
    release = find_compatible_release(releases, target_version)

    if not release:
        # Fallback to latest release with warning
        release = releases[0]
        release_tags = release.get("tags", [])
        log(f"No release for {target_version}, using latest ({release.get('modversion')} for {release_tags})", "WARN")

    # Get download URL
    mainfile = release.get("mainfile")
    if not mainfile:
        log(f"No download URL for '{mod_name}'", "ERROR")
        return False

    download_url = mainfile if mainfile.startswith("http") else f"{DOWNLOAD_BASE}{mainfile}"
    filename = release.get("filename", f"{modid}.zip")
    dest_path = output_dir / filename

    # Check if already downloaded
    if dest_path.exists():
        log(f"'{filename}' already exists, skipping", "OK")
        return True

    # Download
    log(f"Downloading '{mod_name}' v{release.get('modversion', '?')}...")

    if download_file(download_url, dest_path):
        size_mb = dest_path.stat().st_size / (1024 * 1024)
        log(f"Downloaded '{filename}' ({size_mb:.1f} MB)", "OK")
        return True
    else:
        if dest_path.exists():
            dest_path.unlink()
        return False


def read_modlist(filepath: Path) -> list:
    """Read mod IDs from modlist file."""
    mods = []
    with open(filepath, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            # Skip empty lines and comments
            if line and not line.startswith("#"):
                mods.append(line)
    return mods


def main():
    # Parse arguments
    script_dir = Path(__file__).parent.parent
    modlist_file = script_dir / "modlist.txt"
    output_dir = script_dir / "mods"
    target_version = TARGET_VERSION

    # Check for command line args
    if len(sys.argv) > 1:
        target_version = sys.argv[1]

    print(f"\n{'='*50}")
    print(f"  Wildborne Modpack Downloader")
    print(f"  Target Version: Vintage Story {target_version}")
    print(f"{'='*50}\n")

    # Read modlist
    if not modlist_file.exists():
        log(f"Modlist not found: {modlist_file}", "ERROR")
        sys.exit(1)

    mods = read_modlist(modlist_file)
    log(f"Found {len(mods)} mods in modlist")

    # Create output directory
    output_dir.mkdir(parents=True, exist_ok=True)
    log(f"Output directory: {output_dir}")
    print()

    # Download each mod
    success = 0
    failed = []

    for i, modid in enumerate(mods, 1):
        print(f"[{i}/{len(mods)}] ", end="")

        if download_mod(modid, output_dir, target_version):
            success += 1
        else:
            failed.append(modid)

        # Rate limiting
        time.sleep(0.5)

    # Summary
    print(f"\n{'='*50}")
    print(f"  Download Complete")
    print(f"  Success: {success}/{len(mods)}")

    if failed:
        print(f"  Failed: {len(failed)}")
        for modid in failed:
            print(f"    - {modid}")

    print(f"{'='*50}\n")

    sys.exit(0 if not failed else 1)


if __name__ == "__main__":
    main()
