DROP TABLE IF EXISTS creatures;
DROP TABLE IF EXISTS gladiators;

CREATE TABLE gladiators(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255)
);

CREATE TABLE creatures(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255),
capture_date DATE,
fightable BOOLEAN,
gladiator_id INT4 REFERENCES gladiators(id)
);
