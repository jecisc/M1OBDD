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

create or replace FUNCTION ID_ACROSTICHE (LOCUTION IN VARCHAR2, LANG IN VARCHAR2) RETURN NUMBER AS 
  res number;
BEGIN
  dbms_output.put_line('pre-caca');
  BEGIN
  SELECT ID_ACRO INTO res
  FROM ACROSTICHES
  WHERE LOCUTION = ACROSTICHES.LOCUTION AND LANG = ACROSTICHES.LANG;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
         dbms_output.put_line('caca');
         res := calc_acro(LOCUTION, LANG);
    END;
  COMMIT;
  RETURN res;
END ID_ACROSTICHE;

create or replace FUNCTION CALC_ACRO (LOCUTION IN VARCHAR2, LANG IN VARCHAR2 ) RETURN NUMBER AS 
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

create or replace FUNCTION GENERE_MOT_IN_TABLE (LETTER IN VARCHAR2, POS IN NUMBER, LANG IN VARCHAR2, ID_ACRO IN NUMBER ) RETURN VARCHAR2 AS 
  TYPE char_tab IS TABLE OF VARCHAR2(1) INDEX BY BINARY_INTEGER;
  expression VARCHAR2(30) := CONCAT('^',LETTER);
  CURSOR c_mots IS SELECT mot FROM adjectifs
  WHERE  REGEXP_LIKE (mot, expression) AND adjectifs.lang = LANG
  ORDER BY DBMS_RANDOM.RANDOM;
  res c_mots%ROWTYPE;
  BEGIN
    OPEN c_mots;
    FETCH c_mots INTO res;
    INSERT INTO MOT_COMPOSANT (id_acro, mot, position) VALUES (id_acro, res.mot, POS);
  RETURN res.mot;
END GENERE_MOT_IN_TABLE;

set serveroutput on;
select ID_ACROSTICHE('TEST', 'FR') from dual;

SELECT ID_ACRO
  FROM ACROSTICHES
  WHERE  ACROSTICHES.LOCUTION = 'TEST' AND ACROSTICHES.LANG  = 'FR';