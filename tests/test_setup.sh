#!/usr/bin/env bash
set -e

TEST_DIR="./tests/test_logs"
CONF="./tests/asal_test.conf"
ARCHIVE="./tests/archives"

rm -rf "$TEST_DIR" "$ARCHIVE"
mkdir -p "$TEST_DIR" "$ARCHIVE"

#test logs
for i in {1..5}; do
  echo "log entry $1" > "${TEST_DIR0}/app.log.$i"
  touch -d "$i days ago" "${TEST_DIR}/app.log.$i"
done

cat > "$CONF" <<EOF
LOG_SOURCES="${TEST_DIR}"
ARCCHIVE_DIR="${ARCHIVE}"
DAYS_TO_ARCHIVE=2
RETENTION_DAYS=7
DELETE_ORIGINAL="no"
ALERT_EMAIL=""
MAX_ARCHIVE_SIZE_MB=0
EOF


echo "Test logs and configuration ceated"
echo "Run test: ..asal.sh ./tests/asal_test.conf"
