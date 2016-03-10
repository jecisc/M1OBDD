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

