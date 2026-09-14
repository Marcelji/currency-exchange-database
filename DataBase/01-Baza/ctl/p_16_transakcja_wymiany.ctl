LOAD DATA
INFILE 'data/p_16_transakcja_wymiany.csv'
INTO TABLE p_16_Transakcja_wymiany
APPEND
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_klienta,
  id_kursu,
  id_metody_plat,
  id_typu_trans,
  id_pracownika,
  data_transakcji DATE "YYYY-MM-DD HH24:MI:SS",
  id_walutyzrodlowej,
  id_walutydocelowej,
  kwota_waluty_docelowej,
  kwota_waluty_zrodlowej,
  kurs_kupna,
  kurs_sprzedazy,
  prowizja_kwotowa,
  oplata_dodatkowa,
  rabat_kwotowy,
  rabat_procentowy,
  marza_kwotowa,
  oplata_stala
)