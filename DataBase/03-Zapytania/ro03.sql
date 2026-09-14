-- ROLLUP 3
-- Pokazuje łączną wartość rabatów i marży w podziale hierarchicznym na walutę źródłową, typ oddziału i źródło kursu.
SELECT
  NVL(wal.kod_waluty, 'Wszystkie waluty') AS waluta_zrodlowa,
  NVL(typoddz.typ_oddzialu, 'Wszystkie typy oddzialow') AS typ_oddzialu,
  NVL(zr.nazwa_zrodla, 'Wszystkie zrodla kursu') AS zrodlo_kursu,
  sub.suma_rabatow_kwotowych,
  sub.suma_marzy_kwotowej
FROM (
  SELECT
    tr.id_walutyzrodlowej AS waluta_id,
    od.id_typoddzialu AS typ_oddzialu_id,
    tk.id_zrodla AS zrodlo_id,
    SUM(tr.rabat_kwotowy) AS suma_rabatow_kwotowych,
    SUM(tr.marza_kwotowa) AS suma_marzy_kwotowej
  FROM p_16_transakcja_wymiany tr
  JOIN p_16_pracownik pr ON tr.id_pracownika = pr.id_pracownika
  JOIN p_16_oddzial_kantoru od ON pr.id_odzialu = od.id_odzialu
  JOIN p_16_tabela_kursowa tk ON tr.id_kursu = tk.id_kursu
  GROUP BY ROLLUP(tr.id_walutyzrodlowej, od.id_typoddzialu, tk.id_zrodla)
) sub
LEFT JOIN p_16_waluta wal ON sub.waluta_id = wal.id_waluty
LEFT JOIN p_16_typ_oddzialu typoddz ON sub.typ_oddzialu_id = typoddz.id_typoddzialu
LEFT JOIN p_16_zrodlo_kursu zr ON sub.zrodlo_id = zr.id_zrodla
ORDER BY waluta_zrodlowa, typ_oddzialu, zrodlo_kursu;

--Hurtownia

SELECT
  NVL(w.kod_waluty, 'Wszystkie waluty') AS waluta_zrodlowa,
  NVL(t.typ_oddzialu, 'Wszystkie typy oddzialow') AS typ_oddzialu,
  NVL(z.nazwa_zrodla, 'Wszystkie zrodla kursu') AS zrodlo_kursu,
  a.suma_rabatow_kwotowych,
  a.suma_marzy_kwotowej
FROM (
  SELECT
    x.id_walutyzrodlowej,
    x.id_typoddzialu,
    x.id_zrodla,
    x.suma_rabatow_kwotowych,
    x.suma_marzy_kwotowej
  FROM (
    SELECT
      tr.id_walutyzrodlowej,
      tr.id_typoddzialu,
      tr.id_zrodla,
      SUM(tr.rabat_kwotowy) AS suma_rabatow_kwotowych,
      SUM(tr.marza_kwotowa) AS suma_marzy_kwotowej
    FROM H_P_16_TRANSAKCJA_WYMIANY tr
    GROUP BY ROLLUP(tr.id_walutyzrodlowej, tr.id_typoddzialu, tr.id_zrodla)
  ) x
) a
LEFT JOIN H_P_16_WALUTA w ON a.id_walutyzrodlowej = w.id_waluty
LEFT JOIN H_P_16_TYP_ODDZIALU t ON a.id_typoddzialu = t.id_typoddzialu
LEFT JOIN H_P_16_ZRODLO_KURSU z ON a.id_zrodla = z.id_zrodla
ORDER BY waluta_zrodlowa, typ_oddzialu, zrodlo_kursu;

