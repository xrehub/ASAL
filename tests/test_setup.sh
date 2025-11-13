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
