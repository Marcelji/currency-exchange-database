-- OKNO 1
-- Pokazuje miesięczny przychód kantoru i przychód narastająco w podziale na typ punktu i walutę źródłową.
SELECT
    t.typ_oddzialu AS typ_punktu,
    w.kod_waluty AS waluta_zrodlowa,
    analiza.miesiac,
    analiza.przychod_w_miesiacu,
    analiza.skumulowany_przychod
FROM (
    SELECT
        zm.id_typoddzialu,
        zm.id_walutyzrodlowej,
        zm.miesiac,
        zm.przychod_w_miesiacu,
        SUM(zm.przychod_w_miesiacu) OVER (
            PARTITION BY zm.id_typoddzialu, zm.id_walutyzrodlowej
            ORDER BY zm.miesiac
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS skumulowany_przychod
    FROM (
        SELECT
            od.id_typoddzialu,
            tr.id_walutyzrodlowej,
            TO_CHAR(tr.data_transakcji, 'YYYY-MM') AS miesiac,
            SUM(tr.prowizja_kwotowa + tr.oplata_dodatkowa + tr.oplata_stala + tr.marza_kwotowa) AS przychod_w_miesiacu
        FROM p_16_transakcja_wymiany tr
        JOIN p_16_pracownik pr ON tr.id_pracownika = pr.id_pracownika
        JOIN p_16_oddzial_kantoru od ON pr.id_odzialu = od.id_odzialu
        GROUP BY od.id_typoddzialu, tr.id_walutyzrodlowej, TO_CHAR(tr.data_transakcji, 'YYYY-MM')
    ) zm
) analiza
LEFT JOIN p_16_typ_oddzialu t ON analiza.id_typoddzialu = t.id_typoddzialu
LEFT JOIN p_16_waluta w ON analiza.id_walutyzrodlowej = w.id_waluty
ORDER BY t.typ_oddzialu, analiza.miesiac;


--Hurtownia

SELECT
    t.typ_oddzialu AS typ_punktu,
    w.kod_waluty AS waluta_zrodlowa,
    ms.id_miesiaca AS miesiac,
    a.przychod_w_miesiacu,
    a.skumulowany_przychod
FROM (
    SELECT
        x.id_typoddzialu,
        x.id_walutyzrodlowej,
        x.id_miesiaca,
        x.przychod_w_miesiacu,
        SUM(x.przychod_w_miesiacu) OVER (
            PARTITION BY x.id_typoddzialu, x.id_walutyzrodlowej
            ORDER BY x.id_miesiaca
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS skumulowany_przychod
    FROM (
        SELECT
            id_typoddzialu,
            id_walutyzrodlowej,
            id_miesiaca,
            SUM(przychod) AS przychod_w_miesiacu
        FROM H_P_16_TRANSAKCJA_WYMIANY
        GROUP BY id_typoddzialu, id_walutyzrodlowej, id_miesiaca
    ) x
) a
LEFT JOIN H_P_16_TYP_ODDZIALU t ON a.id_typoddzialu = t.id_typoddzialu
LEFT JOIN H_P_16_WALUTA w ON a.id_walutyzrodlowej = w.id_waluty
LEFT JOIN H_P_16_MIESIAC ms ON a.id_miesiaca = ms.id_miesiaca
ORDER BY typ_punktu, ms.id_miesiaca;