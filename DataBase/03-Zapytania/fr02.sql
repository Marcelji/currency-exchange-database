-- RANKING 2: Pokazuje ranking miast klientów według salda opłat i marży osobno dla każdego typu punktu.
SELECT
    t.typ_oddzialu AS typ_punktu,
    m.miasto AS miasto_klienta,
    r.saldo_oplat_i_marzy,
    r.pozycja_w_rankingu
FROM (
    SELECT
        x.id_typoddzialu,
        x.id_miasta,
        x.saldo_oplat_i_marzy,
        RANK() OVER (
            PARTITION BY x.id_typoddzialu
            ORDER BY x.saldo_oplat_i_marzy DESC
        ) AS pozycja_w_rankingu
    FROM (
        SELECT
            od.id_typoddzialu,
            mi.id_miasta,
            SUM(tr.prowizja_kwotowa +tr.oplata_dodatkowa +tr.oplata_stala +tr.marza_kwotowa -tr.rabat_kwotowy) AS saldo_oplat_i_marzy
        FROM p_16_transakcja_wymiany tr
        JOIN p_16_klient kl ON tr.id_klienta = kl.id_klienta
        JOIN p_16_ulica ul ON kl.id_ulicy = ul.id_ulicy
        JOIN p_16_miasto mi ON ul.d_miasta = mi.id_miasta
        JOIN p_16_pracownik pr ON tr.id_pracownika = pr.id_pracownika
        JOIN p_16_oddzial_kantoru od ON pr.id_odzialu = od.id_odzialu
        GROUP BY od.id_typoddzialu, mi.id_miasta
    ) x
) r
LEFT JOIN p_16_typ_oddzialu t ON r.id_typoddzialu = t.id_typoddzialu
LEFT JOIN p_16_miasto m ON r.id_miasta = m.id_miasta
ORDER BY t.typ_oddzialu, r.pozycja_w_rankingu, m.miasto;

--Hurtownia

SELECT
    t.typ_oddzialu AS typ_punktu,
    m.miasto AS miasto_klienta,
    r.saldo_oplat_i_marzy,
    r.pozycja_w_rankingu
FROM (
    SELECT
        x.id_typoddzialu,
        x.id_miasta,
        x.saldo_oplat_i_marzy,
        RANK() OVER (
            PARTITION BY x.id_typoddzialu
            ORDER BY x.saldo_oplat_i_marzy DESC
        ) AS pozycja_w_rankingu
    FROM (
        SELECT
            id_typoddzialu,
            id_miasta,
            SUM(saldo_oplat_i_marzy) AS saldo_oplat_i_marzy
        FROM H_P_16_TRANSAKCJA_WYMIANY
        GROUP BY id_typoddzialu, id_miasta
    ) x
) r
LEFT JOIN H_P_16_TYP_ODDZIALU t ON r.id_typoddzialu = t.id_typoddzialu
LEFT JOIN H_P_16_MIASTO m ON r.id_miasta = m.id_miasta
ORDER BY t.typ_oddzialu, r.pozycja_w_rankingu, m.miasto;
