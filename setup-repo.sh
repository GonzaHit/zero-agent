#!/bin/bash
# ============================================
# ZERO — Setup para publicar en GitHub
# Convierte el clone de Anthropic-Cybersecurity-Skills
# en un git submodule (atribución limpia)
# ============================================

set -e

ZERO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$ZERO_DIR/Anthropic-Cybersecurity-Skills"
SKILLS_REPO="https://github.com/mukul975/Anthropic-Cybersecurity-Skills.git"

echo "╔══════════════════════════════════════╗"
echo "║  ZERO — Preparar repo para GitHub    ║"
echo "╚══════════════════════════════════════╝"
echo ""

# 1. Verificar que estamos en el directorio correcto
if [ ! -f "$ZERO_DIR/SKILL.md" ]; then
    echo "❌ Error: No se encuentra SKILL.md. Ejecutar desde el directorio zero/"
    exit 1
fi

# 2. Inicializar git si no existe
if [ ! -d "$ZERO_DIR/.git" ]; then
    echo "[1/5] Inicializando repositorio git..."
    cd "$ZERO_DIR"
    git init
else
    echo "[1/5] Repositorio git ya existe ✓"
fi

# 3. Eliminar el clone y agregar como submodule
if [ -d "$SKILLS_DIR/.git" ]; then
    echo "[2/5] Convirtiendo Anthropic-Cybersecurity-Skills de clone a submodule..."
    rm -rf "$SKILLS_DIR"
    cd "$ZERO_DIR"
    git submodule add "$SKILLS_REPO" Anthropic-Cybersecurity-Skills
    echo "  ✓ Submodule agregado"
else
    echo "[2/5] Ya es submodule o no existe — verificar manualmente"
fi

# 3. Crear archivos de memoria desde templates
echo "[3/5] Creando archivos de memoria desde templates..."
for f in credentials operations tools-audited; do
    if [ -f "$ZERO_DIR/memory/${f}.md.template" ] && [ ! -f "$ZERO_DIR/memory/${f}.md" ]; then
        cp "$ZERO_DIR/memory/${f}.md.template" "$ZERO_DIR/memory/${f}.md"
        echo "  ✓ memory/${f}.md creado"
    fi
done

# 4. Verificar .gitignore
echo "[4/5] Verificando .gitignore..."
if [ -f "$ZERO_DIR/.gitignore" ]; then
    echo "  ✓ .gitignore presente"
else
    echo "  ❌ .gitignore no encontrado — crear manualmente"
fi

# 5. Resumen
echo "[5/5] Listo para commit inicial"
echo ""
echo "Próximos pasos:"
echo "  cd $ZERO_DIR"
echo "  git add ."
echo '  git commit -m "Initial commit: ZERO autonomous cybersecurity agent"'
echo "  git remote add origin https://github.com/<tu-usuario>/zero.git"
echo "  git push -u origin main"
echo ""
echo "✅ Done"
