#!/usr/bin/env bash

set -euo pipefail

# Install postgresql
sudo apt install postgresql-14 libpq-dev
sudo apt install postgresql-server-dev-14

# Install pg-vector
src="$HOME/pgvector"
rm -rf "$src"
git clone --branch v0.4.0 https://github.com/pgvector/pgvector.git "$src"
make -C "$src"
sudo make -C "$src" install
rm -rf "$src"
