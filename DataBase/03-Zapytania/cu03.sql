-- CUBE 3
-- Pokazuje łączny obrót w walucie źródłowej i średnią marżę kwotową we wszystkich kombinacjach miasta klienta, typu punktu i waluty źródłowej.
SELECT
  NVL(m.miasto, 'Wszystkie miasta') AS miasto_klienta,
  NVL(t.typ_oddzialu, 'Wszystkie typy punktow') AS typ_punktu,
  NVL(w.kod_waluty, 'Wszystkie waluty') AS waluta_zrodlowa,
  sub.suma_kwoty_zrodlowej,
  sub.srednia_marza_kwotowa
FROM (
  SELECT
    mi.id_miasta AS miasto_id,
    od.id_typoddzialu AS typ_id,
    tr.id_walutyzrodlowej AS waluta_id,
    SUM(tr.kwota_waluty_zrodlowej) AS suma_kwoty_zrodlowej,
    ROUND(AVG(tr.marza_kwotowa), 2) AS srednia_marza_kwotowa
  FROM p_16_transakcja_wymiany tr
  JOIN p_16_klient kl ON tr.id_klienta = kl.id_klienta
  JOIN p_16_ulica ul ON kl.id_ulicy = ul.id_ulicy
  JOIN p_16_miasto mi ON ul.d_miasta = mi.id_miasta
  JOIN p_16_pracownik pr ON tr.id_pracownika = pr.id_pracownika
  JOIN p_16_oddzial_kantoru od ON pr.id_odzialu = od.id_odzialu
  GROUP BY CUBE(mi.id_miasta, od.id_typoddzialu, tr.id_walutyzrodlowej)
) sub
LEFT JOIN p_16_miasto m ON sub.miasto_id = m.id_miasta
LEFT JOIN p_16_typ_oddzialu t ON sub.typ_id = t.id_typoddzialu
LEFT JOIN p_16_waluta w ON sub.waluta_id = w.id_waluty
ORDER BY miasto_klienta, typ_punktu, waluta_zrodlowa;

--Hurtownia

SELECT
  NVL(m.miasto, 'Wszystkie miasta') AS miasto_klienta,
  NVL(t.typ_oddzialu, 'Wszystkie typy punktow') AS typ_punktu,
  NVL(w.kod_waluty, 'Wszystkie waluty') AS waluta_zrodlowa,
  sub.suma_kwoty_zrodlowej,
  sub.srednia_marza_kwotowa
FROM (
  SELECT
    id_miasta,
    id_typoddzialu,
    id_walutyzrodlowej,
    SUM(kwota_waluty_zrodlowej) AS suma_kwoty_zrodlowej,
    ROUND(AVG(marza_kwotowa), 2) AS srednia_marza_kwotowa
  FROM H_P_16_TRANSAKCJA_WYMIANY
  GROUP BY CUBE(id_miasta, id_typoddzialu, id_walutyzrodlowej)
) sub
LEFT JOIN H_P_16_MIASTO m ON sub.id_miasta = m.id_miasta
LEFT JOIN H_P_16_TYP_ODDZIALU t ON sub.id_typoddzialu = t.id_typoddzialu
LEFT JOIN H_P_16_WALUTA w ON sub.id_walutyzrodlowej = w.id_waluty
ORDER BY miasto_klienta, typ_punktu, waluta_zrodlowa;


