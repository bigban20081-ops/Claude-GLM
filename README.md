# claude-glm

Одна команда для запуска [Claude Code](https://claude.ai/claude-code) с моделями [Z.AI GLM](https://z.ai/subscribe?ic=JQKJ4LXBIX) вместо Anthropic.

## Требования

Перед установкой убедитесь, что установлен **Node.js** и **Claude Code**:

```bash
# 1. Установить Node.js (https://nodejs.org)

# 2. Установить Claude Code
npm install -g @anthropic-ai/claude-code
```

Получить API ключ Z.AI: https://z.ai/subscribe?ic=JQKJ4LXBIX

---

## Установка

### Linux / macOS

```bash
curl -sSL https://raw.githubusercontent.com/bigban20081-ops/Claude-GLM/main/install.sh | bash -s -- <API_KEY>
```

Или скачать и запустить вручную:

```bash
curl -sSL https://raw.githubusercontent.com/bigban20081-ops/Claude-GLM/main/install.sh -o install.sh
bash install.sh <API_KEY>
```

С другой моделью по умолчанию:

```bash
bash install.sh <API_KEY> glm-4.7
```

Применить без перезапуска терминала:

```bash
source ~/.zshrc   # или ~/.bashrc
```

---

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/bigban20081-ops/Claude-GLM/main/install.ps1 | iex
```

> Команда выше спросит API ключ интерактивно. Или передать сразу:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/bigban20081-ops/Claude-GLM/main/install.ps1))) -ApiKey "<API_KEY>"
```

С другой моделью:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/bigban20081-ops/Claude-GLM/main/install.ps1))) -ApiKey "<API_KEY>" -Model "glm-4.7"
```

---

## Использование

После установки просто запускайте `claude-glm` вместо `claude`:

```bash
claude-glm
```

### Выбор модели

Модель задаётся при установке (по умолчанию `glm-5`). Изменить для текущей сессии:

```bash
# Linux / macOS
CLAUDE_GLM_MODEL=glm-4.7 claude-glm

# Windows PowerShell
$env:CLAUDE_GLM_MODEL = "glm-4.7"; claude-glm
```

Изменить навсегда — переустановить:

```bash
bash install.sh <API_KEY> glm-4.7
```

### Доступные модели Z.AI

| Модель | Описание |
|--------|----------|
| `glm-5` | Последняя версия, рекомендуется |
| `glm-4.7` | Предыдущая стабильная версия |

Полный список: https://z.ai/subscribe?ic=JQKJ4LXBIX

---

## Обновление ключа или модели

Просто запустите установку повторно — старые настройки будут заменены:

```bash
bash install.sh <NEW_API_KEY> glm-5
```
