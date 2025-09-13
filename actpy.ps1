# ----------------------------
# actpy.ps1 - ComfyUI 内嵌 Python 环境初始化
# ----------------------------

# 1️⃣ 清理可能干扰的环境变量
Remove-Item Env:PYTHONHOME -ErrorAction SilentlyContinue
Remove-Item Env:PYTHONPATH -ErrorAction SilentlyContinue

# 2️⃣ 内嵌 Python 路径
$pythonDir = "$PSScriptRoot\.ext"   # 使用脚本所在目录
$pythonExe = "$pythonDir\python.exe"

# 检查内嵌 Python 是否存在
if (-Not (Test-Path $pythonExe)) {
    Write-Error "未找到内嵌 Python: $pythonExe"
    exit
}

# 3️⃣ 设置 PATH 优先（可选，用于 Scripts 内的 exe，如 pip.exe）
$env:PATH = "$pythonDir;$pythonDir\Scripts;" + $env:PATH

# 4️⃣ 自定义 PowerShell 提示符
function global:prompt {
    return "(comfyui) PS " + $(Get-Location) + "> "
}

# 5️⃣ 创建别名，强制使用内嵌 Python 和 pip
Set-Alias python $pythonExe
Set-Alias py $pythonExe               # py 命令也指向内嵌 Python
Set-Alias pip "$pythonExe -m pip"

# 6️⃣ 测试输出版本，确认生效
& $pythonExe --version
& $pythonExe -m pip --version