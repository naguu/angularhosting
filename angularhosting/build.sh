#!/bin/bash

# 1. Angular Build ausführen
ng build --output-path temp --base-href /REPO-NAME/

# 2. Überprüfen, ob der Build erfolgreich war
if [ -d "temp/browser" ]; then
  echo "Build erfolgreich. Bereite die Dateien für GitHub Pages vor."

  # 3. Lösche den Inhalt des docs-Ordners
  rm -rf docs/*

  # 4. Kopiere alle Dateien aus temp/browser nach docs
  cp -R temp/browser/* docs/

  # 5. Entferne den temporären Ordner
  rm -rf temp

  echo "Dateien erfolgreich in den docs-Ordner verschoben."
else
  echo "Build fehlgeschlagen. Überprüfe den Angular-Build."
fi

