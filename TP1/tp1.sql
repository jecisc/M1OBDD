-- QUESTION 1
-- See export question 1

-- Question2

-- On a 22504 lignes. 50 blocks qui est la plus petite unitée de mesure en oracle. 1block = 8Ko de base mais il peut monter à 32Ko. Le nombre de block dépend de l'histoire de la table.  En moyenne dans ces trois langues les mots font 10 caractères.

-- Question 4
/*
CREATE OR REPLACE FUNCTION TRIMOT ( MOT IN VARCHAR2 ) RETURN VARCHAR2 AS
  TYPE helper IS TABLE OF VARCHAR2(40) index by binary_integer;
  triTab helper;
  i binary_integer;
  i2 binary_integer;
  len number;
  mini binary_integer;
  tmp VARCHAR2(40);
  res VARCHAR2(40);
BEGIN
  len := LENGTH(mot);
  FOR i IN 1.. len LOOP 
    triTab(i) := SUBSTR(mot, i, 1); 
END LOOP;

  FOR i IN 1 .. len LOOP
  i2 := i;
  mini := i;
    FOR i2 IN i .. len LOOP
      IF triTab(i2) < triTab(mini) THEN
        mini := i2;
      END IF;
    END LOOP;
    tmp := triTab(i2);
    triTab(i2) := triTab(mini);
    triTab(mini) := tmp;
  END LOOP;
  
  FOR i IN 1 .. len LOOP
    res := res || triTab(i);
  END LOOP;
  
  RETURN res;
END TRIMOT;*/

select a1.mot, a2.mot
from ADJECTIFS a1, ADJECTIFS a2
where a1.LANG = 'FR' and a2.LANG = 'FR' and a1.mot < a2.mot and TRIMOT(a1.mot) = TRIMOT(a2.mot);

