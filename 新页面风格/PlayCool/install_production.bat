@echo off
echo [INFO] Install jar/war to local repository.

cd %~dp0
call mvn clean install -P production -Dmaven.test.skip=true
pause