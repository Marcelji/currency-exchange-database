LOAD DATA
INFILE 'data/p_16_metoda_platnosci.csv'
INTO TABLE p_16_metoda_platnosci
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_metody_plat,
  metoda,
  opis_metody
)