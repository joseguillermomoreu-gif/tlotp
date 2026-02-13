#!/bin/bash
# Actualizar versión de un prompt

PROMPT=$1
NEW_VERSION=$2

if [ -z "$PROMPT" ] || [ -z "$NEW_VERSION" ]; then
    echo "Uso: ./update-version.sh <prompt> <version>"
    echo "Ejemplo: ./update-version.sh palantir 1.4.0"
    exit 1
fi

SHORT_VERSION=$(echo $NEW_VERSION | sed 's/\.[0-9]*$//')

echo "Actualizando $PROMPT a v$NEW_VERSION..."

# Actualizar VERSION.md
sed -i "/### $PROMPT/,/^### / s/- \*\*Versión\*\*: .*/- **Versión**: $NEW_VERSION/" prompts/VERSION.md
sed -i "/### $PROMPT/,/^### / s/- \*\*Versión corta\*\*: .*/- **Versión corta**: v$SHORT_VERSION/" prompts/VERSION.md

# Actualizar archivos del prompt
find prompts/$PROMPT -type f -name "*.md" -exec sed -i "s/v[0-9]\+\.[0-9]\+\.[0-9]\+/v$NEW_VERSION/g" {} \;
find prompts/$PROMPT -type f -name "*.md" -exec sed -i "s/v[0-9]\+\.[0-9]\+\([^0-9]\)/v$SHORT_VERSION\1/g" {} \;

echo "✅ Actualizado a v$NEW_VERSION"
echo ""
echo "git add . && git commit -m 'chore($PROMPT): bump version to v$NEW_VERSION'"
echo "git tag v$NEW_VERSION && git push --tags"
