-- ROLLUP 2
-- Pokazuje obrót po przewalutowaniu i sumę opłat w podziale hierarchicznym na województwo klienta, typ oddziału i metodę płatności.
SELECT
  NVL(woj.wojewodztwo, 'Wszystkie wojewodztwa') AS wojewodztwo_klienta,
  NVL(typoddz.typ_oddzialu, 'Wszystkie typy oddzialow') AS typ_oddzialu,
  NVL(metoda.metoda, 'Wszystkie metody') AS metoda_platnosci,
  sub.suma_kwoty_docelowej,
  sub.suma_oplat
FROM (
  SELECT
    mi.id_wojew AS woj_id,
    od.id_typoddzialu AS typ_oddzialu_id,
    tr.id_metody_plat AS metoda_id,
    SUM(tr.kwota_waluty_docelowej) AS suma_kwoty_docelowej,
    SUM(tr.prowizja_kwotowa + tr.oplata_dodatkowa + tr.oplata_stala) AS suma_oplat
  FROM p_16_transakcja_wymiany tr
  JOIN p_16_klient kl ON tr.id_klienta = kl.id_klienta
  JOIN p_16_ulica ul ON kl.id_ulicy = ul.id_ulicy
  JOIN p_16_miasto mi ON ul.d_miasta = mi.id_miasta
  JOIN p_16_pracownik pr ON tr.id_pracownika = pr.id_pracownika
  JOIN p_16_oddzial_kantoru od ON pr.id_odzialu = od.id_odzialu
  GROUP BY ROLLUP(mi.id_wojew, od.id_typoddzialu, tr.id_metody_plat)
) sub
LEFT JOIN p_16_wojewodztwo woj ON sub.woj_id = woj.id_wojew
LEFT JOIN p_16_typ_oddzialu typoddz ON sub.typ_oddzialu_id = typoddz.id_typoddzialu
LEFT JOIN p_16_metoda_platnosci metoda ON sub.metoda_id = metoda.id_metody_plat
ORDER BY wojewodztwo_klienta, typ_oddzialu, metoda_platnosci;

--Hurtownia

SELECT
  NVL(w.wojewodztwo, 'Wszystkie wojewodztwa') AS wojewodztwo_klienta,
  NVL(t.typ_oddzialu, 'Wszystkie typy oddzialow') AS typ_oddzialu,
  NVL(m.metoda, 'Wszystkie metody') AS metoda_platnosci,
  a.suma_kwoty_docelowej,
  a.suma_oplat
FROM (
  SELECT
    x.id_wojew,
    x.id_typoddzialu,
    x.id_metody_plat,
    x.suma_kwoty_docelowej,
    x.suma_oplat
  FROM (
    SELECT
      tr.id_wojew,
      tr.id_typoddzialu,
      tr.id_metody_plat,
      SUM(tr.kwota_waluty_docelowej) AS suma_kwoty_docelowej,
      SUM(tr.suma_oplat) AS suma_oplat
    FROM H_P_16_TRANSAKCJA_WYMIANY tr
    GROUP BY ROLLUP(tr.id_wojew, tr.id_typoddzialu, tr.id_metody_plat)
  ) x
) a
LEFT JOIN H_P_16_WOJEWODZTWO w ON a.id_wojew = w.id_wojew
LEFT JOIN H_P_16_TYP_ODDZIALU t ON a.id_typoddzialu = t.id_typoddzialu
LEFT JOIN H_P_16_METODA_PLATNOSCI m ON a.id_metody_plat = m.id_metody_plat
ORDER BY wojewodztwo_klienta, typ_oddzialu, metoda_platnosci;
