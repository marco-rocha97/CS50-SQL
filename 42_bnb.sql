-- write a SQL statement to create each of the following views of the data in bnb.db. 
-- Note that, while views can be created from other views, each of your views should stand alone (i.e., not rely on a prior view).

-- No Descriptions
-- You might notice that when running
-- SELECT * FROM "listings" LIMIT 5;
-- the results look quite wonky! The description column contains descriptions with many line breaks, each of which are printed to your terminal.
-- write a SQL statement to create a view named no_descriptions that includes all of the columns in the listings table except for description.
CREATE VIEW "no_descriptions" AS
SELECT "id", "property_type", "host_name", "accommodates", "bedrooms" FROM "listings";

-- One-Bedrooms
-- In one_bedrooms.sql, write a SQL statement to create a view named one_bedrooms. This view should contain all listings that have exactly one bedroom. Ensure the view contains the following columns:
--     id, which is the id of the listing from the listings table.
--     property_type, from the listings table.
--     host_name, from the listings table.
--     accommodates, from the listings table.
CREATE VIEW "one_bedrooms" AS
SELECT "id", "property_type", "host_name", "host_name" FROM "listings"
WHERE "bedrooms" = 1;

-- Available
-- write a SQL statement to create a view named available. This view should contain all dates that are available at all listings. Ensure the view contains the following columns:
--     id, which is the id of the listing from the listings table.
--     property_type, from the listings table.
--     host_name, from the listings table.
--     date, from the availabilities table, which is the date of the availability.
CREATE VIEW "available" AS
SELECT "listing_id" AS "id", "property_type", "host_name", "date" FROM "listings"
JOIN "availabilities" ON "listings"."id" = "availabilities"."listing_id"
WHERE "available" = 'TRUE';

-- Frequently Reviewed
-- write a SQL statement to create a view named frequently_reviewed. This view should contain the 100 most frequently reviewed listings, sorted from most- to least-frequently reviewed. Ensure the view contains the following columns:
--     id, which is the id of the listing from the listings table.
--     property_type, from the listings table.
--     host_name, from the listings table.
--     reviews, which is the number of reviews the listing has received.
--     If any two listings have the same number of reviews, sort by property_type (in alphabetical order), followed by host_name (in alphabetical order).
CREATE VIEW "frequently_reviewed" AS
SELECT "listing_id" AS "id", "property_type", "host_name", COUNT("date") AS "reviews" FROM "listings"
JOIN "reviews" ON "listings"."id" = "reviews"."listing_id"
GROUP BY "listing_id"
ORDER BY "reviews" DESC, "property_type", "host_name"
LIMIT 100;

-- June Vacancies
-- write a SQL statement to create a view named june_vacancies. This view should contain all listings and the number of days in June of 2023 that they remained vacant. Ensure the view contains the following columns:
--     id, which is the id of the listing from the listings table.
--     property_type, from the listings table.
--     host_name, from the listings table.
--     days_vacant, which is the number of days in June of 2023, that the given listing was marked as available.
CREATE VIEW "june_vacancies" AS
SELECT "listing_id" AS "id", "property_type", "host_name", COUNT("date") AS "days_vacant" FROM "listings"
JOIN "availabilities" ON "listings"."id" = "availabilities"."listing_id"
WHERE "date" LIKE '2023-06%' AND "available" = 'TRUE'
GROUP BY "listing_id";
