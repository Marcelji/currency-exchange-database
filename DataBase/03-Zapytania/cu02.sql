-- CUBE 2
-- Pokazuje łączną kwotę po przewalutowaniu i saldo opłat oraz marży we wszystkich kombinacjach miasta klienta, typu punktu i źródła kursu.
SELECT
  NVL(m.miasto, 'Wszystkie miasta') AS miasto_klienta,
  NVL(t.typ_oddzialu, 'Wszystkie typy punktow') AS typ_punktu,
  NVL(z.nazwa_zrodla, 'Wszystkie zrodla kursu') AS zrodlo_kursu,
  sub.suma_kwoty_docelowej,
  sub.suma_salda_oplat_i_marzy
FROM (
  SELECT
    mi.id_miasta AS miasto_id,
    od.id_typoddzialu AS typ_id,
    tk.id_zrodla AS zrodlo_id,
    SUM(tr.kwota_waluty_docelowej) AS suma_kwoty_docelowej,
    SUM(tr.prowizja_kwotowa + tr.oplata_dodatkowa + tr.oplata_stala + tr.marza_kwotowa - tr.rabat_kwotowy) AS suma_salda_oplat_i_marzy
  FROM p_16_transakcja_wymiany tr
  JOIN p_16_klient kl ON tr.id_klienta = kl.id_klienta
  JOIN p_16_ulica ul ON kl.id_ulicy = ul.id_ulicy
  JOIN p_16_miasto mi ON ul.d_miasta = mi.id_miasta
  JOIN p_16_pracownik pr ON tr.id_pracownika = pr.id_pracownika
  JOIN p_16_oddzial_kantoru od ON pr.id_odzialu = od.id_odzialu
  JOIN p_16_tabela_kursowa tk ON tr.id_kursu = tk.id_kursu
  GROUP BY CUBE(mi.id_miasta, od.id_typoddzialu, tk.id_zrodla)
) sub
LEFT JOIN p_16_miasto m ON sub.miasto_id = m.id_miasta
LEFT JOIN p_16_typ_oddzialu t ON sub.typ_id = t.id_typoddzialu
LEFT JOIN p_16_zrodlo_kursu z ON sub.zrodlo_id = z.id_zrodla
ORDER BY miasto_klienta, typ_punktu, zrodlo_kursu;

--Hurtownia

SELECT
  NVL(m.miasto, 'Wszystkie miasta') AS miasto_klienta,
  NVL(t.typ_oddzialu, 'Wszystkie typy punktow') AS typ_punktu,
  NVL(z.nazwa_zrodla, 'Wszystkie zrodla kursu') AS zrodlo_kursu,
  sub.suma_kwoty_docelowej,
  sub.suma_salda_oplat_i_marzy
FROM (
  SELECT
    id_miasta,
    id_typoddzialu,
    id_zrodla,
    SUM(kwota_waluty_docelowej) AS suma_kwoty_docelowej,
    SUM(saldo_oplat_i_marzy) AS suma_salda_oplat_i_marzy
  FROM H_P_16_TRANSAKCJA_WYMIANY
  GROUP BY CUBE(id_miasta, id_typoddzialu, id_zrodla)
) sub
LEFT JOIN H_P_16_MIASTO m ON sub.id_miasta = m.id_miasta
LEFT JOIN H_P_16_TYP_ODDZIALU t ON sub.id_typoddzialu = t.id_typoddzialu
LEFT JOIN H_P_16_ZRODLO_KURSU z ON sub.id_zrodla = z.id_zrodla
ORDER BY miasto_klienta, typ_punktu, zrodlo_kursu;

