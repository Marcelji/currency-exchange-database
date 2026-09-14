-- ROLLUP 1
-- Pokazuje łączną wartość transakcji i saldo opłat oraz marży w podziale hierarchicznym na państwo klienta i województwo klienta.
SELECT
  NVL(p.panstwo, 'Wszystkie panstwa') AS panstwo_klienta,
  NVL(w.wojewodztwo, 'Wszystkie wojewodztwa') AS wojewodztwo_klienta,
  sub.suma_kwoty_zrodlowej,
  sub.suma_kwoty_docelowej,
  sub.suma_salda_oplat_i_marzy
FROM (
  SELECT
    wo.id_panstwa AS id_panstwa,
    wo.id_wojew AS id_wojew,
    SUM(tr.kwota_waluty_zrodlowej) AS suma_kwoty_zrodlowej,
    SUM(tr.kwota_waluty_docelowej) AS suma_kwoty_docelowej,
    SUM(tr.prowizja_kwotowa + tr.oplata_dodatkowa + tr.oplata_stala + tr.marza_kwotowa - tr.rabat_kwotowy) AS suma_salda_oplat_i_marzy
  FROM p_16_transakcja_wymiany tr
  JOIN p_16_klient kl ON tr.id_klienta = kl.id_klienta
  JOIN p_16_ulica ul ON kl.id_ulicy = ul.id_ulicy
  JOIN p_16_miasto mi ON ul.d_miasta = mi.id_miasta
  JOIN p_16_wojewodztwo wo ON mi.id_wojew = wo.id_wojew
  GROUP BY ROLLUP(wo.id_panstwa, wo.id_wojew)
) sub
LEFT JOIN p_16_panstwo p ON sub.id_panstwa = p.id_panstwa
LEFT JOIN p_16_wojewodztwo w ON sub.id_wojew = w.id_wojew
ORDER BY panstwo_klienta, wojewodztwo_klienta;

--Hurtownia
SELECT
  NVL(p.panstwo, 'Wszystkie panstwa') AS panstwo_klienta,
  NVL(w.wojewodztwo, 'Wszystkie wojewodztwa') AS wojewodztwo_klienta,
  a.suma_kwoty_zrodlowej,
  a.suma_kwoty_docelowej,
  a.suma_salda_oplat_i_marzy
FROM (
  SELECT
    x.id_panstwa,
    x.id_wojew,
    x.suma_kwoty_zrodlowej,
    x.suma_kwoty_docelowej,
    x.suma_salda_oplat_i_marzy
  FROM (
    SELECT
      tr.id_panstwa,
      tr.id_wojew,
      SUM(tr.kwota_waluty_zrodlowej) AS suma_kwoty_zrodlowej,
      SUM(tr.kwota_waluty_docelowej) AS suma_kwoty_docelowej,
      SUM(tr.saldo_oplat_i_marzy) AS suma_salda_oplat_i_marzy
    FROM H_P_16_TRANSAKCJA_WYMIANY tr
    GROUP BY ROLLUP(tr.id_panstwa, tr.id_wojew)
  ) x
) a
LEFT JOIN H_P_16_PANSTWO p ON a.id_panstwa = p.id_panstwa
LEFT JOIN H_P_16_WOJEWODZTWO w ON a.id_wojew = w.id_wojew
ORDER BY panstwo_klienta, wojewodztwo_klienta;
