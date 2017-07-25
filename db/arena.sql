DROP TABLE IF EXISTS creatures;
DROP TABLE IF EXISTS gladiators;
DROP TABLE IF EXISTS creature_types;

CREATE TABLE creature_types(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255) NOT NULL,
starting_health INT4 NOT NULL,
starting_attack INT4 NOT NULL,
starting_defence INT4 NOT NULL,
starting_speed INT4 NOT NULL
);


CREATE TABLE gladiators(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255) NOT NULL,
type_id INT4 REFERENCES creature_types(id),
level INT4,
exp INT4,
current_health INT4,
max_health INT4,
attack INT4,
defence INT4,
speed INT4
);

CREATE TABLE creatures(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255) NOT NULL,
type VARCHAR(255),
type_id INT4 REFERENCES creature_types(id),
capture_date DATE NOT NULL,
fightable BOOLEAN NOT NULL,
gladiator_id INT4 REFERENCES gladiators(id) ON DELETE CASCADE,
level INT4,
exp INT4,
current_health INT4,
max_health INT4,
attack INT4,
defence INT4,
speed INT4
);


