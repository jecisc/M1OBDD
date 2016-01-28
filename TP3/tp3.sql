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
create or replace PROCEDURE acrotische(chaine IN VARCHAR2)
AS
TYPE char_tab IS TABLE OF VARCHAR2(1) INDEX BY BINARY_INTEGER;
tab char_tab;
tmp VARCHAR2(1);
resultat VARCHAR2(100) := '';
v_start NUMBER;
v_stop NUMBER;
BEGIN
v_start := DBMS_UTILITY.GET_TIME;
FOR i IN 1 .. LENGTH(chaine) LOOP
DBMS_OUTPUT.PUT_LINE(genere_mot(substr(chaine, i, 1)));
END LOOP;
v_stop := DBMS_UTILITY.GET_TIME;
DBMS_OUTPUT.PUT_LINE(((v_stop-v_start)*10) || ' ms');
END acrotische;
*/

set serveroutput on 
call acrotische('TEST');

/*
delete from adjectifs where mot = '0';
delete from adjectifs where mot = '1';
delete from adjectifs where mot = '(página anterior) (página siguiente)';*/

DECLARE
v_start NUMBER;
v_stop NUMBER;
test VARCHAR2(40);
test2 VARCHAR2(40);
BEGIN

  v_start := DBMS_UTILITY.GET_TIME;
  select min(mot), max(mot)  into test, test2 from adjectifs where lang = 'FR';
  v_stop := DBMS_UTILITY.GET_TIME;
  DBMS_OUTPUT.PUT_LINE(((v_stop-v_start)*10) || ' ms');

END;

select min(mot) from adjectifs where lang = 'FR';
select max(mot) from adjectifs where lang = 'FR';
select min(mot) from adjectifs where lang = 'FR';
select min(mot), max(mot) from adjectifs where lang = 'FR';