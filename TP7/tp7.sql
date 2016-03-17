CREATE INDEX idx_mot_part
on adjectifs_p (mot)
LOCAL
(PARTITION idx1,
PARTITION idx2,
PARTITION idx3,
PARTITION idx4,
PARTITION idx5,
PARTITION idx6,
PARTITION idx7,
PARTITION idx8);



set autotrace on;

select * from huguet.adjectifs_p where trie = 'cefilort';

set autotrace on;

select libelle from huguet.adjectifs_p where trie like 'aab%' and libelle like 'v%';

DROP TABLE docs;

CREATE TABLE docs(
  mot VARCHAR2(40),
  nieme NUMBER(4),
  document VARCHAR2(70),
  autre VARCHAR2(10),
  CONSTRAINT PK_docs PRIMARY KEY (nieme, document)
) ORGANIZATION INDEX;


set autotrace on;

select * from docs where document = 'text.txt' and nieme = 2;

select * from docs where document = 'text.txt';

select * from docs where document = 'text.txt' order by nieme;

CREATE INDEX INDEX_QUEST_6 ON DOCS (MOT, DOCUMENT);

set autotrace on;

select * from docs where document = 'text.txt'and mot = 'cigale';
select * from docs where mot ='cigale';


