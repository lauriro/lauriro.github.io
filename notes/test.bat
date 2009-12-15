for /f "tokens=*" %a in ('dir /b *.msg') do datetime.bat %a
for /f "tokens=*" %a in ('dir /b *.*') do echo %a
for /f "tokens=*" %%a in ('dir /b *.msg') do datetime.bat %%a


echo %date:~-4,4%%date:~-7,2%%date:~-10,2%

FOR %A IN (*.*) DO @ECHO.%~sA
FOR %A IN ('dir /A:-D /B') DO @ECHO.%~sA

FOR /F %A IN ('dir /A:-D /B') DO @ECHO.%A

FOR /F %A IN ('dir /A:-D /B') DO @ECHO %%A [%%~tA] %%~xA

FOR /F "tokens=1,3 delims= " %%A IN ('dir /A:-D /T:W /-c') DO @ECHO.%%A


FOR %%V IN (%1) DO FOR /F "tokens=1-6 delims=/: " %%J IN ("%%~tV") DO IF EXIST %%L%%J%%K_%%M%%N%%O%%~xV (ECHO Cannot rename %%V) ELSE (Rename "%%V" %%L%%J%%K_%%M%%N%%O%%~xV)



FOR /F "tokens=1-5 delims=/: " %%J IN ("15.12.2009 00:52") DO echo %%L%%J%%K_%%M%%N%%O%%~xV (ECHO Cannot rename %%V) ELSE (Rename "%%V" %%L%%J%%K_%%M%%N%%O%%~xV)

