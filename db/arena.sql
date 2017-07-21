DROP TABLE IF EXISTS creatures;
DROP TABLE IF EXISTS fighters;

CREATE TABLE fighters(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255)
);

CREATE TABLE creatures(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255),
caputure_date DATE,
fightable BOOLEAN,
fighter_id INT4 REFERENCES fighters(id)
);
