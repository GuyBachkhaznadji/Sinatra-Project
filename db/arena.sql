DROP TABLE IF EXISTS creatures;
DROP TABLE IF EXISTS gladiators;
-- DROP TABLE IF EXISTS creature_types;

-- CREATE TABLE creature_types(
-- id SERIAL4 PRIMARY KEY,
-- name VARCHAR(255) NOT NULL,
-- starting_health INT4 NOT NULL,
-- starting_attack INT4 NOT NULL,
-- starting_defence INT4 NOT NULL,
-- starting_speed INT4 NOT NULL
-- );


CREATE TABLE gladiators(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255) NOT NULL
-- level INT4 NOT NULL,
-- exp INT4 NOT NULL,
-- current_health INT4 NOT NULL,
-- max_health INT4 NOT NULL,
-- attack INT4 NOT NULL,
-- defence INT4 NOT NULL,
-- speed INT4 NOT NULL
);

CREATE TABLE creatures(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255) NOT NULL,
type VARCHAR(255),
-- type_id INT4 REFERENCES creature_types(id),
capture_date DATE NOT NULL,
fightable BOOLEAN NOT NULL,
gladiator_id INT4 REFERENCES gladiators(id)
-- level INT4 NOT NULL,
-- exp INT4 NOT NULL,
-- current_health INT4 NOT NULL,
-- max_health INT4 NOT NULL,
-- attack INT4 NOT NULL,
-- defence INT4 NOT NULL,
-- speed INT4 NOT NULL
);


