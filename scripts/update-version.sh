#!/bin/bash
# Script para actualizar versión de un prompt en todos sus archivos

set -e

PROMPT=$1
NEW_VERSION=$2

if [ -z "$PROMPT" ] || [ -z "$NEW_VERSION" ]; then
    echo "❌ Uso: ./update-version.sh <prompt> <nueva-version>"
    echo ""
    echo "Ejemplos:"
    echo "  ./update-version.sh palantir 1.4.0"
    echo "  ./update-version.sh gollum 1.0.0"
    exit 1
fi

echo "🔄 Actualizando $PROMPT a v$NEW_VERSION..."
echo ""

# Obtener versión actual desde VERSION.md
CURRENT_VERSION=$(grep -A2 "### $PROMPT" prompts/VERSION.md | grep "Versión:" | sed 's/.*: //')
CURRENT_SHORT=$(echo $NEW_VERSION | sed 's/\.[0-9]*$//')

echo "📊 Versión actual: $CURRENT_VERSION"
echo "📊 Nueva versión: $NEW_VERSION"
echo "📊 Versión corta: v$CURRENT_SHORT"
echo ""

# Confirmar
read -p "¿Continuar? (s/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    echo "❌ Cancelado"
    exit 1
fi

# Actualizar VERSION.md
echo "📝 Actualizando VERSION.md..."
sed -i "s/^- \*\*Versión\*\*: $CURRENT_VERSION/- **Versión**: $NEW_VERSION/" prompts/VERSION.md
sed -i "s/^- \*\*Versión corta\*\*: v.*/- **Versión corta**: v$CURRENT_SHORT/" prompts/VERSION.md

# Actualizar archivos del prompt (caso específico para palantir)
if [ "$PROMPT" = "palantir" ]; then
    echo "📝 Actualizando archivos de Palantír..."

    # Buscar y reemplazar versión antigua por nueva
    find prompts/palantir -type f -name "*.md" -exec sed -i "s/v$CURRENT_VERSION/v$NEW_VERSION/g" {} \;
    find prompts/palantir -type f -name "*.md" -exec sed -i "s/v$(echo $CURRENT_VERSION | sed 's/\.[0-9]*$//')/v$CURRENT_SHORT/g" {} \;
fi

echo ""
echo "✅ Versión actualizada a v$NEW_VERSION"
echo ""
echo "📋 Próximos pasos:"
echo "  1. Revisar cambios: git diff"
echo "  2. Commit: git add . && git commit -m 'chore($PROMPT): bump version to v$NEW_VERSION'"
echo "  3. Tag: git tag v$NEW_VERSION"
echo "  4. Push: git push && git push --tags"
