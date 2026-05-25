#!/usr/bin/env bash
set -e

VAULT_NAME="${1:-my-obsidian-vault}"
DEST="$HOME/Downloads/$VAULT_NAME"

if [ -d "$DEST" ]; then
  echo "❌  '$DEST' already exists. Choose a different name or remove it first."
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "🗂  Creating vault '$VAULT_NAME' in ~/Downloads..."

# Copy vault template (includes .obsidian, .claude, templates, CLAUDE.md)
cp -r "$REPO_ROOT/vault-template/." "$DEST"

# Write settings.local.json with pre-approved Ollama permissions
# (settings.local.json is globally gitignored so it must be generated here)
mkdir -p "$DEST/.claude"
cat > "$DEST/.claude/settings.local.json" <<SETTINGS
{
  "permissions": {
    "allow": [
      "Bash(ollama list *)",
      "Bash(ollama ps *)",
      "Bash(ollama show *)",
      "Bash(ollama stop *)"
    ]
  }
}
SETTINGS

# Write a standalone package.json so the vault can be launched independently
cat > "$DEST/package.json" <<PKGJSON
{
  "name": "$(echo "$VAULT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')",
  "version": "1.0.0",
  "private": true,
  "description": "Obsidian vault powered by Claude Code",
  "scripts": {
    "start": "npm run launch:gpt-oss",
    "launch:gpt-oss": "ollama launch claude --model gpt-oss:20b",
    "launch:gemma4": "ollama launch claude --model gemma4:e2b"
  }
}
PKGJSON

echo ""
echo "✅  Vault ready at: $DEST"
echo ""
echo "   Next steps:"
echo "   1. Open in Obsidian:  File → Open vault → $DEST"
echo "   2. Launch with Claude:"
echo "      cd \"$DEST\" && npm start                   # gpt-oss:20b (default)"
echo "      cd \"$DEST\" && npm run launch:gpt-oss      # gpt-oss:20b"
echo "      cd \"$DEST\" && npm run launch:gemma4       # gemma4:e2b"
echo ""
echo "   To move to iCloud Drive, close the vault in Obsidian, move the folder,"
echo "   then reopen from the new location."
