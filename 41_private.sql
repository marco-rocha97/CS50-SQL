-- Your task at hand is to decode the cipher left for you by the detective. 
-- How you do so is up to you, but you should ensure that—at the end of your process—you have a view structured as follows:
--     The view should be named message
--     The view should have a single column, phrase
--     When the following SQL query is executed on private.db, your view should return a single column in which each row is one phrase in the message.
CREATE VIEW "14" AS
SELECT "id", SUBSTR("sentence", 98, 4) AS "phrase"
FROM "sentences"
WHERE "id" = 14;

CREATE VIEW "114" AS
SELECT "id", SUBSTR("sentence", 3, 5) AS "phrase"
FROM "sentences"
WHERE "id" = 114;

CREATE VIEW "618" AS
SELECT "id", SUBSTR("sentence", 72, 9) AS "phrase"
FROM "sentences"
WHERE "id" = 618;

CREATE VIEW "630" AS
SELECT "id", SUBSTR("sentence", 7, 3) AS "phrase"
FROM "sentences"
WHERE "id" = 630;

CREATE VIEW "932" AS
SELECT "id", SUBSTR("sentence", 12, 5) AS "phrase"
FROM "sentences"
WHERE "id" = 932;

CREATE VIEW "2230" AS
SELECT "id", SUBSTR("sentence", 50, 7) AS "phrase"
FROM "sentences"
WHERE "id" = 2230;

CREATE VIEW "2346" AS
SELECT "id", SUBSTR("sentence", 44, 10) AS "phrase"
FROM "sentences"
WHERE "id" = 2346;

CREATE VIEW "3041" AS
SELECT "id", SUBSTR("sentence", 14, 5) AS "phrase"
FROM "sentences"
WHERE "id" = 3041;

CREATE VIEW "message" AS
SELECT * FROM "14"
UNION SELECT * FROM "114"
UNION SELECT * FROM "618"
UNION SELECT * FROM "630"
UNION SELECT * FROM "932"
UNION SELECT * FROM "2230"
UNION SELECT * FROM "2346"
UNION SELECT * FROM "3041";

SELECT "phrase" FROM "message";
