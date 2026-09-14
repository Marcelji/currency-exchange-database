INSERT INTO H_P_16_PANSTWO (id_panstwa, panstwo)
SELECT
    'P' || LPAD(ROW_NUMBER() OVER (ORDER BY id_panstwa), 2, '0'),
    panstwo
FROM P_16_PANSTWO;

COMMIT;


INSERT INTO H_P_16_WOJEWODZTWO (id_wojew, wojewodztwo)
SELECT
    'W' || LPAD(ROW_NUMBER() OVER (ORDER BY id_wojew), 2, '0'),
    wojewodztwo
FROM P_16_WOJEWODZTWO;

COMMIT;


INSERT INTO H_P_16_MIASTO (id_miasta, miasto)
SELECT
    'M' || LPAD(ROW_NUMBER() OVER (ORDER BY id_miasta), 3, '0'),
    miasto
FROM P_16_MIASTO;

COMMIT;


INSERT INTO H_P_16_TYP_ODDZIALU (id_typoddzialu, typ_oddzialu)
SELECT
    'T' || ROW_NUMBER() OVER (ORDER BY id_typoddzialu),
    typ_oddzialu
FROM P_16_TYP_ODDZIALU;

COMMIT;


INSERT INTO H_P_16_ZRODLO_KURSU (id_zrodla, nazwa_zrodla)
SELECT
    'Z' || LPAD(ROW_NUMBER() OVER (ORDER BY id_zrodla), 2, '0'),
    nazwa_zrodla
FROM P_16_ZRODLO_KURSU;

COMMIT;


INSERT INTO H_P_16_WALUTA (id_waluty, kod_waluty)
SELECT
    'W' || LPAD(ROW_NUMBER() OVER (ORDER BY id_waluty), 2, '0'),
    kod_waluty
FROM P_16_WALUTA;

COMMIT;


INSERT INTO H_P_16_METODA_PLATNOSCI (id_metody_plat, metoda)
SELECT
    'M' || LPAD(ROW_NUMBER() OVER (ORDER BY id_metody_plat), 2, '0'),
    metoda
FROM P_16_METODA_PLATNOSCI;

COMMIT;


INSERT INTO H_P_16_ROK (id_rok, opis)
SELECT DISTINCT
    TO_CHAR(data_transakcji, 'YYYY'),
    'Rok ' || TO_CHAR(data_transakcji, 'YYYY')
FROM P_16_TRANSAKCJA_WYMIANY;

COMMIT;


INSERT INTO H_P_16_MIESIAC (id_miesiaca, opis)
SELECT DISTINCT
    TO_CHAR(data_transakcji, 'YYYY-MM'),
    TO_CHAR(data_transakcji, 'YYYY-MM')
FROM P_16_TRANSAKCJA_WYMIANY;

COMMIT;


INSERT INTO H_P_16_KLIENT (id_klienta, imie, nazwisko)
SELECT
    'K' || LPAD(ROW_NUMBER() OVER (ORDER BY id_klienta), 4, '0'),
    imie,
    nazwisko
FROM P_16_KLIENT;

COMMIT;


INSERT INTO H_P_16_PRACOWNIK (id_pracownika, imie, nazwisko)
SELECT
    'P' || LPAD(ROW_NUMBER() OVER (ORDER BY id_pracownika), 3, '0'),
    imie,
    nazwisko
FROM P_16_PRACOWNIK;

COMMIT;


INSERT INTO H_P_16_ODDZIAL_KANTORU (id_odzialu, nazwa_oddzialu)
SELECT
    'O' || LPAD(ROW_NUMBER() OVER (ORDER BY id_odzialu), 3, '0'),
    nazwa_oddzialu
FROM P_16_ODDZIAL_KANTORU;

COMMIT;


INSERT INTO H_P_16_TABELA_KURSOWA (id_kursu, nr_tabeli)
SELECT
    'K' || LPAD(ROW_NUMBER() OVER (ORDER BY id_kursu), 6, '0'),
    nr_tabeli
FROM P_16_TABELA_KURSOWA;

COMMIT;


INSERT INTO H_P_16_TRANSAKCJA_WYMIANY (
    id_klienta,
    id_pracownika,
    data_transakcji,
    id_panstwa,
    id_wojew,
    id_miasta,
    id_odzialu,
    id_typoddzialu,
    id_kursu,
    id_zrodla,
    id_walutyzrodlowej,
    id_metody_plat,
    id_rok,
    id_miesiaca,
    kwota_waluty_zrodlowej,
    kwota_waluty_docelowej,
    marza_kwotowa,
    rabat_kwotowy,
    rabat_procentowy,
    przychod,
    spread,
    saldo_oplat_i_marzy,
    suma_oplat
)
WITH
map_panstwo AS (
    SELECT
        id_panstwa AS src_id_panstwa,
        'P' || LPAD(ROW_NUMBER() OVER (ORDER BY id_panstwa), 2, '0') AS id_panstwa
    FROM P_16_PANSTWO
),
map_wojew AS (
    SELECT
        id_wojew AS src_id_wojew,
        'W' || LPAD(ROW_NUMBER() OVER (ORDER BY id_wojew), 2, '0') AS id_wojew
    FROM P_16_WOJEWODZTWO
),
map_miasto AS (
    SELECT
        id_miasta AS src_id_miasta,
        'M' || LPAD(ROW_NUMBER() OVER (ORDER BY id_miasta), 3, '0') AS id_miasta
    FROM P_16_MIASTO
),
map_typoddzialu AS (
    SELECT
        id_typoddzialu AS src_id_typoddzialu,
        'T' || ROW_NUMBER() OVER (ORDER BY id_typoddzialu) AS id_typoddzialu
    FROM P_16_TYP_ODDZIALU
),
map_zrodlo AS (
    SELECT
        id_zrodla AS src_id_zrodla,
        'Z' || LPAD(ROW_NUMBER() OVER (ORDER BY id_zrodla), 2, '0') AS id_zrodla
    FROM P_16_ZRODLO_KURSU
),
map_waluta AS (
    SELECT
        id_waluty AS src_id_waluty,
        'W' || LPAD(ROW_NUMBER() OVER (ORDER BY id_waluty), 2, '0') AS id_waluty
    FROM P_16_WALUTA
),
map_metoda AS (
    SELECT
        id_metody_plat AS src_id_metody_plat,
        'M' || LPAD(ROW_NUMBER() OVER (ORDER BY id_metody_plat), 2, '0') AS id_metody_plat
    FROM P_16_METODA_PLATNOSCI
),
map_klient AS (
    SELECT
        id_klienta AS src_id_klienta,
        'K' || LPAD(ROW_NUMBER() OVER (ORDER BY id_klienta), 4, '0') AS id_klienta
    FROM P_16_KLIENT
),
map_pracownik AS (
    SELECT
        id_pracownika AS src_id_pracownika,
        'P' || LPAD(ROW_NUMBER() OVER (ORDER BY id_pracownika), 3, '0') AS id_pracownika
    FROM P_16_PRACOWNIK
),
map_oddzial AS (
    SELECT
        id_odzialu AS src_id_odzialu,
        'O' || LPAD(ROW_NUMBER() OVER (ORDER BY id_odzialu), 3, '0') AS id_odzialu
    FROM P_16_ODDZIAL_KANTORU
),
map_kurs AS (
    SELECT
        id_kursu AS src_id_kursu,
        'K' || LPAD(ROW_NUMBER() OVER (ORDER BY id_kursu), 6, '0') AS id_kursu
    FROM P_16_TABELA_KURSOWA
)
SELECT
    mk.id_klienta,
    mp.id_pracownika,
    tr.data_transakcji,

    mpa.id_panstwa,
    mw.id_wojew,
    mm.id_miasta,
    mo.id_odzialu,
    mto.id_typoddzialu,
    mku.id_kursu,
    mz.id_zrodla,
    mwal.id_waluty AS id_walutyzrodlowej,
    mmet.id_metody_plat,
    TO_CHAR(tr.data_transakcji, 'YYYY') AS id_rok,
    TO_CHAR(tr.data_transakcji, 'YYYY-MM') AS id_miesiaca,

    tr.kwota_waluty_zrodlowej,
    tr.kwota_waluty_docelowej,
    tr.marza_kwotowa,
    tr.rabat_kwotowy,
    tr.rabat_procentowy,
    tr.prowizja_kwotowa + tr.oplata_dodatkowa + tr.oplata_stala + tr.marza_kwotowa AS przychod,
    tr.kurs_sprzedazy - tr.kurs_kupna AS spread,
    tr.prowizja_kwotowa + tr.oplata_dodatkowa + tr.oplata_stala + tr.marza_kwotowa - tr.rabat_kwotowy AS saldo_oplat_i_marzy,
    tr.prowizja_kwotowa + tr.oplata_dodatkowa + tr.oplata_stala AS suma_oplat
FROM P_16_TRANSAKCJA_WYMIANY tr
JOIN P_16_KLIENT k ON tr.id_klienta = k.id_klienta
JOIN P_16_ULICA u ON k.id_ulicy = u.id_ulicy
JOIN P_16_MIASTO mi ON u.d_miasta = mi.id_miasta
JOIN P_16_WOJEWODZTWO wo ON mi.id_wojew = wo.id_wojew
JOIN P_16_PANSTWO pa ON wo.id_panstwa = pa.id_panstwa
JOIN P_16_PRACOWNIK pr ON tr.id_pracownika = pr.id_pracownika
JOIN P_16_ODDZIAL_KANTORU od ON pr.id_odzialu = od.id_odzialu
JOIN P_16_TYP_ODDZIALU typ ON od.id_typoddzialu = typ.id_typoddzialu
JOIN P_16_TABELA_KURSOWA tk ON tr.id_kursu = tk.id_kursu
JOIN P_16_ZRODLO_KURSU zr ON tk.id_zrodla = zr.id_zrodla
JOIN map_klient mk ON tr.id_klienta = mk.src_id_klienta
JOIN map_pracownik mp ON tr.id_pracownika = mp.src_id_pracownika
JOIN map_panstwo mpa ON pa.id_panstwa = mpa.src_id_panstwa
JOIN map_wojew mw ON wo.id_wojew = mw.src_id_wojew
JOIN map_miasto mm ON mi.id_miasta = mm.src_id_miasta
JOIN map_oddzial mo ON od.id_odzialu = mo.src_id_odzialu
JOIN map_typoddzialu mto ON typ.id_typoddzialu = mto.src_id_typoddzialu
JOIN map_kurs mku ON tk.id_kursu = mku.src_id_kursu
JOIN map_zrodlo mz ON zr.id_zrodla = mz.src_id_zrodla
JOIN map_waluta mwal ON tr.id_walutyzrodlowej = mwal.src_id_waluty
JOIN map_metoda mmet ON tr.id_metody_plat = mmet.src_id_metody_plat;

COMMIT;