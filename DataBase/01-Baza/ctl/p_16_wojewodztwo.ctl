LOAD DATA
INFILE 'data/p_16_wojewodztwo.csv'
INTO TABLE p_16_wojewodztwo
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_wojew,
  id_panstwa,
  wojewodztwo
)