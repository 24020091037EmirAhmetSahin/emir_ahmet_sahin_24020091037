@echo off
setlocal
cd /d "%~dp0"

set JAVA_HOME=
for %%d in ("C:\Program Files\Microsoft\jdk-17*") do set "JAVA_HOME=%%~d"
if not defined JAVA_HOME (
    echo JDK 17 bulunamadi. Lutfen Microsoft OpenJDK 17 kurun.
    exit /b 1
)

set "JAVAC=%JAVA_HOME%\bin\javac.exe"
set "JAVA=%JAVA_HOME%\bin\java.exe"
set "CP=lib\h2-2.2.224.jar;build\classes"

if not exist build\classes mkdir build\classes

"%JAVAC%" -encoding UTF-8 -cp "lib\h2-2.2.224.jar" -d build\classes src\emirasepet\*.java
if errorlevel 1 exit /b 1

"%JAVA%" -cp "%CP%" emirasepet.EmiraSepetUygulamasi
