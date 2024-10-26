#!/bin/bash

# 1. Angular Build ausführen
ng build --output-path temp --base-href /REPO-NAME/

# 2. Überprüfen, ob der Build erfolgreich war
if [ -d "temp/browser" ]; then
  echo "Build erfolgreich. Bereite die Dateien für GitHub Pages vor."

  # 3. SCSS-Dateien in CSS konvertieren, falls vorhanden
  for file in $(find temp/browser -name '*.scss'); do
    css_file="${file%.scss}.css"
    echo "Konvertiere $file nach $css_file ..."
    npx sass "$file" "$css_file"
  done

  # 4. Lösche den Inhalt des docs-Ordners
  rm -rf docs/*

  # 5. Kopiere alle Dateien aus temp/browser nach docs und ignoriere .scss-Dateien
  find temp/browser -name '*.scss' -exec rm {} \;
  cp -R temp/browser/* docs/

  # 6. Entferne den temporären Ordner
  rm -rf temp

  echo "Dateien erfolgreich in den docs-Ordner verschoben."
else
  echo "Build fehlgeschlagen. Überprüfe den Angular-Build."
fi
