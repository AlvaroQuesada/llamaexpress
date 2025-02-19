@echo off
echo Iniciando prueba de script...

echo Creando directorio de prueba...
mkdir test-llama-express

echo Cambiando al directorio de prueba...
cd test-llama-express

echo Creando archivo de prueba...
echo Esto es una prueba > test.txt

echo Mostrando contenido del directorio:
dir

echo.
echo Prueba completada. Presiona cualquier tecla para cerrar...
pause >nul