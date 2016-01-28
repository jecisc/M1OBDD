/*CREATE OR REPLACE FUNCTION genere_mot(lettre IN VARCHAR2)
RETURN VARCHAR2
AS
TYPE char_tab IS TABLE OF VARCHAR2(1) INDEX BY BINARY_INTEGER;
expression VARCHAR2(30) := CONCAT('^',lettre);
CURSOR c_mots IS SELECT mot FROM adjectifs
WHERE  REGEXP_LIKE (mot, expression) AND lang = 'FR'
ORDER BY DBMS_RANDOM.RANDOM;
mot c_mots%ROWTYPE;
BEGIN
OPEN c_mots;
FETCH c_mots INTO mot;
RETURN mot.mot;
END genere_mot;*/

/*
CREATE OR REPLACE PROCEDURE acrotische(chaine IN VARCHAR2)
AS
TYPE char_tab IS TABLE OF VARCHAR2(1) INDEX BY BINARY_INTEGER;
tab char_tab;
tmp VARCHAR2(1);
resultat VARCHAR2(100) := '';
BEGIN
FOR i IN 1 .. LENGTH(chaine) LOOP
DBMS_OUTPUT.PUT_LINE(genere_mot(substr(chaine, i, 1)));
END LOOP;
END acrotische;
*/

set serveroutput on 
call acrotische('TEST');