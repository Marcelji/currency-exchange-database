@echo off

REM Dane logowania pobierane sa ze zmiennych srodowiskowych.
REM Ustaw je przed uruchomieniem, np.:
REM   set ORA_USER=twoj_uzytkownik
REM   set ORA_PASSWORD=twoje_haslo

if "%ORA_USER%"=="" (
  echo Brak zmiennej ORA_USER. Ustaw ja przed uruchomieniem.
  pause
  exit /b 1
)
if "%ORA_PASSWORD%"=="" (
  echo Brak zmiennej ORA_PASSWORD. Ustaw ja przed uruchomieniem.
  pause
  exit /b 1
)

set USER_NAME=%ORA_USER%
set PASSWORD=%ORA_PASSWORD%
set CONNECT_STR=FREEPDB1

set CTL_DIR=ctl
set LOG_DIR=log
set BAD_DIR=bad

if not exist %LOG_DIR% mkdir %LOG_DIR%
if not exist %BAD_DIR% mkdir %BAD_DIR%

sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_panstwo.ctl log=%LOG_DIR%\p_16_panstwo.log bad=%BAD_DIR%\p_16_panstwo.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_wojewodztwo.ctl log=%LOG_DIR%\p_16_wojewodztwo.log bad=%BAD_DIR%\p_16_wojewodztwo.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_miasto.ctl log=%LOG_DIR%\p_16_miasto.log bad=%BAD_DIR%\p_16_miasto.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_ulica.ctl log=%LOG_DIR%\p_16_ulica.log bad=%BAD_DIR%\p_16_ulica.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_rodzaj_dokument.ctl log=%LOG_DIR%\p_16_rodzaj_dokument.log bad=%BAD_DIR%\p_16_rodzaj_dokument.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_typ_oddzialu.ctl log=%LOG_DIR%\p_16_typ_oddzialu.log bad=%BAD_DIR%\p_16_typ_oddzialu.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_stanowisko.ctl log=%LOG_DIR%\p_16_stanowisko.log bad=%BAD_DIR%\p_16_stanowisko.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_typ_transakcji.ctl log=%LOG_DIR%\p_16_typ_transakcji.log bad=%BAD_DIR%\p_16_typ_transakcji.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_metoda_platnosci.ctl log=%LOG_DIR%\p_16_metoda_platnosci.log bad=%BAD_DIR%\p_16_metoda_platnosci.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_waluta.ctl log=%LOG_DIR%\p_16_waluta.log bad=%BAD_DIR%\p_16_waluta.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_zrodlo_kursu.ctl log=%LOG_DIR%\p_16_zrodlo_kursu.log bad=%BAD_DIR%\p_16_zrodlo_kursu.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_tabela_kursowa.ctl log=%LOG_DIR%\p_16_tabela_kursowa.log bad=%BAD_DIR%\p_16_tabela_kursowa.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_oddzial_kantoru.ctl log=%LOG_DIR%\p_16_oddzial_kantoru.log bad=%BAD_DIR%\p_16_oddzial_kantoru.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_pracownik.ctl log=%LOG_DIR%\p_16_pracownik.log bad=%BAD_DIR%\p_16_pracownik.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_klient.ctl log=%LOG_DIR%\p_16_klient.log bad=%BAD_DIR%\p_16_klient.bad
sqlldr %USER_NAME%/%PASSWORD%@%CONNECT_STR% control=%CTL_DIR%\p_16_transakcja_wymiany.ctl log=%LOG_DIR%\p_16_transakcja_wymiany.log bad=%BAD_DIR%\p_16_transakcja_wymiany.bad

echo.
echo Ladowanie danych zakonczone.
pause