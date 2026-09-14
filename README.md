# Baza danych kantoru wymiany walut — Oracle

Projekt relacyjnej bazy danych dla sieci kantorów wymiany walut, wraz z hurtownią
danych w schemacie gwiazdy i zestawem zapytań analitycznych.

Projekt zaliczeniowy — Oracle Database, Oracle SQL.

## Zakres

- **Model OLTP** — 16 tabel obsługujących klientów, pracowników, oddziały,
  waluty, tabele kursowe i transakcje wymiany
- **Hurtownia danych** — 14 tabel w schemacie gwiazdy, z wymiarami czasu
  (rok, miesiąc) i tabelą faktów `H_P_16_TRANSAKCJA_WYMIANY`
- **Ładowanie danych** — pliki sterujące SQL*Loader (`.ctl`) i skrypt wsadowy
  ładujący 16 zbiorów CSV (ok. 100 tys. wierszy danych testowych)
- **Zapytania analityczne** — 15 zapytań w pięciu kategoriach, każde
  zaimplementowane dwukrotnie: na modelu OLTP i na hurtowni

## Zastosowane techniki SQL

| Kategoria | Pliki | Technika |
|---|---|---|
| Rollup | `ro01`–`ro03` | `GROUP BY ROLLUP` — agregacja hierarchiczna |
| Cube | `cu01`–`cu03` | `GROUP BY CUBE` — wszystkie kombinacje wymiarów |
| Partycjonowanie | `po01`–`po03` | `SUM() OVER (PARTITION BY ...)` — udział w grupie |
| Funkcje okna | `ok01`–`ok03` | sumy narastające, porównanie okres do okresu |
| Rankingi | `fr01`–`fr03` | `RANK() OVER (PARTITION BY ... ORDER BY ...)` |

Zapytania liczą m.in. spread kantoru, saldo opłat i marży, udział procentowy
kombinacji wymiarów w całkowitym obrocie oraz zmianę przychodu miesiąc do
miesiąca.

## Struktura repozytorium

```
DataBase/
├── 01-Baza/
│   ├── baza.sql            # DDL modelu OLTP (16 tabel)
│   ├── csv/                # dane testowe, 16 zbiorów
│   ├── ctl/                # pliki sterujące SQL*Loader
│   └── dane_baza.bat       # skrypt ładujący dane
├── 02-Hurtownia/
│   ├── hurtownia.sql       # DDL hurtowni (schemat gwiazdy)
│   └── dane_hurtownia.sql  # zasilenie hurtowni z modelu OLTP
└── 03-Zapytania/           # 15 zapytań analitycznych
```

## Uruchomienie

Wymagane: Oracle Database (testowane na `FREEPDB1`) oraz narzędzia klienckie
`sqlplus` i `sqlldr`.

```bash
# 1. utworzenie tabel modelu OLTP
sqlplus uzytkownik/haslo@FREEPDB1 @DataBase/01-Baza/baza.sql

# 2. zaladowanie danych testowych (Windows)
set ORA_USER=uzytkownik
set ORA_PASSWORD=haslo
cd DataBase\01-Baza
dane_baza.bat

# 3. utworzenie i zasilenie hurtowni
sqlplus uzytkownik/haslo@FREEPDB1 @DataBase/02-Hurtownia/hurtownia.sql
sqlplus uzytkownik/haslo@FREEPDB1 @DataBase/02-Hurtownia/dane_hurtownia.sql
```

Dane logowania pobierane są ze zmiennych środowiskowych — w repozytorium nie ma
żadnych haseł.

## Uwaga o danych

Wszystkie dane w katalogu `csv/` są **wygenerowane syntetycznie** na potrzeby
testów. Imiona, nazwiska, adresy, numery dokumentów i ciągi w formacie numeru
PESEL nie należą do żadnych rzeczywistych osób.
