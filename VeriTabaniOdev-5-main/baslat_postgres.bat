@echo off
title EmiraGezi - PostgreSQL
"C:\Program Files\PostgreSQL\17\bin\pg_ctl.exe" -D "%~dp0veritabani\postgres_data" -o "-p 5433" -l "%~dp0veritabani\postgres.log" start
echo PostgreSQL 5433 portunda calisiyor.
