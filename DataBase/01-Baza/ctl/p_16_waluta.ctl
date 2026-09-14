LOAD DATA
INFILE 'data/p_16_waluta.csv'
INTO TABLE p_16_waluta
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_waluty,
  kod_waluty,
  waluta,
  symbol
)