@ECHO OFF

:: ------------------------------------------------------------------
:: 1. 切换代码页到 936 (简体中文 GBK)，解决中文显示乱码问题
::    > NUL 是为了不显示 "Active code page: 936" 这句提示
:: ------------------------------------------------------------------
CHCP 936 > NUL

:: 使用 SETLOCAL 来确保所有环境变量的修改都只在当前窗口有效
SETLOCAL

:: ----------------------------
:: actpy.bat - ComfyUI 内嵌 Python 环境初始化
:: ----------------------------

:: 清理可能干扰的环境变量
SET "PYTHONHOME="
SET "PYTHONPATH="

:: 内嵌 Python 路径 (%~dp0 代表 .bat 文件所在的目录)
SET "PYTHON_DIR=%~dp0.ext"
SET "PYTHON_EXE=%PYTHON_DIR%\python.exe"

:: 检查内嵌 Python 是否存在
IF NOT EXIST "%PYTHON_EXE%" (
    ECHO.
    ECHO [错误] 未找到内嵌 Python，请检查路径是否正确:
    ECHO "%PYTHON_EXE%"
    ECHO.
    PAUSE
    EXIT /B 1
)

:: 设置 PATH 优先
SET "PATH=%PYTHON_DIR%;%PYTHON_DIR%\Scripts;%PATH%"

:: 自定义 CMD 提示符
PROMPT (comfyui) $P$G

:: 创建别名 (使用 DOSKEY)
DOSKEY python="%PYTHON_EXE%" $*
DOSKEY py="%PYTHON_EXE%" $*
DOSKEY pip="%PYTHON_EXE%" -m pip $*

:: 清理屏幕并显示欢迎信息和版本，确认生效
CLS
ECHO ComfyUI 内嵌 Python 环境已激活。
ECHO.
ECHO - 使用 'python' 或 'pip' 命令将自动调用内嵌版本。
ECHO - 关闭此窗口即可退出环境。
ECHO.
ECHO 正在检查版本...
ECHO ------------------------------------
python --version
pip --version
ECHO ------------------------------------
ECHO.