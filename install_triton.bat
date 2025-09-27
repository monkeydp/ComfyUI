@ECHO OFF

ECHO [+] Setting up Visual Studio 2022 temporary environment for ComfyUI...

:: 1. 定义 ComfyUI 的内嵌 Python 路径
SET "PYTHON_EXE=D:\ai\comfyui\.ext\python.exe"

:: 2. 设置 MSVC 编译器的路径 (关键！)
::    将下面的路径替换为你第一步中复制的真实路径
SET "PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\Hostx64\x64;%PATH%"

ECHO [+] Environment ready. C++ Compiler should be in PATH.
ECHO.

ECHO [i] C++ Compiler (cl.exe) is at:
where cl
ECHO.

ECHO [+] Starting Triton installation using ComfyUI's Python...
ECHO --------------------------------------------------------

:: 3. 执行安装命令
"%PYTHON_EXE%" -m pip install triton

ECHO --------------------------------------------------------
ECHO [+] Triton installation finished.
ECHO.

PAUSE