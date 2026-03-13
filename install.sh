#!/usr/bin/env bash
# install.sh — установка claude-glm для Linux / macOS
# Использование:
#   bash install.sh <API_KEY> [model]
#
# Примеры:
#   bash install.sh xxxxxxxx.yyyyyyyy
#   bash install.sh xxxxxxxx.yyyyyyyy glm-4.7

set -e

API_KEY="${1:-}"
MODEL="${2:-glm-5}"

# ── Проверки ──────────────────────────────────────────────────────────────────

if [ -z "$API_KEY" ]; then
  echo "Ошибка: не указан API ключ."
  echo ""
  echo "Использование:"
  echo "  bash install.sh <API_KEY> [model]"
  echo ""
  echo "Примеры:"
  echo "  bash install.sh xxxxxxxx.yyyyyyyy"
  echo "  bash install.sh xxxxxxxx.yyyyyyyy glm-4.7"
  exit 1
fi

if ! command -v claude &>/dev/null; then
  echo "Ошибка: команда 'claude' не найдена."
  echo ""
  echo "Установите Claude Code:"
  echo "  npm install -g @anthropic-ai/claude-code"
  echo ""
  echo "Для установки Node.js: https://nodejs.org"
  exit 1
fi

# ── Определяем файл конфигурации shell ────────────────────────────────────────

detect_shell_config() {
  # Сначала смотрим по текущему shell
  local current_shell
  current_shell="$(basename "${SHELL:-}")"

  if [ "$current_shell" = "zsh" ] || [ -f "$HOME/.zshrc" ]; then
    echo "$HOME/.zshrc"
  elif [ "$current_shell" = "bash" ]; then
    if [ -f "$HOME/.bashrc" ]; then
      echo "$HOME/.bashrc"
    else
      echo "$HOME/.bash_profile"
    fi
  else
    echo "$HOME/.profile"
  fi
}

SHELL_CONFIG="$(detect_shell_config)"

# ── Удаляем старые записи ─────────────────────────────────────────────────────

if [ -f "$SHELL_CONFIG" ] && grep -q "CLAUDE_GLM" "$SHELL_CONFIG" 2>/dev/null; then
  echo "Обновление существующей конфигурации в $SHELL_CONFIG ..."

  # Удаляем старые строки (macOS sed требует расширение для бэкапа)
  if sed --version &>/dev/null 2>&1; then
    # GNU sed (Linux)
    sed -i '/# claude-glm/,/^}/d' "$SHELL_CONFIG"
    sed -i '/CLAUDE_GLM/d' "$SHELL_CONFIG"
  else
    # BSD sed (macOS)
    sed -i '' '/# claude-glm/,/^}/d' "$SHELL_CONFIG"
    sed -i '' '/CLAUDE_GLM/d' "$SHELL_CONFIG"
  fi
fi

# ── Добавляем конфигурацию ────────────────────────────────────────────────────

cat >> "$SHELL_CONFIG" << SHELLEOF

# claude-glm — запуск Claude Code с Z.AI GLM моделями
export CLAUDE_GLM_API_KEY="${API_KEY}"
export CLAUDE_GLM_MODEL="${MODEL}"
claude-glm() {
  ANTHROPIC_API_KEY="\$CLAUDE_GLM_API_KEY" \\
  ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic" \\
  claude --model "\${CLAUDE_GLM_MODEL:-glm-5}" "\$@"
}
SHELLEOF

# ── Готово ────────────────────────────────────────────────────────────────────

echo ""
echo "✓ claude-glm установлен!"
echo "  Файл конфигурации: $SHELL_CONFIG"
echo "  Модель по умолчанию: $MODEL"
echo ""
echo "Применить изменения без перезапуска терминала:"
echo "  source $SHELL_CONFIG"
echo ""
echo "Использование:"
echo "  claude-glm                     # запуск с моделью $MODEL"
echo "  CLAUDE_GLM_MODEL=glm-4.7 claude-glm  # другая модель для этой сессии"
