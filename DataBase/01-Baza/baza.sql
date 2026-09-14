CREATE TABLE P_16_PANSTWO (
    id_panstwa NUMBER PRIMARY KEY,
    panstwo    VARCHAR2(40) NOT NULL
);


CREATE TABLE P_16_WOJEWODZTWO (
    id_wojew    NUMBER PRIMARY KEY,
    wojewodztwo VARCHAR2(50) NOT NULL,
    id_panstwa  NUMBER NOT NULL,

    CONSTRAINT fk_p16_woj_panstwo
        FOREIGN KEY (id_panstwa)
        REFERENCES P_16_PANSTWO(id_panstwa)
);


CREATE TABLE P_16_MIASTO (
    id_miasta NUMBER PRIMARY KEY,
    miasto    VARCHAR2(50) NOT NULL,
    id_wojew  NUMBER NOT NULL,

    CONSTRAINT fk_p16_miasto_woj
        FOREIGN KEY (id_wojew)
        REFERENCES P_16_WOJEWODZTWO(id_wojew)
);


CREATE TABLE P_16_ULICA (
    id_ulicy NUMBER PRIMARY KEY,
    ulica    VARCHAR2(60) NOT NULL,
    d_miasta NUMBER NOT NULL,

    CONSTRAINT fk_p16_ulica_miasto
        FOREIGN KEY (d_miasta)
        REFERENCES P_16_MIASTO(id_miasta)
);


CREATE TABLE P_16_RODZAJ_DOKUMENT (
    id_rodzaju_dokumentu NUMBER PRIMARY KEY,
    rodzaj_dokumentu     VARCHAR2(40) NOT NULL
);


CREATE TABLE P_16_KLIENT (
    id_klienta             NUMBER PRIMARY KEY,
    imie                   VARCHAR2(30) NOT NULL,
    nazwisko               VARCHAR2(40) NOT NULL,
    status                 VARCHAR2(20) NOT NULL,
    id_ulicy               NUMBER NOT NULL,
    id_rodzaju_dokumentu   NUMBER NOT NULL,

    CONSTRAINT fk_p16_klient_ulica
        FOREIGN KEY (id_ulicy)
        REFERENCES P_16_ULICA(id_ulicy),

    CONSTRAINT fk_p16_klient_dokument
        FOREIGN KEY (id_rodzaju_dokumentu)
        REFERENCES P_16_RODZAJ_DOKUMENT(id_rodzaju_dokumentu),

    CONSTRAINT chk_p16_klient_status
        CHECK (status IN ('VIP', 'ZWYKLY'))
);


CREATE TABLE P_16_STANOWISKO (
    id_stanowiska NUMBER PRIMARY KEY,
    stanowisko    VARCHAR2(40) NOT NULL
);


CREATE TABLE P_16_TYP_ODDZIALU (
    id_typoddzialu NUMBER PRIMARY KEY,
    typ_oddzialu   VARCHAR2(40) NOT NULL
);


CREATE TABLE P_16_ODDZIAL_KANTORU (
    id_odzialu      NUMBER PRIMARY KEY,
    nazwa_oddzialu  VARCHAR2(60) NOT NULL,
    id_typoddzialu  NUMBER NOT NULL,
    id_ulicy        NUMBER NOT NULL,

    CONSTRAINT fk_p16_oddzial_typ
        FOREIGN KEY (id_typoddzialu)
        REFERENCES P_16_TYP_ODDZIALU(id_typoddzialu),

    CONSTRAINT fk_p16_oddzial_ulica
        FOREIGN KEY (id_ulicy)
        REFERENCES P_16_ULICA(id_ulicy)
);


CREATE TABLE P_16_PRACOWNIK (
    id_pracownika NUMBER PRIMARY KEY,
    imie          VARCHAR2(30) NOT NULL,
    nazwisko      VARCHAR2(40) NOT NULL,
    id_stanowiska NUMBER NOT NULL,
    id_odzialu    NUMBER NOT NULL,
    id_ulicy      NUMBER NOT NULL,

    CONSTRAINT fk_p16_prac_stanowisko
        FOREIGN KEY (id_stanowiska)
        REFERENCES P_16_STANOWISKO(id_stanowiska),

    CONSTRAINT fk_p16_prac_oddzial
        FOREIGN KEY (id_odzialu)
        REFERENCES P_16_ODDZIAL_KANTORU(id_odzialu),

    CONSTRAINT fk_p16_prac_ulica
        FOREIGN KEY (id_ulicy)
        REFERENCES P_16_ULICA(id_ulicy)
);


CREATE TABLE P_16_WALUTA (
    id_waluty  NUMBER PRIMARY KEY,
    kod_waluty VARCHAR2(3) NOT NULL,
    nazwa      VARCHAR2(40) NOT NULL
);


CREATE TABLE P_16_ZRODLO_KURSU (
    id_zrodla    NUMBER PRIMARY KEY,
    nazwa_zrodla VARCHAR2(50) NOT NULL
);


CREATE TABLE P_16_TABELA_KURSOWA (
    id_kursu       NUMBER PRIMARY KEY,
    nr_tabeli      VARCHAR2(30) NOT NULL,
    id_zrodla      NUMBER NOT NULL,
    data_kursu     DATE NOT NULL,

    CONSTRAINT fk_p16_kurs_zrodlo
        FOREIGN KEY (id_zrodla)
        REFERENCES P_16_ZRODLO_KURSU(id_zrodla)
);


CREATE TABLE P_16_METODA_PLATNOSCI (
    id_metody_plat NUMBER PRIMARY KEY,
    metoda         VARCHAR2(40) NOT NULL
);


CREATE TABLE P_16_TYP_TRANSAKCJI (
    id_typu_transakcji NUMBER PRIMARY KEY,
    typ_transakcji     VARCHAR2(40) NOT NULL
);


CREATE TABLE P_16_TRANSAKCJA_WYMIANY (
    id_klienta              NUMBER NOT NULL,
    id_pracownika           NUMBER NOT NULL,
    data_transakcji         DATE NOT NULL,

    id_kursu                NUMBER NOT NULL,
    id_walutyzrodlowej      NUMBER NOT NULL,
    id_waluty_docelowej     NUMBER NOT NULL,
    id_metody_plat          NUMBER NOT NULL,
    id_typu_transakcji      NUMBER NOT NULL,

    kwota_waluty_zrodlowej  NUMBER(11,2) NOT NULL,
    kwota_waluty_docelowej  NUMBER(11,2) NOT NULL,

    kurs_kupna              NUMBER(10,6) NOT NULL,
    kurs_sprzedazy          NUMBER(10,6) NOT NULL,

    marza_kwotowa           NUMBER(8,2) NOT NULL,
    rabat_kwotowy           NUMBER(8,2) NOT NULL,
    rabat_procentowy        NUMBER(5,2) NOT NULL,

    prowizja_kwotowa        NUMBER(8,2) NOT NULL,
    oplata_dodatkowa        NUMBER(8,2) NOT NULL,
    oplata_stala            NUMBER(8,2) NOT NULL,

    CONSTRAINT pk_p16_transakcja
        PRIMARY KEY (id_klienta, id_pracownika, data_transakcji),

    CONSTRAINT fk_p16_trans_klient
        FOREIGN KEY (id_klienta)
        REFERENCES P_16_KLIENT(id_klienta),

    CONSTRAINT fk_p16_trans_pracownik
        FOREIGN KEY (id_pracownika)
        REFERENCES P_16_PRACOWNIK(id_pracownika),

    CONSTRAINT fk_p16_trans_kurs
        FOREIGN KEY (id_kursu)
        REFERENCES P_16_TABELA_KURSOWA(id_kursu),

    CONSTRAINT fk_p16_trans_waluta_zrodlo
        FOREIGN KEY (id_walutyzrodlowej)
        REFERENCES P_16_WALUTA(id_waluty),

    CONSTRAINT fk_p16_trans_waluta_docelowa
        FOREIGN KEY (id_waluty_docelowej)
        REFERENCES P_16_WALUTA(id_waluty),

    CONSTRAINT fk_p16_trans_metoda
        FOREIGN KEY (id_metody_plat)
        REFERENCES P_16_METODA_PLATNOSCI(id_metody_plat),

    CONSTRAINT fk_p16_trans_typ
        FOREIGN KEY (id_typu_transakcji)
        REFERENCES P_16_TYP_TRANSAKCJI(id_typu_transakcji),

    CONSTRAINT chk_p16_kwota_zrodlowa
        CHECK (kwota_waluty_zrodlowej >= 0),

    CONSTRAINT chk_p16_kwota_docelowa
        CHECK (kwota_waluty_docelowej >= 0),

    CONSTRAINT chk_p16_kurs_kupna
        CHECK (kurs_kupna >= 0),

    CONSTRAINT chk_p16_kurs_sprzedazy
        CHECK (kurs_sprzedazy >= 0),

    CONSTRAINT chk_p16_marza
        CHECK (marza_kwotowa >= 0),

    CONSTRAINT chk_p16_rabat_kwotowy
        CHECK (rabat_kwotowy >= 0),

    CONSTRAINT chk_p16_rabat_proc
        CHECK (rabat_procentowy >= 0),

    CONSTRAINT chk_p16_prowizja
        CHECK (prowizja_kwotowa >= 0),

    CONSTRAINT chk_p16_oplata_dodatkowa
        CHECK (oplata_dodatkowa >= 0),

    CONSTRAINT chk_p16_oplata_stala
        CHECK (oplata_stala >= 0)
);