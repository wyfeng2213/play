@echo off
echo [INFO] Install jar/war to local repository.

cd %~dp0
call mvn clean install -P test -Dmaven.test.skip=true
pause