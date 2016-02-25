create synonym ferlicot.prenom for BOSSUT.prenom;

-- Question 1

select * from prenom;

-- Les éléves sont dans l'ordre alphabetique car les données ont été rentrées dans l'ordre alphabétique.

select prenom from prenom where genre = 'Garçon';

set serveroutput on;
declare
type pren_type is table of VARCHAR2(50) index by binary_integer ;
prenoms pren_type;
x NUMBER;
begin
select prenom bulk collect into prenoms from prenom where prenom.genre = 'Garçon';
for i in prenoms.first..prenoms.last loop
   x := ID_ACROSTICHE(prenoms(i), 'FR');
   x := ID_ACROSTICHE(prenoms(i), 'EN');
end loop;
  
select prenom bulk collect into prenoms from prenom where prenom.genre = 'Fille';
for i in prenoms.first..prenoms.last loop
   x := ID_ACROSTICHE(prenoms(i), 'FR');
   x := ID_ACROSTICHE(prenoms(i), 'ES');
end loop;
  
select prenom bulk collect into prenoms from prenom where prenom.genre = 'Mixte';
for i in prenoms.first..prenoms.last loop
   x := ID_ACROSTICHE(prenoms(i), 'FR');
   x := ID_ACROSTICHE(prenoms(i), 'EN');
   x := ID_ACROSTICHE(prenoms(i), 'ES');
end loop;
end;

-- Question 2


set autotrace on;

select * from mot_composant;

-- Question 3
CREATE INDEX adj_mot ON adjectifs(mot)
      TABLESPACE users
      STORAGE (INITIAL 20K
      NEXT 20k
      PCTINCREASE 75);