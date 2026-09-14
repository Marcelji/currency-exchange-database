LOAD DATA
INFILE 'data/p_16_stanowisko.csv'
INTO TABLE p_16_stanowisko
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_stanowiska,
  stanowisko,
  opis
)