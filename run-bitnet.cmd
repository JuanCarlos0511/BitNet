@echo off
setlocal
set "BITNET_ROOT=%~dp0"
set "BITNET_CLI=%BITNET_ROOT%build\bin\llama-cli.exe"
set "BITNET_MODEL=%BITNET_ROOT%models\BitNet-b1.58-2B-4T\ggml-model-i2_s.gguf"
set "BITNET_CHAT_TEMPLATE=%BITNET_ROOT%bitnet-chat-template.jinja"

if not exist "%BITNET_CLI%" (
    echo No se encontro el ejecutable de BitNet.
    exit /b 1
)
if not exist "%BITNET_MODEL%" (
    echo No se encontro el modelo de BitNet.
    exit /b 1
)

if "%~1"=="" (
    "%BITNET_CLI%" -m "%BITNET_MODEL%" --chat-template-file "%BITNET_CHAT_TEMPLATE%" -cnv -n 256 -t 4 -c 4096 --temp 0 --repeat-penalty 1.2
) else (
    "%BITNET_CLI%" -m "%BITNET_MODEL%" --chat-template-file "%BITNET_CHAT_TEMPLATE%" -p "%~1" -n 256 -t 4 -c 4096 --temp 0 --repeat-penalty 1.2 -st --simple-io
)
exit /b %ERRORLEVEL%
