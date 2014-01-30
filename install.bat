@echo off
setlocal

set VIMFILES=%USERPROFILE%\vimfiles
set VIMRC=%USERPROFILE%\_vimrc
set GVIMRC=%USERPROFILE%\_gvimrc

echo Warning: This will overwrite the following:
echo     %VIMFILES%\
echo     %VIMRC%
echo     %GVIMRC%
set /P CONTINUE=Do you wish to continue? [Y/N]: 

if /I NOT [%CONTINUE:~0,1%]==[y] (
	echo Operation aborted.
	goto :EOF
)

echo.

:: Remove the trailing slash from the current script's directory. Robocopy
:: doesn't seem to like quoted paths with trailing slashes.
set SOURCEDIR=%~dp0
set SOURCEDIR=%SOURCEDIR:~0,-1%

robocopy "%SOURCEDIR%" "%VIMFILES%" * /S /COPY:DATS /R:0 /XF .* /XD .*
if errorlevel 8 goto :COPYERROR

echo.
echo Copying 'vimrc' and 'gvimrc' to '%USERPROFILE%'...
copy /Y /B "%VIMFILES%\vimrc" "%VIMRC%"
copy /Y /B "%VIMFILES%\gvimrc" "%GVIMRC%"
echo.
goto :END

:COPYERROR
echo An error occurred when copying files.
goto :EOF

:END
echo All done! Enjoy and code responsibly.
