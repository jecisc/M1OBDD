Create table adjectifs_p(
  mot VARCHAR2(50),
  lang VARCHAR2(50))
partition by range(mot)(
  partition p1 Values less than('b'),
  partition p2 Values less than('d'),
  partition p3 values less than('k'),
  partition p4 values less than('n'),  
  partition p5 values less than('r'),  
  partition p6 values less than('v'),
  partition p7 values less than(MAXVALUE));  
 
 
INSERT INTO Adjectifs_p
SELECT * FROM Adjectifs;


set autotrace on;

select * from adjectifs_p where mot = 'ardu' or mot='badin';

select * from adjectifs_p where mot between 'vorace' and 'yankee';

select count(*) from adjectifs_p where lang = 'FR';

select * from adjectifs_p where mot like 'z%' ;

select * from adjectifs_p where mot like '%z';

select count(*) from adjectifs_p partition(p7);

-- Partition start et partition stop défini le range des partitions qui ont été utilisées lors de la requête

alter table adjectifs_p merge partitions p6, p7 into partition p67;

alter table adjectifs_p split partition p3 at ('g') into (Partition p31 , Partition p32);

alter table adjectifs_p split partition p67 at ('t') into (Partition p6 , Partition p7);

Create table adjectifs_p2(
  mot VARCHAR2(50),
  lang VARCHAR2(50))
partition by LIST (lang) subpartition by RANGE (mot)(
  partition p10 values ('FR')
  (
  subpartition s1 values less than ('b'),
  subpartition s2 Values less than('d'),
  subpartition s3 values less than('k'),
  subpartition s4 values less than('n'),  
  subpartition s5 values less than('r'),  
  subpartition s6 values less than('v'),
  subpartition s7 values less than(MAXVALUE)
),
  partition p11 values ('ES')
  (
  subpartition s11 values less than ('b'),
  subpartition s12 Values less than('d'),
  subpartition s13 values less than('k'),
  subpartition s14 values less than('n'),  
  subpartition s15 values less than('r'),  
  subpartition s16 values less than('v'),
  subpartition s17 values less than(MAXVALUE)
),
  partition p12 values ('EN')
  (
  subpartition s21 values less than ('b'),
  subpartition s22 Values less than('d'),
  subpartition s23 values less than('k'),
  subpartition s24 values less than('n'),  
  subpartition s25 values less than('r'),  
  subpartition s26 values less than('v'),
  subpartition s27 values less than(MAXVALUE)
)
);

 
INSERT INTO Adjectifs_p2
SELECT * FROM Adjectifs;

describe user_tab_subpartitions;

BEGIN
FOR rec IN
(SELECT subpartition_name
FROM all_tab_subpartitions
WHERE table_owner = <username>
AND table_name = 'ADJECTIFS_P2'
AND partition_name in ( <noms de differentes partitions> ))
LOOP
SYS.DBMS_STATS.GATHER_TABLE_STATS(
OwnName          => <username>
TabName          => 'ADJECTIFS_P2',
PartName         => rec.subpartition_name,
Granularity      => 'SUBPARTITION',
Estimate_Percent => 10,
Degree           => NULL,
Cascade          => TRUE);
END LOOP;
END;


SET AUTOTRACE ON;
select count(*) from adjectifs where lang='EN';
select count(*) from adjectifs_p2 where lang='EN';

select count(*), lang from adjectifs group by lang ;
select count(*), lang from adjectifs_p2 group by lang ;

select * from adjectifs where mot = 'big' or mot = 'fat';
select * from adjectifs_p2 where mot = 'big' or mot = 'fat';

select count(*), lang, substr(mot,1,1) as initiale from adjectifs group by lang, substr(mot,1,1) order by initiale;
select count(*), lang, substr(mot,1,1) as initiale from adjectifs_p2 group by lang, substr(mot,1,1) order by initiale;

select * from adjectifs where lang = 'ES' and mot like 'bar%';
select * from adjectifs_p2 where lang = 'ES' and mot like 'bar%';

