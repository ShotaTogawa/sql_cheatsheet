-- 4-1
INSERT INTO tests (test) values ('test 1');

-- 4-2
INSERT INTO tests (test)
values ('test 2'),
       ('test 3'),
       ('test 4');

-- 4-3
INSERT INTO onwers (name) values ('World');
INSERT INTO onwers (name) values ('Morning');
INSERT INTO onwers (name) values ('Sun');
INSERT INTO onwers (name) values ('Moon');


-- 4-4
INSERT INTO pets(owner_id, name, sex)
values ('1', 'dog A', 'F');
INSERT INTO pets(owner_id, name, sex)
values ('1', 'cat A', 'F');
INSERT INTO pets(owner_id, name, sex)
values ('1', 'cat B', 'M');
INSERT INTO pets(owner_id, name)
values ('2', 'Turtle A');

