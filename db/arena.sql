DROP TABLE IF EXISTS creatures;
DROP TABLE IF EXISTS gladiators;

CREATE TABLE gladiators(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255) NOT NULL
);

CREATE TABLE creatures(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255) NOT NULL,
capture_date DATE NOT NULL,
fightable BOOLEAN NOT NULL,
gladiator_id INT4 REFERENCES gladiators(id)
);
