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
  constraint mot_comp_pk PRIMARY KEY (id_acro, mot, position);

ALTER TABLE Mot_Composant ADD
  constraint id_acro_fk FOREIGN KEY (id_acro) REFERENCES Acrostiches(id_acro);

-- Question 2

-- Find the id, if none, create and return it.
create or replace FUNCTION ID_ACROSTICHE (LOCU IN VARCHAR2, LANGU IN VARCHAR2) RETURN NUMBER AS 
  res number;
BEGIN
  dbms_output.put_line('pre-caca');
  BEGIN
  SELECT ID_ACRO INTO res
  FROM ACROSTICHES
  WHERE LOCU = ACROSTICHES.LOCUTION AND LANGU = ACROSTICHES.LANG;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
         dbms_output.put_line('caca');
         res := calc_acro(LOCU, LANGU);
    END;
  RETURN res;
END ID_ACROSTICHE;

--Autonomous function to create an acrostiche entry
create or replace function insert_acro(LOCUTION IN VARCHAR2, LANG IN VARCHAR2 ) RETURN NUMBER IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  INSERT INTO Acrostiches (locution, lang) VALUES (LOCUTION, LANG);
 COMMIT;
 RETURN 1;
END;

--Create a new acrostiche and return the id
create or replace FUNCTION CALC_ACRO (LOCU IN VARCHAR2, LANGU IN VARCHAR2 ) RETURN NUMBER AS 
  id number;
  test varchar2(40);
BEGIN
  id := insert_acro(LOCU, LANGU);
  
  SELECT id_acro INTO id
  FROM Acrostiches
  WHERE LOCU = Acrostiches.locution AND LANGU = Acrostiches.lang;
  
  FOR i IN 1 .. LENGTH(LOCU) LOOP
     test := genere_mot_in_table(substr(LOCU, i, 1), i, LANGU, id);
  END LOOP;
  
  RETURN id;
END CALC_ACRO;

--Autonomous function to insert a word for a letter
create or replace function insert_mot(ID_ACRO IN number, LOCUTION IN VARCHAR2, POS IN number) RETURN NUMBER IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  INSERT INTO MOT_COMPOSANT (id_acro, mot, position) VALUES (ID_ACRO, LOCUTION, POS);
 COMMIT;
 RETURN 1;
END;

-- Find a word for a letter and insert it
create or replace FUNCTION GENERE_MOT_IN_TABLE (LETTER IN VARCHAR2, POS IN NUMBER, LANGU IN VARCHAR2, ID_ACR IN NUMBER ) RETURN VARCHAR2 AS 
  TYPE char_tab IS TABLE OF VARCHAR2(1) INDEX BY BINARY_INTEGER;
  expression VARCHAR2(30) := CONCAT('^',LETTER);
  CURSOR c_mots IS SELECT mot FROM adjectifs
  WHERE  REGEXP_LIKE (mot, expression) AND adjectifs.lang = LANGU
  ORDER BY DBMS_RANDOM.RANDOM;
  res c_mots%ROWTYPE;
  exitNumber number;
  BEGIN
    OPEN c_mots;
    FETCH c_mots INTO res;
    exitNumber:= insert_mot(ID_ACR, res.mot, POS);
  RETURN res.mot;
END GENERE_MOT_IN_TABLE;

-- Test which is usable :)
set serveroutput on;
select ID_ACROSTICHE('Anticonstitutionnellement', 'FR') from dual;

SELECT MOT
  FROM MOT_COMPOSANT
  WHERE  ID_ACRO= 3
  ORDER BY position;