-- write a SQL query to find the hometown (including city, state, and country) of Jackie Robinson.
SELECT "birth_city", "birth_state", "birth_country" FROM "players" WHERE "first_name" = 'Jackie' AND "last_name" = 'Robinson';

-- write a SQL query to find the side (e.g., right or left) Babe Ruth hit.
SELECT "bats" FROM "players" WHERE "first_name" = 'Babe' AND "last_name" = 'Ruth';

-- write a SQL query to find the ids of rows for which a value in the column debut is missing.
SELECT "id" FROM "players" WHERE "debut" IS NULL;

-- write a SQL query to find the first and last names of players who were not born in the United States. Sort the results alphabetically by first name, then by last name.
SELECT "first_name", "last_name" FROM "players" WHERE "birth_country" != 'USA' ORDER BY "first_name", "last_name";

-- write a SQL query to return the first and last names of all right-handed batters. Sort the results alphabetically by first name, then by last name.
SELECT "first_name", "last_name" FROM "players" WHERE "bats" = 'R' ORDER BY "first_name", "last_name";

-- write a SQL query to return the first name, last name, and debut date of players born in Pittsburgh, Pennsylvania (PA). Sort the results first by debut date—from most recent to oldest—then alphabetically by first name, followed by last name.
SELECT "first_name", "last_name", "debut" FROM "players" WHERE "birth_city" = 'Pittsburgh' ORDER BY "debut" DESC, "first_name", "last_name";

-- write a SQL query to count the number of players who bat (or batted) right-handed and throw (or threw) left-handed, or vice versa.
SELECT COUNT(*) FROM "players" WHERE ("bats" = 'L' AND "throws" = 'R') OR ("bats" = 'R' AND "throws" = 'L');

-- write a SQL query to find the average height and weight, rounded to two decimal places, of baseball players who debuted on or after January 1st, 2000. Return the columns with the name “Average Height” and “Average Weight”, respectively.
SELECT ROUND(AVG("height"), 2) AS 'Average Height',
       ROUND(AVG("weight"), 2) AS 'Average Weight'
FROM "players" WHERE "debut" > '2000-01-01';

-- write a SQL query to find the players who played their final game in the MLB in 2022. Sort the results alphabetically by first name, then by last name.
SELECT "first_name", "last_name" FROM "players" WHERE "final_game" LIKE '2022%' ORDER BY "first_name", "last_name";
