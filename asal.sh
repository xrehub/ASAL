#!/usr/bin/env bash
set -euo pipefail

# ASAL – Automatic Log Archiving System
# Author: Hubert
# Version: 1.1
# Description: Script to automatically archive and clean up log files in Linux system.

CONF_FILE="${1:-./asal.conf.example}"

if [[ ! -f "$CONF_FILE" ]]; then
  echo "⛔ Configuration file not found: $CONF_FILE"
  exit 1
fi

# Load configuration
# shellcheck source=/dev/null
source "$CONF_FILE"

mkdir -p "$ARCHIVE_DIR"
touch "$ASAL_LOG"

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

log() {
  echo "[$(timestamp)] $*" | tee -a "$ASAL_LOG"
}

log "🚀 ASAL takes off..."

# Find files older than DAYS_TO_ARCHIVE
mapfile -t FILES < <(find $LOG_SOURCES -type f -mtime +$DAYS_TO_ARCHIVE 2>/dev/null)

if [[ ${#FILES[@]} -eq 0 ]]; then
  log "No files to archive."
  exit 0
fi

# Create target directory with date
DATE_FOLDER="$(date +%Y-%m)"
mkdir -p "${ARCHIVE_DIR}/${DATE_FOLDER}"

ARCHIVE_NAME="${ARCHIVE_DIR}/${DATE_FOLDER}/logs-$(date +%Y%m%d-%H%M%S).tar.gz"

log "⌛ Creating archive..: $ARCHIVE_NAME"

tar -czf "$ARCHIVE_NAME" "${FILES[@]}" || { log "❌ Błąd kompresji"; exit 1; }

if [[ "$DELETE_ORIGINAL" == "yes" ]]; then
  for f in "${FILES[@]}"; do
    rm -f "$f"
    log "Removed original: $f"
  done
fi

log "🟢 Archive created: $ARCHIVE_NAME"

# Cleaning up old archives
find "$ARCHIVE_DIR" -type f -name "*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \; -print | while read -r OLD; do

  log "❌ Old archive removed: $OLD"

done || true

log "✅ ASAL zakończył działanie."
