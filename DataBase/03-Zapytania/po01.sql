-- PARTYCJA 1
-- Pokazuje  obrót w danej kombinacji oraz udział procentowy tej kombinacji w całym obrocie w podziale na: miasto klienta, typ punktu i walutę źródłową.
-- pozwala sprawdzić, które kombinacje miasta klienta, typu punktu i waluty mają największy udział w całym obrocie kantoru.
SELECT
  m.miasto AS miasto_klienta,
  t.typ_oddzialu AS typ_punktu,
  w.kod_waluty AS waluta_zrodlowa,
  a.obrot_w_kombinacji,
  a.obrot_calkowity,
  a.udzial_procentowy
FROM (
  SELECT
    x.id_miasta,
    x.id_typoddzialu,
    x.id_walutyzrodlowej,
    x.obrot_w_kombinacji,
    SUM(x.obrot_w_kombinacji) OVER () AS obrot_calkowity,
    ROUND(100 * x.obrot_w_kombinacji / SUM(x.obrot_w_kombinacji) OVER (), 2) AS udzial_procentowy
  FROM (
    SELECT
      mi.id_miasta,
      od.id_typoddzialu,
      tr.id_walutyzrodlowej,
      SUM(tr.kwota_waluty_zrodlowej) AS obrot_w_kombinacji
    FROM p_16_transakcja_wymiany tr
    JOIN p_16_klient kl ON tr.id_klienta = kl.id_klienta
    JOIN p_16_ulica ul ON kl.id_ulicy = ul.id_ulicy
    JOIN p_16_miasto mi ON ul.d_miasta = mi.id_miasta
    JOIN p_16_pracownik pr ON tr.id_pracownika = pr.id_pracownika
    JOIN p_16_oddzial_kantoru od ON pr.id_odzialu = od.id_odzialu
    GROUP BY mi.id_miasta, od.id_typoddzialu, tr.id_walutyzrodlowej
  ) x
) a
LEFT JOIN p_16_miasto m ON a.id_miasta = m.id_miasta
LEFT JOIN p_16_typ_oddzialu t ON a.id_typoddzialu = t.id_typoddzialu
LEFT JOIN p_16_waluta w ON a.id_walutyzrodlowej = w.id_waluty
ORDER BY a.udzial_procentowy DESC, m.miasto, t.typ_oddzialu, w.kod_waluty;

--Hurtownia

SELECT
  m.miasto AS miasto_klienta,
  t.typ_oddzialu AS typ_punktu,
  w.kod_waluty AS waluta_zrodlowa,
  a.obrot_w_kombinacji,
  a.obrot_calkowity,
  a.udzial_procentowy
FROM (
  SELECT
    x.id_miasta,
    x.id_typoddzialu,
    x.id_walutyzrodlowej,
    x.obrot_w_kombinacji,
    SUM(x.obrot_w_kombinacji) OVER () AS obrot_calkowity,
    ROUND(100 * x.obrot_w_kombinacji / SUM(x.obrot_w_kombinacji) OVER (), 2) AS udzial_procentowy
  FROM (
    SELECT
      id_miasta,
      id_typoddzialu,
      id_walutyzrodlowej,
      SUM(kwota_waluty_zrodlowej) AS obrot_w_kombinacji
    FROM H_P_16_TRANSAKCJA_WYMIANY
    GROUP BY id_miasta, id_typoddzialu, id_walutyzrodlowej
  ) x
) a
LEFT JOIN H_P_16_MIASTO m ON a.id_miasta = m.id_miasta
LEFT JOIN H_P_16_TYP_ODDZIALU t ON a.id_typoddzialu = t.id_typoddzialu
LEFT JOIN H_P_16_WALUTA w ON a.id_walutyzrodlowej = w.id_waluty
ORDER BY a.udzial_procentowy DESC, m.miasto, t.typ_oddzialu, w.kod_waluty;
