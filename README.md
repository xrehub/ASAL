# ASAL – Automatic Log Archiving System

A simple system for automatic system log archiving.

## Functions

- Archives logs older than X days
- Compresses to `.tar.gz`
- Deletes od archives
- Runs via `cron` or `systemd`
- Writes an activity

## Project Structure

asal/ - asal.sh - asal.conf - tests/ - test_setup.sh - docs - design.md - README.md - LICENSE
## Instalation

```bash
git clone https://github.com/xrehub/ASAL.git
cd asal
chmod +x asal.sh
cp asal.conf /etc/asal.conf
cd tests
./test_setup.sh
../asal.sh ./asal_test.conf
