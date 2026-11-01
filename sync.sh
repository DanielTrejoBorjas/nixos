#!/usr/bin/env bash
# Uso: ./sync.sh [hostname] [--no-pull] [--boot]
#   hostname   Nombre del host en hosts/ (por defecto: hostname de la máquina)
#   --no-pull  No actualiza el repo desde git
#   --boot     Usa "boot" en lugar de "switch" (se aplica al reiniciar)

set -euo pipefail

# --- Configuración -----------------------------------------------------------
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOST="$(hostname)"
DO_PULL=1
ACTION="switch"

for arg in "$@"; do
  case "$arg" in
    --no-pull) DO_PULL=0 ;;
    --boot)    ACTION="boot" ;;
    -h|--help) sed -n '2,6p' "$0"; exit 0 ;;
    -*)        echo "Opción desconocida: $arg" >&2; exit 1 ;;
    *)         HOST="$arg" ;;
  esac
done

HOST_DIR="$REPO_DIR/hosts/$HOST"
HW_FILE="$HOST_DIR/hardware-configuration.nix"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
err() { printf '\033[1;31mError:\033[0m %s\n' "$*" >&2; exit 1; }

# --- Validaciones ------------------------------------------------------------
[[ $EUID -eq 0 ]] && err "No ejecutes este script como root; usa tu usuario (pide sudo cuando lo necesite)."
command -v git >/dev/null || err "git no está instalado."
command -v nixos-generate-config >/dev/null || err "Este script debe correr en NixOS."
git -C "$REPO_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1 || err "$REPO_DIR no es un repositorio git."

cd "$REPO_DIR"

# --- 1. Actualizar el repo ---------------------------------------------------
if [[ $DO_PULL -eq 1 ]]; then
  log "Actualizando repositorio..."
  git pull --rebase --autostash
else
  log "Saltando git pull (--no-pull)."
fi

# --- 2. Copiar hardware-configuration.nix al repo ----------------------------
if [[ ! -d "$HOST_DIR" ]]; then
  log "Creando $HOST_DIR (host nuevo)."
  mkdir -p "$HOST_DIR"
  NEW_HOST=1
fi

log "Generando hardware-configuration.nix para '$HOST'..."
TMP_HW="$(mktemp)"
trap 'rm -f "$TMP_HW"' EXIT
nixos-generate-config --show-hardware-config > "$TMP_HW"

if [[ -f "$HW_FILE" ]] && cmp -s "$TMP_HW" "$HW_FILE"; then
  log "El hardware-configuration.nix no cambió."
else
  cp "$TMP_HW" "$HW_FILE"
  log "Actualizado: hosts/$HOST/hardware-configuration.nix"
fi

# Los flakes ignoran archivos que git no conoce: hay que agregarlo al índice.
git add "$HW_FILE"

# --- Avisos para hosts nuevos ------------------------------------------------
if [[ ! -f "$HOST_DIR/default.nix" ]]; then
  err "Falta hosts/$HOST/default.nix. Créalo y registra '$HOST' en flake.nix, luego vuelve a ejecutar."
fi
if ! grep -q "\b$HOST\b" flake.nix; then
  err "'$HOST' no aparece en flake.nix (nixosConfigurations). Agrégalo y vuelve a ejecutar."
fi

# --- 3. Activar la configuración en el sistema -------------------------------
log "Aplicando configuración: nixos-rebuild $ACTION --flake .#$HOST"
sudo nixos-rebuild "$ACTION" --flake "$REPO_DIR#$HOST"

log "Listo. Sistema configurado con '$HOST'."