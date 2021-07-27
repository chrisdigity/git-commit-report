
@ECHO OFF

REM set time, date and current working directory of script execution
set /a HH=%time:~-11,2%+100
set "NOWDATE=%date:~10,4%-%date:~7,2%-%date:~4,2%"
set "NOWTIME=%HH:~1%:%time:~3,2%:%time:~6,2%"
set "ISODATETIME=%NOWDATE%T%NOWTIME%"
set "FILEDATETIME=%NOWDATE:-=%T%NOWTIME::=%"
set "CURRENTWORKINGDIR=%CD%"

REM set default arguments
set SINCE="1 week ago"
set UNTIL="%NOWDATE%"
for /F "tokens=*" %%i IN ('git config --global user.email') do set AUTHOR="%%i"
set "REPORTFILENAME=Report_%FILEDATETIME%.txt"
set "WORKINGDIR=%~dp0"

REM detect additional timeframe arguments
:checkargs
if NOT [%1] == [] (
  if [%1] == [--since] set "SINCE=%2" && shift
  if [%1] == [--until] set "UNTIL=%2" && shift
  shift && goto :checkargs
)

REM determine timeframes of git diff in command
set "DIFFSINCE=HEAD@{%SINCE%}"
set "DIFFUNTIL=HEAD@{%UNTIL%}"
REM build argument lists for commands
set "GITARGS=--author=%AUTHOR% --since=%SINCE%"
set "COMMANDARGS=--all --graph --abbrev-commit --pretty=oneline %GITARGS%"
REM build check command
set CHECK="git log >NUL 2>NUL && git shortlog -sn --all %GITARGS% %*"
REM build command
set "COMMAND=git log %COMMANDARGS% %*"
set COMMAND="%COMMAND% && git diff --stat %DIFFSINCE% %DIFFUNTIL%"

REM set export path, clear/begin report
set REPORT="%WORKINGDIR%%REPORTFILENAME%"
echo. > %REPORT%
echo Git Commit Report for %AUTHOR% >> %REPORT%
echo  - generated on %NOWDATE%T%NOWTIME% for %SINCE% to %UNTIL% >> %REPORT%
echo. >> %REPORT%

REM search parent directory for git repositories
for /F "delims=" %%f in ('dir /b /r "%WORKINGDIR%..\*"') do ^
if exist "%WORKINGDIR%..\%%f\.git" cd "%WORKINGDIR%..\%%f" && ^
for /F "delims=" %%c IN ('%CHECK%') do ^
if NOT "%%c" == "" echo. >> %REPORT% && ^
for /F "delims=" %%r IN ('git branch --show-current') do ^
echo ~%%f (on %%r branch): >> %REPORT% && ^
for /F "delims=" %%i in ('%COMMAND%') do ^
echo %%i >> %REPORT%

REM return to original working directory
cd "%CURRENTWORKINGDIR%"

exit /b
