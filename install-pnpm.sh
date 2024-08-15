#!/bin/sh

mkdir -p /homepage/src
cd /homepage/src

yes | pnpm install
pnpm build
