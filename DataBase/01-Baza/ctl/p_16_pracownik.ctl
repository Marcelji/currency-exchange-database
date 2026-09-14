LOAD DATA
INFILE 'data/p_16_pracownik.csv'
INTO TABLE p_16_pracownik
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_ulicy,
  id_odzialu,
  id_pracownika,
  imie,
  nazwisko,
  pesel,
  nr_budynku,
  kod_pocztowy,
  nr_telefonu,
  email,
  data_zatrudnienia DATE "YYYY-MM-DD",
  pensja_podstawa,
  premia,
  id_stanowiska
)