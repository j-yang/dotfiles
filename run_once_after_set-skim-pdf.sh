#!/bin/bash
set -e
if command -v duti >/dev/null 2>&1 && [ -d /Applications/Skim.app ]; then
  /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister /Applications/Skim.app 2>/dev/null || true
  duti -s net.sourceforge.skim-app.skim com.adobe.pdf all
  duti -s net.sourceforge.skim-app.skim pdf all
  echo "PDF default set to Skim"
fi
