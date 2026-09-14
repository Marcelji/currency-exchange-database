-- CUBE 1
-- Pokazuje łączną wartość rabatów i średni rabat procentowy we wszystkich kombinacjach miasta klienta, źródła kursu i metody płatności.
SELECT
  NVL(m.miasto, 'Wszystkie miasta') AS miasto_klienta,
  NVL(z.nazwa_zrodla, 'Wszystkie zrodla kursu') AS zrodlo_kursu,
  NVL(mp.metoda, 'Wszystkie metody') AS metoda_platnosci,
  sub.suma_rabatow_kwotowych,
  sub.sredni_rabat_procentowy
FROM (
  SELECT
    mi.id_miasta AS miasto_id,
    tk.id_zrodla AS zrodlo_id,
    tr.id_metody_plat AS metoda_id,
    SUM(tr.rabat_kwotowy) AS suma_rabatow_kwotowych,
    ROUND(AVG(tr.rabat_procentowy), 2) AS sredni_rabat_procentowy
  FROM p_16_transakcja_wymiany tr
  JOIN p_16_klient kl ON tr.id_klienta = kl.id_klienta
  JOIN p_16_ulica ul ON kl.id_ulicy = ul.id_ulicy
  JOIN p_16_miasto mi ON ul.d_miasta = mi.id_miasta
  JOIN p_16_tabela_kursowa tk ON tr.id_kursu = tk.id_kursu
  GROUP BY CUBE(mi.id_miasta, tk.id_zrodla, tr.id_metody_plat)
) sub
LEFT JOIN p_16_miasto m ON sub.miasto_id = m.id_miasta
LEFT JOIN p_16_zrodlo_kursu z ON sub.zrodlo_id = z.id_zrodla
LEFT JOIN p_16_metoda_platnosci mp ON sub.metoda_id = mp.id_metody_plat
ORDER BY miasto_klienta, zrodlo_kursu, metoda_platnosci;

--Hurtownia

SELECT
  NVL(m.miasto, 'Wszystkie miasta') AS miasto_klienta,
  NVL(z.nazwa_zrodla, 'Wszystkie zrodla kursu') AS zrodlo_kursu,
  NVL(mp.metoda, 'Wszystkie metody') AS metoda_platnosci,
  sub.suma_rabatow_kwotowych,
  sub.sredni_rabat_procentowy
FROM (
  SELECT
    id_miasta,
    id_zrodla,
    id_metody_plat,
    SUM(rabat_kwotowy) AS suma_rabatow_kwotowych,
    ROUND(AVG(rabat_procentowy), 2) AS sredni_rabat_procentowy
  FROM H_P_16_TRANSAKCJA_WYMIANY
  GROUP BY CUBE(id_miasta, id_zrodla, id_metody_plat)
) sub
LEFT JOIN H_P_16_MIASTO m ON sub.id_miasta = m.id_miasta
LEFT JOIN H_P_16_ZRODLO_KURSU z ON sub.id_zrodla = z.id_zrodla
LEFT JOIN H_P_16_METODA_PLATNOSCI mp ON sub.id_metody_plat = mp.id_metody_plat
ORDER BY miasto_klienta, zrodlo_kursu, metoda_platnosci;
