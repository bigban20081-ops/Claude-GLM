# claude-glm

Одна команда для запуска [Claude Code](https://claude.ai/claude-code) с моделями [Z.AI GLM](https://z.ai/subscribe?ic=JQKJ4LXBIX) вместо Anthropic.

## Зачем это нужно

Claude Code — мощный AI-агент для разработки. По умолчанию он работает только через Anthropic и требует подписки Claude Pro ($20/мес) или оплаты по токенам.

**Z.AI** предоставляет доступ к GLM-5 через Anthropic-совместимый API, что позволяет использовать Claude Code с моделью уровня frontier за значительно меньшие деньги.

### Тарифы Z.AI

| | **Lite** | **Pro** |
|---|---|---|
| Цена | ~$10/мес | $30/мес |
| Usage | 3× Claude Pro | 5× Lite (=15× Claude Pro) |
| Нагрузка | Лёгкие задачи | Сложные задачи |
| Скорость | Стандартная | На 40–60% быстрее |
| Приоритет | Стандартный | Приоритетный доступ к новым моделям |
| Vision, Web Search, Web Reader, Zread MCP | — | ✓ |
| Совместимость | Claude Code, Cursor, Cline, Kilo Code и 20+ инструментов | Аналогично |

Получить доступ: [z.ai/subscribe](https://z.ai/subscribe?ic=JQKJ4LXBIX)

---

## GLM-5 vs Claude Opus — сравнение

| Бенчмарк | GLM-5 | Claude Opus 4 |
|---|---|---|
| MMLU (знания) | 88.4 | 87.4 |
| HumanEval (код) | 90.2 | 84.9 |
| MATH (математика) | 82.6 | 78.0 |
| GPQA (наука) | 69.1 | 74.9 |
| Контекст | 128K токенов | 200K токенов |
| Tool calling | ✓ Agentic | ✓ |
| Галлюцинации | Рекордно низкий уровень | Низкий уровень |

> GLM-5 опережает Opus по коду и математике, незначительно уступает по научным задачам (GPQA).

---

## Требования

Перед установкой убедитесь, что установлен **Node.js** и **Claude Code**:

**1. Установить Node.js**

```bash
# macOS (Homebrew)
brew install node

# Ubuntu / Debian
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Windows (winget)
winget install OpenJS.NodeJS.LTS
```

Или скачать установщик: https://nodejs.org

**2. Установить Claude Code**

```bash
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
