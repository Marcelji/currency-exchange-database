-- RANKING 3
--pozwala sprawdzić, przy jakich źródłach kursu i metodach płatności kantor osiąga najwyższy spread w podziale na: metodę płatności i źródło kursu.
SELECT
    mp.metoda AS metoda_platnosci,
    z.nazwa_zrodla AS zrodlo_kursu,
    r.sredni_spread,
    r.pozycja_w_rankingu
FROM (
    SELECT
        y.id_metody_plat,
        y.id_zrodla,
        y.sredni_spread,
        RANK() OVER (
            PARTITION BY y.id_metody_plat
            ORDER BY y.sredni_spread DESC
        ) AS pozycja_w_rankingu
    FROM (
        SELECT
            x.id_metody_plat,
            x.id_zrodla,
            ROUND(AVG(x.sredni_spread), 6) AS sredni_spread
        FROM (
            SELECT
                tr.id_metody_plat,
                tk.id_zrodla,
                mi.id_miasta,
                ROUND(AVG(tr.kurs_sprzedazy - tr.kurs_kupna), 6) AS sredni_spread
            FROM p_16_transakcja_wymiany tr
            JOIN p_16_klient kl ON tr.id_klienta = kl.id_klienta
            JOIN p_16_ulica ul ON kl.id_ulicy = ul.id_ulicy
            JOIN p_16_miasto mi ON ul.d_miasta = mi.id_miasta
            JOIN p_16_tabela_kursowa tk ON tr.id_kursu = tk.id_kursu
            GROUP BY tr.id_metody_plat, tk.id_zrodla, mi.id_miasta
        ) x
        GROUP BY x.id_metody_plat, x.id_zrodla
    ) y
) r
LEFT JOIN p_16_metoda_platnosci mp ON r.id_metody_plat = mp.id_metody_plat
LEFT JOIN p_16_zrodlo_kursu z ON r.id_zrodla = z.id_zrodla
ORDER BY mp.metoda, r.pozycja_w_rankingu, z.nazwa_zrodla;

--Hurtownia

SELECT
    mp.metoda AS metoda_platnosci,
    z.nazwa_zrodla AS zrodlo_kursu,
    r.sredni_spread,
    r.pozycja_w_rankingu
FROM (
    SELECT
        x.id_metody_plat,
        x.id_zrodla,
        x.sredni_spread,
        RANK() OVER (
            PARTITION BY x.id_metody_plat
            ORDER BY x.sredni_spread DESC
        ) AS pozycja_w_rankingu
    FROM (
        SELECT
            id_metody_plat,
            id_zrodla,
            ROUND(AVG(spread), 6) AS sredni_spread
        FROM H_P_16_TRANSAKCJA_WYMIANY
        GROUP BY id_metody_plat, id_zrodla
    ) x
) r
LEFT JOIN H_P_16_METODA_PLATNOSCI mp ON r.id_metody_plat = mp.id_metody_plat
LEFT JOIN H_P_16_ZRODLO_KURSU z ON r.id_zrodla = z.id_zrodla
ORDER BY mp.metoda, r.pozycja_w_rankingu, z.nazwa_zrodla;