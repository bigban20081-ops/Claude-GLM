# install.ps1 — установка claude-glm для Windows (PowerShell)
# Использование:
#   .\install.ps1 -ApiKey "xxxxxxxx.yyyyyyyy"
#   .\install.ps1 -ApiKey "xxxxxxxx.yyyyyyyy" -Model "glm-4.7"

param(
    [Parameter(Mandatory = $true, HelpMessage = "Z.AI API ключ")]
    [string]$ApiKey,

    [Parameter(HelpMessage = "Модель GLM: glm-5 или glm-4.7")]
    [string]$Model = ""
)

# ── Проверки ──────────────────────────────────────────────────────────────────

if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Error @"
Ошибка: команда 'claude' не найдена.

Установите Claude Code:
  npm install -g @anthropic-ai/claude-code

Для установки Node.js: https://nodejs.org
"@
    exit 1
}

# ── Выбор модели ──────────────────────────────────────────────────────────────

if (-not $Model) {
    Write-Host ""
    Write-Host "Выберите модель:"
    Write-Host "  1) glm-5   (рекомендуется, последняя версия)"
    Write-Host "  2) glm-4.7 (предыдущая стабильная версия)"
    Write-Host ""
    $modelChoice = Read-Host "Ваш выбор [1/2] (по умолчанию: 1)"
    if ($modelChoice -eq "2") { $Model = "glm-4.7" } else { $Model = "glm-5" }
}

# ── Файл профиля PowerShell ───────────────────────────────────────────────────

$ProfilePath = $PROFILE
$ProfileDir  = Split-Path $ProfilePath

if (-not (Test-Path $ProfileDir)) {
    New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null
}

if (-not (Test-Path $ProfilePath)) {
    New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
}

# ── Удаляем старые записи ─────────────────────────────────────────────────────

$existing = Get-Content $ProfilePath -ErrorAction SilentlyContinue
if ($existing -match "CLAUDE_GLM") {
    Write-Host "Обновление существующей конфигурации..."

    $lines      = Get-Content $ProfilePath
    $skip       = $false
    $filtered   = @()

    foreach ($line in $lines) {
        if ($line -match "# claude-glm") { $skip = $true }
        if (-not $skip) { $filtered += $line }
        if ($skip -and $line -eq "}") { $skip = $false }
    }

    Set-Content $ProfilePath $filtered
}

# ── Добавляем конфигурацию ────────────────────────────────────────────────────

$snippet = @"

# claude-glm — запуск Claude Code с Z.AI GLM моделями
`$env:CLAUDE_GLM_API_KEY = "$ApiKey"
`$env:CLAUDE_GLM_MODEL   = "$Model"
function claude-glm {
    `$env:ANTHROPIC_API_KEY   = `$env:CLAUDE_GLM_API_KEY
    `$env:ANTHROPIC_BASE_URL  = "https://api.z.ai/api/anthropic"
    `$model = if (`$env:CLAUDE_GLM_MODEL) { `$env:CLAUDE_GLM_MODEL } else { "glm-5" }
    claude --model `$model @args
}
"@

Add-Content $ProfilePath $snippet

# ── Применяем в текущей сессии ────────────────────────────────────────────────

$env:CLAUDE_GLM_API_KEY  = $ApiKey
$env:CLAUDE_GLM_MODEL    = $Model
$env:ANTHROPIC_API_KEY   = $ApiKey
$env:ANTHROPIC_BASE_URL  = "https://api.z.ai/api/anthropic"

function claude-glm {
    $env:ANTHROPIC_API_KEY  = $env:CLAUDE_GLM_API_KEY
    $env:ANTHROPIC_BASE_URL = "https://api.z.ai/api/anthropic"
    $model = if ($env:CLAUDE_GLM_MODEL) { $env:CLAUDE_GLM_MODEL } else { "glm-5" }
    claude --model $model @args
}

# ── Готово ────────────────────────────────────────────────────────────────────

Write-Host ""
Write-Host "claude-glm установлен!" -ForegroundColor Green
Write-Host "  Профиль: $ProfilePath"
Write-Host "  Модель по умолчанию: $Model"
Write-Host ""
Write-Host "Команда уже доступна в этой сессии."
Write-Host ""
Write-Host "Использование:"
Write-Host "  claude-glm                              # запуск с моделью $Model"
Write-Host "  `$env:CLAUDE_GLM_MODEL='glm-4.7'; claude-glm   # другая модель"
