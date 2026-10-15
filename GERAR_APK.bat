@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"
title Montando e Contando V9 - Gerar APK Android
where node >nul 2>nul || (echo Instale Node.js LTS: https://nodejs.org/ & pause & exit /b 1)
where java >nul 2>nul || (echo Instale um JDK compativel com o Android Gradle Plugin e configure JAVA_HOME. & pause & exit /b 1)
if not exist node_modules (echo Instalando dependencias... & call npm install || goto erro)
if not exist android\gradlew.bat (
 echo Preparando projeto Android pela primeira vez...
 call npx cap add android || goto erro
)
echo Sincronizando o jogo com o projeto Android...
call npx cap sync android || goto erro
echo Compilando APK de teste...
cd android
call gradlew.bat assembleDebug || goto erro
cd ..
echo APK criado em: android\app\build\outputs\apk\debug\app-debug.apk
explorer "%CD%\android\app\build\outputs\apk\debug"
pause
exit /b 0
:erro
echo Nao foi possivel gerar o APK. Confira Android Studio/SDK, JAVA_HOME e a conexao com a internet.
pause
exit /b 1
