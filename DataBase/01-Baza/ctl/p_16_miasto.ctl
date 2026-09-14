LOAD DATA
INFILE 'data/p_16_miasto.csv'
INTO TABLE p_16_miasto
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_wojew,
  id_miasta,
  miasto
)