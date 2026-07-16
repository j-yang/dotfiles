#!/bin/bash
set -e
if command -v duti >/dev/null 2>&1 && [ -d /Applications/sioyek.app ]; then
  duti -s info.sioyek.sioyek pdf all && echo "PDF default set to Sioyek"
fi
