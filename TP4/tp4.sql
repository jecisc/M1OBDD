--TP4 - Cyril Ferlicot
-- Question 1

CREATE TABLE ferlicot.Acrostiches (
  id_acro number(4) NOT NULL,
  locution varchar2(40) NOT NULL,
  lang VARCHAR2(40) NOT NULL
);

CREATE TABLE ferlicot.Mot_Composant (
  id_acro number(4) NOT NULL,
  mot varchar2(40) NOT NULL,
  position number(3) NOT NULL
);

ALTER TABLE Acrostiches ADD
  constraint id_acro_pk PRIMARY KEY (id_acro);
  
ALTER TABLE Mot_Composant ADD
  constraint mot_comp_pk PRIMARY KEY (id_acro, mot);

ALTER TABLE Mot_Composant ADD
  constraint id_acro_fk FOREIGN KEY (id_acro) REFERENCES Acrostiches(id_acro);

-- Question 2

CREATE OR REPLACE FUNCTION ID_ACROSTICHE (LOCUTION IN VARCHAR2, LANG IN VARCHAR2) RETURN NUMBER AS 
  id number;
BEGIN
  SELECT id_acro INTO id
  FROM Acrostiches
  WHERE LOCUTION = Acrostiches.locution AND LANG = Acrostiches.lang;
  IF id IS NULL THEN 
    id := calc_acro(LOCUTION, LANG);
  END IF;
  COMMIT;
  RETURN id;
END ID_ACROSTICHE;

CREATE OR REPLACE FUNCTION CALC_ACRO (LOCUTION IN VARCHAR2, LANG IN VARCHAR2 ) RETURN NUMBER AS 
  id number;
  test varchar2(40);
BEGIN
  INSERT INTO Acrostiches (locution, lang) VALUES (LOCUTION, LANG);
  
  SELECT id_acro INTO id
  FROM Acrostiches
  WHERE LOCUTION = Acrostiches.locution AND LANG = Acrostiches.lang;
  
  FOR i IN 1 .. LENGTH(locution) LOOP
     test := genere_mot_in_table(substr(locution, i, 1), i, LANG, id);
  END LOOP;
  
  RETURN id;
END CALC_ACRO;

CREATE OR REPLACE FUNCTION GENERE_MOT_IN_TABLE (LETTER IN VARCHAR2, POSITION IN NUMBER, LANG IN VARCHAR2, ID_ACRO IN NUMBER ) RETURN VARCHAR2 AS 
BEGIN
  RETURN NULL;
END GENERE_MOT_IN_TABLE;


set serveroutput on 
call id_acrostiche('TEST');