@echo off
setlocal

REM Opción para el usuario: Presiona "f" para optimizar y desfragmentar o cualquier tecla para continuar automáticamente.
set /p choice=Presiona "f" para optimizar y desfragmentar, o cualquier tecla para continuar automáticamente: 

if /i "%choice%"=="f" (
	echo Correcciones de Miguel Andrade
    REM Corrección de errores del sistema sin preguntar
    echo Verificando y reparando errores del disco...
    chkdsk C: /f /r /x

    REM Optimización del arranque
    echo Optimizando el arranque del sistema...
    defrag C: /b
    REM Corrección de errores del sistema sin preguntar
    echo Verificando y reparando errores del disco...
    chkdsk C: /f /r /x

    REM Optimización del arranque
    echo Optimizando el arranque del sistema...
    defrag C: /b

    echo Configuración y limpieza completadas.
    echo Corrección de errores y optimización completadas.
) else (
    echo Optimizador de Miguel Andrade

    REM Deshabilitar la hibernación (puede liberar espacio en el disco duro)
    powercfg /h off

    REM Mostrar las extensiones de archivo y archivos ocultos
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f

    REM Mostrar las carpetas y archivos ocultos en el Explorador de archivos
    attrib -h -s "%USERPROFILE%\AppData\Local\Temp"
    attrib -h -s "%USERPROFILE%\AppData\Local\Microsoft\Windows\History"
    attrib -h -s "%USERPROFILE%\AppData\Local\Microsoft\Windows\Temporary Internet Files"
    attrib -h -s "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache"
    attrib -h -s "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCookies"

    REM Deshabilitar las sugerencias de Windows y la recopilación de datos
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f

    REM Desactivar la función "Buscar mi dispositivo"
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableLocationScript" /t REG_DWORD /d "0" /f

    REM Limpiar la caché de iconos y reiniciar el Explorador de Windows
    ie4uinit.exe -ClearIconCache
    taskkill /f /im explorer.exe
    start explorer.exe

    REM Limpieza de archivos temporales
    echo Limpiando archivos temporales...
    del /f /q "%USERPROFILE%\AppData\Local\Temp\*.*"
    del /f /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\History\*.*"
    del /f /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*"
    del /f /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache\*.*"
    del /f /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCookies\*.*"


)

pause
