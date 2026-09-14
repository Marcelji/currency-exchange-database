-- OKNO 2: Pokazuje średni spread w miesiącu, spread z poprzedniego miesiąca i jego zmianę w podziale na źródło kursu i metodę płatności.


SELECT
    z.nazwa_zrodla AS zrodlo_kursu,
    mp.metoda AS metoda_platnosci,
    analiza.miesiac,
    analiza.sredni_spread,
    analiza.spread_poprzednio,
    analiza.zmiana_spreadu
FROM (
    SELECT
        zm.id_zrodla,
        zm.id_metody_plat,
        zm.miesiac,
        zm.sredni_spread,
        LAG(zm.sredni_spread, 1, zm.sredni_spread) OVER (
            PARTITION BY zm.id_zrodla, zm.id_metody_plat
            ORDER BY zm.miesiac
        ) AS spread_poprzednio,
        zm.sredni_spread - LAG(zm.sredni_spread, 1, zm.sredni_spread) OVER (
            PARTITION BY zm.id_zrodla, zm.id_metody_plat
            ORDER BY zm.miesiac
        ) AS zmiana_spreadu
    FROM (
        SELECT
            tk.id_zrodla,
            tr.id_metody_plat,
            TO_CHAR(tr.data_transakcji, 'YYYY-MM') AS miesiac,
            ROUND(AVG(tr.kurs_sprzedazy - tr.kurs_kupna), 6) AS sredni_spread
        FROM p_16_transakcja_wymiany tr
        JOIN p_16_tabela_kursowa tk ON tr.id_kursu = tk.id_kursu
        GROUP BY tk.id_zrodla, tr.id_metody_plat, TO_CHAR(tr.data_transakcji, 'YYYY-MM')
    ) zm
) analiza
LEFT JOIN p_16_zrodlo_kursu z ON analiza.id_zrodla = z.id_zrodla
LEFT JOIN p_16_metoda_platnosci mp ON analiza.id_metody_plat = mp.id_metody_plat
ORDER BY z.nazwa_zrodla, mp.metoda, analiza.miesiac;


--Hurtownia

SELECT
    z.nazwa_zrodla AS zrodlo_kursu,
    m.metoda AS metoda_platnosci,
    ms.id_miesiaca AS miesiac,
    a.sredni_spread,
    a.spread_poprzednio,
    a.zmiana_spreadu
FROM (
    SELECT
        x.id_zrodla,
        x.id_metody_plat,
        x.id_miesiaca,
        x.sredni_spread,
        LAG(x.sredni_spread, 1, x.sredni_spread) OVER (
            PARTITION BY x.id_zrodla, x.id_metody_plat
            ORDER BY x.id_miesiaca
        ) AS spread_poprzednio,
        x.sredni_spread - LAG(x.sredni_spread, 1, x.sredni_spread) OVER (
            PARTITION BY x.id_zrodla, x.id_metody_plat
            ORDER BY x.id_miesiaca
        ) AS zmiana_spreadu
    FROM (
        SELECT
            id_zrodla,
            id_metody_plat,
            id_miesiaca,
            ROUND(AVG(spread), 6) AS sredni_spread
        FROM H_P_16_TRANSAKCJA_WYMIANY
        GROUP BY id_zrodla, id_metody_plat, id_miesiaca
    ) x
) a
LEFT JOIN H_P_16_ZRODLO_KURSU z ON a.id_zrodla = z.id_zrodla
LEFT JOIN H_P_16_METODA_PLATNOSCI m ON a.id_metody_plat = m.id_metody_plat
LEFT JOIN H_P_16_MIESIAC ms ON a.id_miesiaca = ms.id_miesiaca
ORDER BY zrodlo_kursu, metoda_platnosci, ms.id_miesiaca;

