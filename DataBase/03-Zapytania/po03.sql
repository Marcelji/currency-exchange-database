-- PARTYCJA 3
-- Pokazuje średni spread oraz średni spread w mieście Działa w podziale na miasto klienta i metodę płatności  pozwala sprawdzić, które metody płatności mają spread wyższy lub niższy od średniej w danym mieście klientów.
SELECT
  m.miasto AS miasto_klienta,
  mp.metoda AS metoda_platnosci,
  a.sredni_spread,
  a.sredni_spread_w_miescie,
  a.odchylenie_od_sredniej
FROM (
  SELECT
    x.id_miasta,
    x.id_metody_plat,
    x.sredni_spread,
    ROUND(AVG(x.sredni_spread) OVER (PARTITION BY x.id_miasta), 6) AS sredni_spread_w_miescie,
    ROUND(x.sredni_spread - AVG(x.sredni_spread) OVER (PARTITION BY x.id_miasta), 6) AS odchylenie_od_sredniej
  FROM (
    SELECT
      mi.id_miasta,
      tr.id_metody_plat,
      tk.id_zrodla,
      ROUND(AVG(tr.kurs_sprzedazy - tr.kurs_kupna), 6) AS sredni_spread
    FROM p_16_transakcja_wymiany tr
    JOIN p_16_klient kl ON tr.id_klienta = kl.id_klienta
    JOIN p_16_ulica ul ON kl.id_ulicy = ul.id_ulicy
    JOIN p_16_miasto mi ON ul.d_miasta = mi.id_miasta
    JOIN p_16_tabela_kursowa tk ON tr.id_kursu = tk.id_kursu
    GROUP BY mi.id_miasta, tr.id_metody_plat, tk.id_zrodla
  ) x
) a
LEFT JOIN p_16_miasto m ON a.id_miasta = m.id_miasta
LEFT JOIN p_16_metoda_platnosci mp ON a.id_metody_plat = mp.id_metody_plat
ORDER BY m.miasto, mp.metoda;

--Hurtownia

SELECT
  m.miasto AS miasto_klienta,
  mp.metoda AS metoda_platnosci,
  a.sredni_spread,
  a.sredni_spread_w_miescie,
  a.odchylenie_od_sredniej
FROM (
  SELECT
    x.id_miasta,
    x.id_metody_plat,
    x.sredni_spread,
    ROUND(AVG(x.sredni_spread) OVER (PARTITION BY x.id_miasta), 6) AS sredni_spread_w_miescie,
    ROUND(x.sredni_spread - AVG(x.sredni_spread) OVER (PARTITION BY x.id_miasta), 6) AS odchylenie_od_sredniej
  FROM (
    SELECT
      id_miasta,
      id_metody_plat,
      id_zrodla,
      ROUND(AVG(spread), 6) AS sredni_spread
    FROM H_P_16_TRANSAKCJA_WYMIANY
    GROUP BY id_miasta, id_metody_plat, id_zrodla
  ) x
) a
LEFT JOIN H_P_16_MIASTO m ON a.id_miasta = m.id_miasta
LEFT JOIN H_P_16_METODA_PLATNOSCI mp ON a.id_metody_plat = mp.id_metody_plat
ORDER BY m.miasto, mp.metoda;