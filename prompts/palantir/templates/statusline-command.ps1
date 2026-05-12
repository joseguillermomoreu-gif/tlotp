# TLOTP statusline-command.ps1 · v1.0.0 · Windows PS 5.1+
# Fuente versionada: prompts/palantir/templates/statusline-command.ps1
# Claude Code status line — 2 líneas
# Línea 1: dir · branch · modelo · coste
# Línea 2: barra contexto · barra 5h (tiempo restante) · tiempo restante 7d
#
# Compat: PowerShell 5.1.19041+ (Windows 10/11 default) y PS 7+
# Lectura de input: [Console]::In.ReadToEnd() (NO $input — variable de pipeline)

$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------
# Lectura de stdin (Claude Code pasa JSON via pipe al proceso)
# ---------------------------------------------------------------------------
$rawInput = [Console]::In.ReadToEnd()
if ([string]::IsNullOrWhiteSpace($rawInput)) {
    exit 0
}

try {
    $data = $rawInput | ConvertFrom-Json
} catch {
    exit 0
}

# ---------------------------------------------------------------------------
# Helpers de acceso seguro a propiedades anidadas (sin ?. de PS 7+)
# ---------------------------------------------------------------------------
function Get-PropOr {
    param(
        [Parameter(Mandatory=$true)] $Object,
        [Parameter(Mandatory=$true)] [string] $Path,
        $Default = $null
    )
    $current = $Object
    foreach ($segment in $Path.Split('.')) {
        if ($null -eq $current) { return $Default }
        $prop = $current.PSObject.Properties[$segment]
        if ($null -eq $prop) { return $Default }
        $current = $prop.Value
    }
    if ($null -eq $current) { return $Default }
    return $current
}

# ---------------------------------------------------------------------------
# Datos
# ---------------------------------------------------------------------------
$model = Get-PropOr $data 'model.display_name' 'Unknown'
$cwd   = Get-PropOr $data 'workspace.current_dir' ''

$home_dir = $env:USERPROFILE
if ([string]::IsNullOrEmpty($home_dir)) { $home_dir = $env:HOME }

if (-not [string]::IsNullOrEmpty($cwd) -and -not [string]::IsNullOrEmpty($home_dir) -and $cwd.StartsWith($home_dir)) {
    $cwd_short = '~' + $cwd.Substring($home_dir.Length)
} else {
    $cwd_short = $cwd
}

# Detección git (omite segmento si git no está en PATH o el cwd no es repo)
$git_branch = ''
$git_cmd = Get-Command git -ErrorAction SilentlyContinue
if ($null -ne $git_cmd -and -not [string]::IsNullOrEmpty($cwd)) {
    try {
        $null = & git -C $cwd rev-parse --git-dir 2>$null
        if ($LASTEXITCODE -eq 0) {
            $branch_raw = & git -C $cwd branch --show-current 2>$null
            if ($LASTEXITCODE -eq 0 -and -not [string]::IsNullOrEmpty($branch_raw)) {
                $git_branch = $branch_raw.Trim()
            }
        }
    } catch {
        $git_branch = ''
    }
}

# Coste: usar cost.total_cost_usd si existe, sino calcular desde tokens
$cost_usd_raw = Get-PropOr $data 'cost.total_cost_usd' $null
if ($null -eq $cost_usd_raw) {
    $total_in  = [double](Get-PropOr $data 'context_window.total_input_tokens' 0)
    $total_out = [double](Get-PropOr $data 'context_window.total_output_tokens' 0)
    $cache_w   = [double](Get-PropOr $data 'context_window.current_usage.cache_creation_input_tokens' 0)
    $cache_r   = [double](Get-PropOr $data 'context_window.current_usage.cache_read_input_tokens' 0)
    $cost_usd  = ($total_in * 3.00 + $total_out * 15.00 + $cache_w * 3.75 + $cache_r * 0.30) / 1000000.0
} else {
    $cost_usd = [double]$cost_usd_raw
}
$cost_fmt = '$' + ('{0:F4}' -f $cost_usd)

$ctx_pct_raw = Get-PropOr $data 'context_window.used_percentage' 0
$ctx_pct = [int][Math]::Floor([double]$ctx_pct_raw)

$five_h        = Get-PropOr $data 'rate_limits.five_hour.used_percentage' $null
$five_h_reset  = Get-PropOr $data 'rate_limits.five_hour.resets_at' $null
$seven_d       = Get-PropOr $data 'rate_limits.seven_day.used_percentage' $null
$seven_d_reset = Get-PropOr $data 'rate_limits.seven_day.resets_at' $null

# ---------------------------------------------------------------------------
# Formatear tiempo restante a partir de un timestamp Unix
# ---------------------------------------------------------------------------
function Format-Remaining {
    param([Parameter(Mandatory=$true)] [long] $ResetTs)
    $now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $remaining = $ResetTs - $now
    if ($remaining -le 0) { return 'reset' }
    $d = [int][Math]::Floor($remaining / 86400)
    $h = [int][Math]::Floor(($remaining % 86400) / 3600)
    $m = [int][Math]::Floor(($remaining % 3600) / 60)
    if ($d -gt 0)     { return ('{0}d{1}h' -f $d, $h) }
    elseif ($h -gt 0) { return ('{0}h{1}m' -f $h, $m) }
    else              { return ('{0}m' -f $m) }
}

# ---------------------------------------------------------------------------
# Colores ANSI (escape literal con [char]27 — compat PS 5.1)
# ---------------------------------------------------------------------------
$ESC    = [char]27
$GREEN  = "$ESC[32m"
$YELLOW = "$ESC[33m"
$RED    = "$ESC[31m"
$CYAN   = "$ESC[36m"
$BLUE   = "$ESC[34m"
$DIM    = "$ESC[2m"
$RESET  = "$ESC[0m"
$NERD_BRANCH = [char]0xE0A0  # Nerd Font branch icon

# ---------------------------------------------------------------------------
# Funciones auxiliares
# ---------------------------------------------------------------------------
function New-StatusBar {
    param(
        [Parameter(Mandatory=$true)] [int] $Percent,
        [int] $Width = 10
    )
    if ($Percent -lt 0)   { $Percent = 0 }
    if ($Percent -gt 100) { $Percent = 100 }
    $filled = [int][Math]::Floor($Percent * $Width / 100)
    $empty  = $Width - $filled
    $bar = ''
    if ($filled -gt 0) { $bar = ([string][char]0x2588) * $filled }
    if ($empty  -gt 0) { $bar = $bar + ([string][char]0x2591) * $empty }
    return $bar
}

function Get-BarColor {
    param([Parameter(Mandatory=$true)] [int] $Percent)
    if     ($Percent -ge 80) { return $RED }
    elseif ($Percent -ge 50) { return $YELLOW }
    else                     { return $GREEN }
}

$SEP = "$DIM · $RESET"

# ---------------------------------------------------------------------------
# Línea 1: dir  ·  branch  ·  modelo  ·  coste
# ---------------------------------------------------------------------------
$dir_s   = "$GREEN$cwd_short$RESET"
$model_s = "$CYAN$model$RESET"
$cost_s  = "$BLUE$cost_fmt$RESET"

if (-not [string]::IsNullOrEmpty($git_branch)) {
    $branch_s = "$YELLOW$NERD_BRANCH $git_branch$RESET"
    $line1 = "$dir_s$SEP$branch_s$SEP$model_s$SEP$cost_s"
} else {
    $line1 = "$dir_s$SEP$model_s$SEP$cost_s"
}

# ---------------------------------------------------------------------------
# Línea 2: barra ctx  ·  barra 5h (tiempo restante)  ·  tiempo restante 7d
# ---------------------------------------------------------------------------
$ctx_bar   = New-StatusBar -Percent $ctx_pct
$ctx_color = Get-BarColor  -Percent $ctx_pct
$line2 = "$ctx_color$ctx_bar$RESET $ctx_pct% ctx"

if ($null -ne $five_h) {
    $five_h_int = [int][Math]::Round([double]$five_h, 0)
    $fh_bar   = New-StatusBar -Percent $five_h_int
    $fh_color = Get-BarColor  -Percent $five_h_int
    if ($null -ne $five_h_reset) {
        $fh_label = Format-Remaining -ResetTs ([long]$five_h_reset)
    } else {
        $fh_label = "$five_h_int%"
    }
    $line2 = "$line2$SEP$fh_color$fh_bar$RESET $five_h_int% $fh_label"
}

if ($null -ne $seven_d) {
    $seven_d_int = [int][Math]::Round([double]$seven_d, 0)
    $sd_bar   = New-StatusBar -Percent $seven_d_int
    $sd_color = Get-BarColor  -Percent $seven_d_int
    if ($null -ne $seven_d_reset) {
        $sd_label = Format-Remaining -ResetTs ([long]$seven_d_reset)
    } else {
        $sd_label = "$seven_d_int%"
    }
    $line2 = "$line2$SEP$sd_color$sd_bar$RESET $seven_d_int% $sd_label"
}

# ---------------------------------------------------------------------------
# Salida
# ---------------------------------------------------------------------------
[Console]::Out.WriteLine($line1)
[Console]::Out.WriteLine($line2)
