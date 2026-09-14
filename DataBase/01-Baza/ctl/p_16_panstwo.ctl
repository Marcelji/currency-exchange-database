LOAD DATA
INFILE 'data/p_16_panstwo.csv'
INTO TABLE p_16_panstwo
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_panstwa,
  panstwo,
  kod_iso3
)