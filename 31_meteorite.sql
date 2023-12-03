-- write a series of SQL (and SQLite) statements to import and clean the data from meteorites.csv into a table, meteorites, in a database called meteorites.db.

-- Keep in mind that not all columns in the CSV should end up in the final table!

-- To consider the data in the meteorites table clean, you should ensure…

-- Any empty values in meteorites.csv are represented by NULL in the meteorites table.
-- Keep in mind that the mass, year, lat, and long columns have empty values in the CSV.
-- All columns with decimal values (e.g., 70.4777) should be rounded to the nearest hundredths place (e.g., 70.4777 becomes 70.48).
-- Keep in mind that the mass, lat, and long columns have decimal values.
-- All meteorites with the nametype “Relict” are not included in the meteorites table.
-- The meteorites are sorted by year, oldest to newest, and then—if any two meteorites landed in the same year—by name, in alphabetical order.
-- You’ve updated the IDs of the meteorites from meteorites.csv, according to the order specified in #4.
-- The id of the meteorites should start at 1, beginning with the meteorite that landed in the oldest year and is the first in alphabetical order for that year.
CREATE TABLE "meteorites_temp" (
    "name" TEXT,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY ("id")
);

.import --csv --skip 1 meteorites.csv meteorites_temp

UPDATE "meteorites_temp"
SET "mass" = NULL
WHERE "mass" = 0;

UPDATE "meteorites_temp"
SET "year" = NULL
WHERE "year" = 0;

UPDATE "meteorites_temp"
SET "year" = NULL
WHERE "year" LIKE '';

UPDATE "meteorites_temp"
SET "lat" = NULL
WHERE "lat" = 0;

UPDATE "meteorites_temp"
SET "long" = NULL
WHERE "long" = 0;

UPDATE "meteorites_temp"
SET "mass" = ROUND("mass", 2),
    "lat" = ROUND("lat", 2),
    "long" = ROUND("long", 2);

DELETE FROM "meteorites_temp"
WHERE "nametype" LIKE 'Relict';

CREATE TABLE "meteorites" (
    "id" INTEGER,
    "name" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY ("id")
);

INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long"
FROM "meteorites_temp"
ORDER BY "year", "name";
