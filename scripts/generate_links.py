#!/usr/bin/env python3
"""
Generate download links for all mods in modlist.txt
"""

import json
import urllib.request
from pathlib import Path

API_BASE = "https://mods.vintagestory.at/api"
TARGET_VERSION = "1.21.6"


def fetch_json(url):
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Wildborne/1.0"})
        with urllib.request.urlopen(req, timeout=30) as response:
            return json.loads(response.read().decode("utf-8"))
    except Exception as e:
        return None


def version_matches(tags, target):
    if not tags:
        return False
    for tag in tags:
        if tag == target:
            return True
        if "-" in tag:
            parts = tag.split("-")
            if len(parts) == 2:
                try:
                    start = tuple(map(int, parts[0].split(".")))
                    end = tuple(map(int, parts[1].split(".")))
                    current = tuple(map(int, target.split(".")))
                    if start <= current <= end:
                        return True
                except:
                    pass
    return False


def main():
    script_dir = Path(__file__).parent.parent
    modlist_file = script_dir / "modlist.txt"

    # Read modlist
    mods = []
    with open(modlist_file, "r") as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("#"):
                mods.append(line)

    print(f"# Wildborne Modpack - Download Links")
    print(f"# Target: Vintage Story {TARGET_VERSION}")
    print(f"# Total: {len(mods)} mods\n")

    links = []
    failed = []

    for modid in mods:
        data = fetch_json(f"{API_BASE}/mod/{modid}")
        if not data or "mod" not in data:
            failed.append(modid)
            continue

        mod = data["mod"]
        releases = mod.get("releases", [])

        # Find compatible release
        release = None
        for r in releases:
            if version_matches(r.get("tags", []), TARGET_VERSION):
                release = r
                break

        if not release and releases:
            release = releases[0]  # Fallback to latest

        if release and release.get("mainfile"):
            url = release["mainfile"]
            if not url.startswith("http"):
                url = f"https://mods.vintagestory.at{url}"

            filename = release.get("filename", f"{modid}.zip")
            version = release.get("modversion", "?")

            links.append({
                "modid": modid,
                "name": mod.get("name", modid),
                "version": version,
                "filename": filename,
                "url": url
            })
        else:
            failed.append(modid)

    # Print links
    for link in links:
        print(f"{link['url']}")

    if failed:
        print(f"\n# Failed to get links for: {', '.join(failed)}")

    # Also save to file
    output_file = script_dir / "download_links.txt"
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(f"# Wildborne Modpack - Download Links\n")
        f.write(f"# Target: Vintage Story {TARGET_VERSION}\n\n")
        for link in links:
            f.write(f"# {link['name']} v{link['version']}\n")
            f.write(f"{link['url']}\n\n")

    print(f"\n# Saved to: {output_file}")


if __name__ == "__main__":
    main()
