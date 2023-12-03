-- write a SQL query that a translator might take interest in: list, side by side, the Japanese title and the English title for each print. Ensure the Japanese title is the first column, followed by the English title.
SELECT "japanese_title", "english_title" FROM "views";

-- write a SQL query to list the average colors of prints by Hokusai that include “river” in the English title. (As an aside, do they have any hint of blue?)
SELECT "average_color" FROM "views" WHERE "artist" = 'Hokusai' AND "english_title" LIKE '%river%';

-- write a SQL query to count how many prints by Hokusai include “Fuji” in the English title. Though all of Hokusai’s prints focused on Mt. Fuji, in how many did “Fuji” make it into the title?
SELECT COUNT(*) FROM "views" WHERE "artist" = 'Hokusai' AND "english_title" LIKE '%fuji%';

-- write a SQL query to count how many prints by Hiroshige have English titles that refer to the “Eastern Capital”. Hiroshige’s prints were created in Japan’s “Edo period,” referencing the eastern capital city of Edo, now Tokyo.
SELECT COUNT(*) FROM "views" WHERE "artist" = 'Hiroshige' AND "english_title" LIKE '%Eastern Capital%';

-- write a SQL query to find the highest contrast value of prints by Hokusai. Name the column “Maximum Contrast”. Does Hokusai’s prints most contrasting print actually have much contrast?
SELECT MAX("contrast") AS 'Maximum Contrast' FROM "views" WHERE "artist" = 'Hokusai';

-- write a SQL query to find the average entropy of prints by Hiroshige, rounded to two decimal places. Call the resulting column “Hiroshige Average Entropy”.
SELECT ROUND(AVG("entropy"), 2) AS 'Hiroshige Average Entropy' FROM "views" WHERE "artist" = 'Hiroshige';

-- write a SQL query to list the English titles of the 5 brightest prints by Hiroshige, from most to least bright. Compare them to this list on Wikipedia to see if your results match the print’s aesthetics.
SELECT "english_title" FROM "views" WHERE "artist" = 'Hokusai' ORDER BY "contrast" LIMIT 5;

-- write a SQL query to list the English titles of the 5 prints with the least contrast by Hokusai, from least to highest contrast. Compare them to this list on Wikipedia to see if your results match the print’s aesthetics.
SELECT "english_title", "artist" FROM "views" ORDER BY "brightness" DESC LIMIT 1;

-- write a SQL query to find the English title and artist of the print with the highest brightness.
SELECT "english_title" AS 'English Title' FROM "views" WHERE "contrast" BETWEEN 0.4 AND 0.6 ORDER BY "brightness";
