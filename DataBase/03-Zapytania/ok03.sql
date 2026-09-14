SELECT
    w.wojewodztwo AS wojewodztwo_klienta,
    z.nazwa_zrodla AS zrodlo_kursu,
    m.metoda AS metoda_platnosci,
    a.miesiac,
    a.obrot_w_miesiacu,
    a.obrot_narastajaco
FROM (
    SELECT
        x.id_wojew,
        x.id_zrodla,
        x.id_metody_plat,
        x.miesiac,
        x.obrot_w_miesiacu,
        SUM(x.obrot_w_miesiacu) OVER (
            PARTITION BY x.id_wojew, x.id_zrodla, x.id_metody_plat
            ORDER BY x.miesiac
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS obrot_narastajaco
    FROM (
        SELECT
            mi.id_wojew,
            tk.id_zrodla,
            tr.id_metody_plat,
            TO_CHAR(tr.data_transakcji, 'YYYY-MM') AS miesiac,
            SUM(tr.kwota_waluty_docelowej) AS obrot_w_miesiacu
        FROM p_16_transakcja_wymiany tr
        JOIN p_16_klient kl ON tr.id_klienta = kl.id_klienta
        JOIN p_16_ulica ul ON kl.id_ulicy = ul.id_ulicy
        JOIN p_16_miasto mi ON ul.d_miasta = mi.id_miasta
        JOIN p_16_tabela_kursowa tk ON tr.id_kursu = tk.id_kursu
        GROUP BY mi.id_wojew, tk.id_zrodla, tr.id_metody_plat, TO_CHAR(tr.data_transakcji, 'YYYY-MM')
    ) x
) a
LEFT JOIN p_16_wojewodztwo w ON a.id_wojew = w.id_wojew
LEFT JOIN p_16_zrodlo_kursu z ON a.id_zrodla = z.id_zrodla
LEFT JOIN p_16_metoda_platnosci m ON a.id_metody_plat = m.id_metody_plat
ORDER BY wojewodztwo_klienta, zrodlo_kursu, metoda_platnosci, a.miesiac;

--Hurtownia

SELECT
    w.wojewodztwo AS wojewodztwo_klienta,
    z.nazwa_zrodla AS zrodlo_kursu,
    m.metoda AS metoda_platnosci,
    ms.id_miesiaca AS miesiac,
    a.obrot_w_miesiacu,
    a.obrot_narastajaco
FROM (
    SELECT
        x.id_wojew,
        x.id_zrodla,
        x.id_metody_plat,
        x.id_miesiaca,
        x.obrot_w_miesiacu,
        SUM(x.obrot_w_miesiacu) OVER (
            PARTITION BY x.id_wojew, x.id_zrodla, x.id_metody_plat
            ORDER BY x.id_miesiaca
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS obrot_narastajaco
    FROM (
        SELECT
            id_wojew,
            id_zrodla,
            id_metody_plat,
            id_miesiaca,
            SUM(kwota_waluty_docelowej) AS obrot_w_miesiacu
        FROM H_P_16_TRANSAKCJA_WYMIANY
        GROUP BY id_wojew, id_zrodla, id_metody_plat, id_miesiaca
    ) x
) a
LEFT JOIN H_P_16_WOJEWODZTWO w ON a.id_wojew = w.id_wojew
LEFT JOIN H_P_16_ZRODLO_KURSU z ON a.id_zrodla = z.id_zrodla
LEFT JOIN H_P_16_METODA_PLATNOSCI m ON a.id_metody_plat = m.id_metody_plat
LEFT JOIN H_P_16_MIESIAC ms ON a.id_miesiaca = ms.id_miesiaca
ORDER BY wojewodztwo_klienta, zrodlo_kursu, metoda_platnosci, ms.id_miesiaca;
