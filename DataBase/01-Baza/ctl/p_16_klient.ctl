LOAD DATA
INFILE 'data/p_16_klient.csv'
INTO TABLE p_16_klient
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_ulicy,
  id_rodzaju_dokumentu,
  id_klienta,
  imie,
  nazwisko,
  pesel,
  nr_dokumentu,
  nr_budynku,
  nr_lokalu,
  kod_pocztowy,
  nr_tel,
  email,
  data_urodzenia DATE "YYYY-MM-DD",
  status
)