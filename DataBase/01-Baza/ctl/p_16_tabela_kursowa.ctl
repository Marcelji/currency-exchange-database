LOAD DATA
INFILE 'data/p_16_tabela_kursowa.csv'
INTO TABLE p_16_tabela_kursowa
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_zrodla,
  id_kursu,
  nr_tabeli,
  data DATE "YYYY-MM-DD",
  godzina_aktu,
  opis_tabeli
)