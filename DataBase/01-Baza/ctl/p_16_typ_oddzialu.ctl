LOAD DATA
INFILE 'data/p_16_typ_oddzialu.csv'
INTO TABLE p_16_typ_oddzialu
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_typoddzialu,
  typ_oddzialu
)