CREATE TABLE H_P_16_PANSTWO (
    id_panstwa VARCHAR2(3) PRIMARY KEY,
    panstwo VARCHAR2(40) NOT NULL
);

CREATE TABLE H_P_16_WOJEWODZTWO (
    id_wojew VARCHAR2(3) PRIMARY KEY,
    wojewodztwo VARCHAR2(50) NOT NULL
);

CREATE TABLE H_P_16_MIASTO (
    id_miasta VARCHAR2(4) PRIMARY KEY,
    miasto VARCHAR2(50) NOT NULL
);

CREATE TABLE H_P_16_TYP_ODDZIALU (
    id_typoddzialu VARCHAR2(2) PRIMARY KEY,
    typ_oddzialu VARCHAR2(40) NOT NULL
);

CREATE TABLE H_P_16_ZRODLO_KURSU (
    id_zrodla VARCHAR2(3) PRIMARY KEY,
    nazwa_zrodla VARCHAR2(50) NOT NULL
);

CREATE TABLE H_P_16_WALUTA (
    id_waluty VARCHAR2(3) PRIMARY KEY,
    kod_waluty VARCHAR2(3) NOT NULL
);

CREATE TABLE H_P_16_METODA_PLATNOSCI (
    id_metody_plat VARCHAR2(3) PRIMARY KEY,
    metoda VARCHAR2(40) NOT NULL
);

CREATE TABLE H_P_16_ROK (
    id_rok VARCHAR2(4) PRIMARY KEY,
    opis VARCHAR2(20) NOT NULL
);

CREATE TABLE H_P_16_MIESIAC (
    id_miesiaca VARCHAR2(7) PRIMARY KEY,
    opis VARCHAR2(20) NOT NULL
);

CREATE TABLE H_P_16_KLIENT (
    id_klienta VARCHAR2(5) PRIMARY KEY,
    imie VARCHAR2(30) NOT NULL,
    nazwisko VARCHAR2(40) NOT NULL
);

CREATE TABLE H_P_16_PRACOWNIK (
    id_pracownika VARCHAR2(4) PRIMARY KEY,
    imie VARCHAR2(30) NOT NULL,
    nazwisko VARCHAR2(40) NOT NULL
);

CREATE TABLE H_P_16_ODDZIAL_KANTORU (
    id_odzialu VARCHAR2(4) PRIMARY KEY,
    nazwa_oddzialu VARCHAR2(60) NOT NULL
);

CREATE TABLE H_P_16_TABELA_KURSOWA (
    id_kursu VARCHAR2(7) PRIMARY KEY,
    nr_tabeli VARCHAR2(30) NOT NULL
);

CREATE TABLE H_P_16_TRANSAKCJA_WYMIANY (
    id_klienta VARCHAR2(5) NOT NULL,
    id_pracownika VARCHAR2(4) NOT NULL,
    data_transakcji DATE NOT NULL,

    id_panstwa VARCHAR2(3) NOT NULL,
    id_wojew VARCHAR2(3) NOT NULL,
    id_miasta VARCHAR2(4) NOT NULL,
    id_odzialu VARCHAR2(4) NOT NULL,
    id_typoddzialu VARCHAR2(2) NOT NULL,
    id_kursu VARCHAR2(7) NOT NULL,
    id_zrodla VARCHAR2(3) NOT NULL,
    id_walutyzrodlowej VARCHAR2(3) NOT NULL,
    id_metody_plat VARCHAR2(3) NOT NULL,
    id_rok VARCHAR2(4) NOT NULL,
    id_miesiaca VARCHAR2(7) NOT NULL,

    kwota_waluty_zrodlowej NUMBER(11,2) NOT NULL,
    kwota_waluty_docelowej NUMBER(11,2) NOT NULL,
    marza_kwotowa NUMBER(8,2) NOT NULL,
    rabat_kwotowy NUMBER(8,2) NOT NULL,
    rabat_procentowy NUMBER(5,2) NOT NULL,
    przychod NUMBER(11,2) NOT NULL,
    spread NUMBER(10,6) NOT NULL,
    saldo_oplat_i_marzy NUMBER(11,2) NOT NULL,
    suma_oplat NUMBER(11,2) NOT NULL,

    CONSTRAINT pk_h_p16_transakcja
        PRIMARY KEY (id_klienta, id_pracownika, data_transakcji),

    CONSTRAINT fk_h_p16_trans_klient
        FOREIGN KEY (id_klienta)
        REFERENCES H_P_16_KLIENT(id_klienta),

    CONSTRAINT fk_h_p16_trans_pracownik
        FOREIGN KEY (id_pracownika)
        REFERENCES H_P_16_PRACOWNIK(id_pracownika),

    CONSTRAINT fk_h_p16_trans_panstwo
        FOREIGN KEY (id_panstwa)
        REFERENCES H_P_16_PANSTWO(id_panstwa),

    CONSTRAINT fk_h_p16_trans_wojew
        FOREIGN KEY (id_wojew)
        REFERENCES H_P_16_WOJEWODZTWO(id_wojew),

    CONSTRAINT fk_h_p16_trans_miasto
        FOREIGN KEY (id_miasta)
        REFERENCES H_P_16_MIASTO(id_miasta),

    CONSTRAINT fk_h_p16_trans_oddzial
        FOREIGN KEY (id_odzialu)
        REFERENCES H_P_16_ODDZIAL_KANTORU(id_odzialu),

    CONSTRAINT fk_h_p16_trans_typoddzialu
        FOREIGN KEY (id_typoddzialu)
        REFERENCES H_P_16_TYP_ODDZIALU(id_typoddzialu),

    CONSTRAINT fk_h_p16_trans_kurs
        FOREIGN KEY (id_kursu)
        REFERENCES H_P_16_TABELA_KURSOWA(id_kursu),

    CONSTRAINT fk_h_p16_trans_zrodlo
        FOREIGN KEY (id_zrodla)
        REFERENCES H_P_16_ZRODLO_KURSU(id_zrodla),

    CONSTRAINT fk_h_p16_trans_waluta
        FOREIGN KEY (id_walutyzrodlowej)
        REFERENCES H_P_16_WALUTA(id_waluty),

    CONSTRAINT fk_h_p16_trans_metoda
        FOREIGN KEY (id_metody_plat)
        REFERENCES H_P_16_METODA_PLATNOSCI(id_metody_plat),

    CONSTRAINT fk_h_p16_trans_rok
        FOREIGN KEY (id_rok)
        REFERENCES H_P_16_ROK(id_rok),

    CONSTRAINT fk_h_p16_trans_miesiac
        FOREIGN KEY (id_miesiaca)
        REFERENCES H_P_16_MIESIAC(id_miesiaca)
);