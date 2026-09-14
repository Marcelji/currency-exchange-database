LOAD DATA
INFILE 'data/p_16_oddzial_kantoru.csv'
INTO TABLE p_16_oddzial_kantoru
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_ulicy,
  id_typoddzialu,
  id_odzialu,
  nazwa_oddzialu,
  nr_budynku,
  nr_lokalu,
  kod_pocztowy,
  nr_telefonu,
  email,
  godz_otwarcia,
  godz_zamkniecia
)