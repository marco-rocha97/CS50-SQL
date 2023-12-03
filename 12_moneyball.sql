-- write a SQL query to find the average player salary by year.
-- Sort by year in descending order.
-- Round the salary to two decimal places and call the column “average salary”.
SELECT "year", ROUND(AVG("salary"), 2) AS "average salary"
FROM "salaries"
GROUP BY "year"
ORDER BY "year" DESC;

-- write a SQL query to find Cal Ripken Jr.’s salary history.
-- Sort by year in descending order.
SELECT "year", "salary"
FROM "salaries"
WHERE "player_id" = (
    SELECT "id" FROM "players"
    WHERE "first_name" = 'Cal' AND "last_name" = 'Ripken'
)
ORDER BY "year" DESC;

-- write a SQL query to find Ken Griffey Jr.’s home run history.
-- Sort by year in descending order.
-- Note that there may be two players with the name “Ken Griffey.” This Ken Griffey was born in 1969.
SELECT "year", "HR"
FROM "performances"
WHERE "player_id" = (
    SELECT "id" FROM "players"
    WHERE "first_name" = 'Ken' AND "last_name" = 'Griffey' AND "birth_year" = 1969
)
ORDER BY "year" DESC;

-- write a SQL query to find the 50 players paid the least in 2001.
-- Sort players by salary, lowest to highest.
-- If two players have the same salary, sort alphabetically by first name and then by last name.
-- If two players have the same first and last name, sort by player ID.
SELECT "players"."first_name", "players"."last_name", "salaries"."salary"
FROM "salaries"
JOIN "players" ON "salaries"."player_id" = "players"."id"
WHERE "salaries"."year" = 2001
ORDER BY "salary", "first_name", "last_name", "player_id"
LIMIT 50;

-- write a SQL query to find all teams that Satchel Paige played for.
SELECT "name" FROM "teams"
WHERE "id" IN (
    SELECT "team_id" FROM "performances"
    WHERE "player_id" = (
        SELECT "id" FROM "players"
        WHERE "first_name" = 'Satchel' AND "last_name" = 'Paige'
    )
);

-- write a SQL query to return the top 5 teams, sorted by the total number of hits by players in 2001.
-- Call the column representing total hits by players in 2001 “total hits”.
-- Sort by total hits, highest to lowest.
SELECT "name", SUM("H") AS "total hits"
FROM "teams"
JOIN "performances" ON "teams"."id" = "performances"."team_id"
WHERE "performances"."year" = 2001
GROUP BY "performances"."team_id"
ORDER BY "total hits" DESC
LIMIT 5;

-- write a SQL query to find the name of the player who’s been paid the highest salary, of all time, in Major League Baseball.
SELECT "first_name", "last_name"
FROM "players"
JOIN "salaries" ON "players"."id" = "salaries"."player_id"
GROUP BY "salary"
ORDER BY "salary" DESC
LIMIT 1;

-- write a SQL query to find the 2001 salary of the player who hit the most home runs in 2001.
SELECT "salaries"."salary"
FROM "salaries"
JOIN "performances" ON "salaries"."player_id" = "performances"."player_id"
WHERE "salaries"."year" = 2001
ORDER BY "performances"."HR" DESC
LIMIT 1;

-- write a SQL query to find the 5 lowest paying teams (by average salary) in 2001.
SELECT "teams"."name", AVG("salaries"."salary") AS "average salary"
FROM "teams"
JOIN "performances" ON "teams"."id" = "performances"."team_id"
JOIN "salaries" ON "teams"."id" = "salaries"."team_id"
WHERE "salaries"."year" = 2001
GROUP BY "salaries"."team_id"
ORDER BY "average salary"
LIMIT 5;

-- The general manager has asked you for a report which details each player’s name, their salary for each year they’ve been playing, and their number of home runs for each year they’ve been playing. 
-- To be precise, the table should include:
-- All player’s first names
-- All player’s last names
-- All player’s salaries
-- All player’s home runs
-- The year in which the player was paid that salary and hit those home runs
-- write a query to return just such a table.
-- Your query should return a table with five columns, per the above.
-- Order the results, first and foremost, by player’s IDs (least to greatest).
-- Order rows about the same player by year, in descending order.
-- Consider a corner case: suppose a player has multiple salaries or performances for a given year. 
-- Order them first by number of home runs, in descending order, followed by salary, in descending order.
-- Be careful to ensure that, for a single row, the salary’s year and the performance’s year match.
SELECT "players"."first_name", "players"."last_name", "salaries"."salary", "performances"."HR", "performances"."year"
FROM "players"
JOIN "salaries" ON "players"."id" = "salaries"."player_id"
JOIN "performances" ON "players"."id" = "performances"."player_id" AND "salaries"."year" = "performances"."year"
ORDER BY "players"."id", "salaries"."year" DESC, "performances"."HR" DESC, "salaries"."salary" DESC;

-- write a SQL query to find the 10 least expensive players per hit in 2001.
-- You can calculate the “dollars per hit” column by dividing a player’s 2001 salary by the number of hits they made in 2001. Recall you can use AS to rename a column.
-- Dividing a salary by 0 hits will result in a NULL value. Avoid the issue by filtering out players with 0 hits.
-- Sort the table by the “dollars per hit” column, least to most expensive. If two players have the same “dollars per hit”, order by first name, followed by last name, in alphabetical order.
-- Ensure that the salary’s year and the performance’s year match.
-- You may assume, for simplicity, that a player will only have one salary and one performance in 2001.
SELECT "players"."first_name", "players"."last_name", "salaries"."salary" / "performances"."H" AS "dollars per hit"
FROM "players"
JOIN "salaries" ON "players"."id" = "salaries"."player_id"
JOIN "performances" ON "players"."id" = "performances"."player_id" AND "salaries"."year" = "performances"."year"
WHERE "salaries"."year" = 2001 AND "dollars per hit" IS NOT NULL
ORDER BY "dollars per hit", "players"."first_name", "players"."last_name"
LIMIT 10;

-- write a SQL query to find the players among the 10 least expensive players per hit and among the 10 least expensive players per RBI in 2001.
-- You can calculate a player’s salary per RBI by dividing their 2001 salary by their number of RBIs in 2001.
-- You may assume, for simplicity, that a player will only have one salary and one performance in 2001.
-- Order your results by player ID, least to greatest (or alphabetically by last name, as both are the same in this case!).
SELECT "first_name", "last_name"
FROM (
    SELECT "first_name", "last_name", "id"
    FROM (
        SELECT "players"."first_name", "players"."last_name", "players"."id"
        FROM "players"
        JOIN "salaries" ON "players"."id" = "salaries"."player_id"
        JOIN "performances" ON "players"."id" = "performances"."player_id" AND "salaries"."year" = "performances"."year"
        WHERE "salaries"."year" = 2001 AND "salaries"."salary" / "performances"."H" IS NOT NULL
        ORDER BY "salaries"."salary" / "performances"."H"
        LIMIT 10
    )

    INTERSECT

    SELECT "first_name", "last_name", "id"
    FROM (
        SELECT "players"."first_name", "players"."last_name", "players"."id"
        FROM "players"
        JOIN "salaries" ON "players"."id" = "salaries"."player_id"
        JOIN "performances" ON "players"."id" = "performances"."player_id" AND "salaries"."year" = "performances"."year"
        WHERE "salaries"."year" = 2001 AND "salaries"."salary" / "performances"."RBI" IS NOT NULL
        ORDER BY "salaries"."salary" / "performances"."RBI"
        LIMIT 10
    )
)
ORDER BY "id";
