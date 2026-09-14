LOAD DATA
INFILE 'data/p_16_zrodlo_kursu.csv'
INTO TABLE p_16_zrodlo_kursu
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_zrodla,
  nazwa_zrodla,
  opis_zrodla
)