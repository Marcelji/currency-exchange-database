LOAD DATA
INFILE 'data/p_16_typ_transakcji.csv'
INTO TABLE p_16_typ_transakcji
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_typu_trans,
  typ_transakcji,
  opis_transakcji
)