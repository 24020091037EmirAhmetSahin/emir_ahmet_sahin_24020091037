@echo off
title EmiraGezi - JSP Jetty
cd /d "%~dp0SehirRehberi"
call mvnw.cmd -q jetty:run
