-- RANKING 1: Pokazuje ranking walut źródłowych według łącznego obrotu w walucie źródłowej wraz ze średnią marżą kwotową.
SELECT
    r.pozycja_w_rankingu,
    w.kod_waluty AS waluta_zrodlowa,
    r.suma_kwoty_zrodlowej,
    r.srednia_marza_kwotowa
FROM (
    SELECT
        x.id_walutyzrodlowej,
        x.suma_kwoty_zrodlowej,
        x.srednia_marza_kwotowa,
        RANK() OVER (ORDER BY x.suma_kwoty_zrodlowej DESC) AS pozycja_w_rankingu
    FROM (
        SELECT
            tr.id_walutyzrodlowej,
            SUM(tr.kwota_waluty_zrodlowej) AS suma_kwoty_zrodlowej,
            ROUND(AVG(tr.marza_kwotowa), 2) AS srednia_marza_kwotowa
        FROM p_16_transakcja_wymiany tr
        GROUP BY tr.id_walutyzrodlowej
    ) x
) r
LEFT JOIN p_16_waluta w ON r.id_walutyzrodlowej = w.id_waluty
ORDER BY r.pozycja_w_rankingu;

--Hurtownia

SELECT
    r.pozycja_w_rankingu,
    w.kod_waluty AS waluta_zrodlowa,
    r.suma_kwoty_zrodlowej,
    r.srednia_marza_kwotowa
FROM (
    SELECT
        x.id_walutyzrodlowej,
        x.suma_kwoty_zrodlowej,
        x.srednia_marza_kwotowa,
        RANK() OVER (ORDER BY x.suma_kwoty_zrodlowej DESC) AS pozycja_w_rankingu
    FROM (
        SELECT
            id_walutyzrodlowej,
            SUM(kwota_waluty_zrodlowej) AS suma_kwoty_zrodlowej,
            ROUND(AVG(marza_kwotowa), 2) AS srednia_marza_kwotowa
        FROM H_P_16_TRANSAKCJA_WYMIANY
        GROUP BY id_walutyzrodlowej
    ) x
) r
LEFT JOIN H_P_16_WALUTA w ON r.id_walutyzrodlowej = w.id_waluty
ORDER BY r.pozycja_w_rankingu;