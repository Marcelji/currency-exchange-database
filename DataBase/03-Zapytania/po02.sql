-- PARTYCJA 2
-- Pokazuje saldo opłat i marży oraz średnią saldo w grupie w podziale na:źródło kursu, metodę płatności i typ punktu pozwala porównać wynik danej kombinacji źródła kursu, metody płatności i typu punktu do średniego wyniku w tej grupie.
SELECT
  z.nazwa_zrodla AS zrodlo_kursu,
  mp.metoda AS metoda_platnosci,
  t.typ_oddzialu AS typ_punktu,
  a.saldo_oplat_i_marzy,
  a.srednia_w_typie_punktu,
  a.odchylenie_od_sredniej
FROM (
  SELECT
    x.id_zrodla,
    x.id_metody_plat,
    x.id_typoddzialu,
    x.saldo_oplat_i_marzy,
    ROUND(AVG(x.saldo_oplat_i_marzy) OVER (PARTITION BY x.id_typoddzialu), 2) AS srednia_w_typie_punktu,
    ROUND(x.saldo_oplat_i_marzy - AVG(x.saldo_oplat_i_marzy) OVER (PARTITION BY x.id_typoddzialu), 2) AS odchylenie_od_sredniej
  FROM (
    SELECT
      tk.id_zrodla,
      tr.id_metody_plat,
      od.id_typoddzialu,
      SUM(
        tr.prowizja_kwotowa +
        tr.oplata_dodatkowa +
        tr.oplata_stala +
        tr.marza_kwotowa -
        tr.rabat_kwotowy
      ) AS saldo_oplat_i_marzy
    FROM p_16_transakcja_wymiany tr
    JOIN p_16_tabela_kursowa tk ON tr.id_kursu = tk.id_kursu
    JOIN p_16_pracownik pr ON tr.id_pracownika = pr.id_pracownika
    JOIN p_16_oddzial_kantoru od ON pr.id_odzialu = od.id_odzialu
    GROUP BY tk.id_zrodla, tr.id_metody_plat, od.id_typoddzialu
  ) x
) a
LEFT JOIN p_16_zrodlo_kursu z ON a.id_zrodla = z.id_zrodla
LEFT JOIN p_16_metoda_platnosci mp ON a.id_metody_plat = mp.id_metody_plat
LEFT JOIN p_16_typ_oddzialu t ON a.id_typoddzialu = t.id_typoddzialu
ORDER BY z.nazwa_zrodla, mp.metoda, t.typ_oddzialu;


--Hurtownia

SELECT
  z.nazwa_zrodla AS zrodlo_kursu,
  mp.metoda AS metoda_platnosci,
  t.typ_oddzialu AS typ_punktu,
  a.saldo_oplat_i_marzy,
  a.srednia_w_typie_punktu,
  a.odchylenie_od_sredniej
FROM (
  SELECT
    x.id_zrodla,
    x.id_metody_plat,
    x.id_typoddzialu,
    x.saldo_oplat_i_marzy,
    ROUND(AVG(x.saldo_oplat_i_marzy) OVER (PARTITION BY x.id_typoddzialu), 2) AS srednia_w_typie_punktu,
    ROUND(x.saldo_oplat_i_marzy - AVG(x.saldo_oplat_i_marzy) OVER (PARTITION BY x.id_typoddzialu), 2) AS odchylenie_od_sredniej
  FROM (
    SELECT
      id_zrodla,
      id_metody_plat,
      id_typoddzialu,
      SUM(saldo_oplat_i_marzy) AS saldo_oplat_i_marzy
    FROM H_P_16_TRANSAKCJA_WYMIANY
    GROUP BY id_zrodla, id_metody_plat, id_typoddzialu
  ) x
) a
LEFT JOIN H_P_16_ZRODLO_KURSU z ON a.id_zrodla = z.id_zrodla
LEFT JOIN H_P_16_METODA_PLATNOSCI mp ON a.id_metody_plat = mp.id_metody_plat
LEFT JOIN H_P_16_TYP_ODDZIALU t ON a.id_typoddzialu = t.id_typoddzialu
ORDER BY z.nazwa_zrodla, mp.metoda, t.typ_oddzialu;



