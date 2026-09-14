LOAD DATA
INFILE 'data/p_16_rodzaj_dokument.csv'
INTO TABLE p_16_rodzaj_dokument
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_rodzaj,
  rodzaj_dok
)