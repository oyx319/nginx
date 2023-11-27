#!/bin/bash

set -e

for d in {stage,release}{-en,}-keepwork.tk; do
  cd $d
  echo "cd $d"
  cat > ssl.conf <<EOF
listen 443 ssl;
ssl off;
ssl_certificate /etc/nginx/ssl/$d/ssl_bundle.crt;
ssl_certificate_key /etc/nginx/ssl/$d/private.key;
EOF
  cd ..
done
