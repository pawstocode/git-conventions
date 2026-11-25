@echo off
setlocal

REM ==========================================
REM Find target Git repository root
REM ==========================================

set "ROOT=%~dp0..\.."
for %%i in ("%ROOT%") do set "ROOT=%%~fi"

if not exist "%ROOT%\.git" (
    echo ERROR: Target directory is not a Git repository.
    echo Target directory: %ROOT%
    goto error
)

REM ==========================================
REM Configuration
REM ==========================================

set "CONVENTIONS_DIR=%ROOT%\tools\git-conventions"
set "HOOK_DIR=%CONVENTIONS_DIR%\.githooks"
set "HOOK_FILE=%HOOK_DIR%\commit-msg"
set "TEMPLATE_FILE=%CONVENTIONS_DIR%\.gitmessage"

echo Checking Git conventions files...

REM ==========================================
REM Check required files
REM ==========================================

if not exist "%HOOK_FILE%" (
    echo ERROR: commit-msg hook not found: %HOOK_FILE%
    goto error
)

if not exist "%TEMPLATE_FILE%" (
    echo ERROR: Commit template not found: %TEMPLATE_FILE%
    goto error
)

REM ==========================================
REM Configure Git
REM ==========================================

git -C "%ROOT%" config --local core.hooksPath "tools/git-conventions/.githooks"

if errorlevel 1 (
    echo ERROR: Failed to configure core.hooksPath.
    goto error
)

git -C "%ROOT%" config --local commit.template "tools/git-conventions/.gitmessage"

if errorlevel 1 (
    echo ERROR: Failed to configure commit.template.
    goto error
)

REM ==========================================
REM Success
REM ==========================================

echo.
echo ==========================================
echo Git conventions configured successfully!
echo ==========================================
echo Repository: %ROOT%
echo Hook path: tools/git-conventions/.githooks
echo Commit template: tools/git-conventions/.gitmessage
echo.

echo Press any key to exit...
pause >nul
endlocal
exit /b 0

REM ==========================================
REM Error handling
REM ==========================================

:error
echo.
echo ==========================================
echo Setup failed.
echo ==========================================
echo.
echo Press any key to exit...
pause >nul
endlocal
exit /b 1