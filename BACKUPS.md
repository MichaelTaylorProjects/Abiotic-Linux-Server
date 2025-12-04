## 1. Backup Strategy – Abiotic Factor Dedicated Server

This document describes the automated backup system used to protect the Abiotic Factor dedicated server world data running on Linux via Wine and systemd.

The goal of this backup strategy is to ensure:
- Minimal data loss
- Fast recovery from corruption or crashes
- Low maintenance overhead
- Clear operational transparency

---

## 2. Overview

The server performs **automated nightly backups at 03:00 AM** using a cron job. The backup process:

1. Archives the active world save directory
2. Compresses the archive using `tar.gz`
3. Stores the backup locally
4. Automatically deletes backups older than 7 days

This provides a rolling one-week recovery window.

---

## 3. Backup Script Location

**Production location:**
configs/backup.sh


---

## 4. What Data Is Backed Up

Only the **active world save directory** is archived:

/home/abiotic/abioticserver/AbioticFactor/Saved/SaveGames/Server/Worlds/<WorldName>



This ensures that:
- Player progress is preserved
- World state can be restored cleanly
- Backup size remains small and efficient

The entire server installation is *not* backed up — only the data that actually matters.

---

## Backup Schedule (Cron)

The backup runs automatically every night at **03:00 AM** using a system-wide cron job:

bash
0 3 * * * /usr/local/bin/abiotic-backup.sh

 This means: \
 - No manual intervention is required
 - Backups continue even after reboots
 - The process runs independently of any user sessions


## 5. Archive Format
Each backup is stored as a compressed archive using the following format:
<WorldName>_YYYY--MM-DD_HH-MM.tar.gz

This naming schema makes it easy to sort backups chronologically, identify restore points quickly, and avoice accidental overwrites.

## 6. Retention Policy
To prevent unlimited disk usage, the script automatically removes backups older than 7 days: \
find "$DEST" -type f -mtime +7 -delete

This creates a rolling recovery window that balances storage efficiency and disaster recovery flexibility

## 7. Restore Proces
1. Stop the server: \
sudo systemctl stop abiotic

2. Extract the desired backup \
tar -xzf <backup-file>.tar.gz

3. Replace the active world directory with the extracted data

4. Restart the server

## 8. Philosophy
Designed with real-world operational constraints in mind:
 - Automation of manual work
 - Minimal attack surface
 - Clear Recovery Procedures
 - No reliance on cloud services
 - Protable across Linux (Ubuntu) Distros

## 9. Security Notes
The backup system
 - Does not require network access
 - Does not store credentials
 - Runs using controlled filesystem paths
 - Is isolated from the game client


