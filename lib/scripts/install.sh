#!/usr/bin/env bash

# Install postgresql
sudo apt install postgresql-14 libpq-dev
sudo apt install postgresql-server-dev-14

# Install pg-vector
git clone --branch v0.4.0 https://github.com/pgvector/pgvector.git ~/pgvector
cd pgvector
make && sudo make install
cd
rm -rf pgvector
