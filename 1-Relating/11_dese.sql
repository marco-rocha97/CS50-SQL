-- write a SQL query to find the names and cities of all public schools in Massachusetts.
select "name", "city" from "schools"
where "type" = 'Public School';

-- write a SQL query to find the names of districts that are no longer operational.
SELECT "name" FROM "districts"
WHERE "name" LIKE '%(non-op)%';

-- write a SQL query to find the average per-pupil expenditure. Name the column “Average District Per-Pupil Expenditure”.
SELECT AVG("per_pupil_expenditure") AS "Average District Per-Pupil Expenditure" FROM "expenditures";

-- write a SQL query to find the 10 cities with the most public schools. 
-- Your query should return the names of the cities and the number of public schools within them, ordered from greatest number of public schools to least. 
-- If two cities have the same number of public schools, order them alphabetically.
SELECT "city", COUNT("type") 
FROM "schools" 
WHERE "type" = 'Public School' 
GROUP BY "city" 
ORDER BY COUNT("type") DESC, "city"
LIMIT 10;

-- write a SQL query to find cities with 3 or fewer public schools. 
-- Your query should return the names of the cities and the number of public schools within them, ordered from greatest number of public schools to least. 
-- If two cities have the same number of public schools, order them alphabetically.
SELECT "city", COUNT("type") 
FROM "schools" 
WHERE "type" = 'Public School' 
GROUP BY "city" 
HAVING COUNT("type") <= 3 
ORDER BY COUNT("type") DESC, "city";

-- write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.
SELECT "name" FROM "schools"
WHERE "id" IN (
    SELECT "school_id" FROM "graduation_rates"
    WHERE "graduated" = 100
);

-- write a SQL query to find the names of all schools in the Cambridge school district.
SELECT "name" FROM "schools"
WHERE "district_id" = (
    SELECT "id" FROM "districts"
    WHERE "name" = 'Cambridge'
);

-- write a SQL query to display the names of all school districts and the number of pupils enrolled in each.
SELECT "name", "pupils"
FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id";

-- write a SQL query to find the name (or names) of the school district(s) with the single least number of pupils. 
-- Report only the name(s).
SELECT "name"
FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
ORDER BY "pupils"
LIMIT 1;

-- write a SQL query to find the 10 public school districts with the highest per-pupil expenditures. 
-- Your query should return the names of the districts and the per-pupil expenditure for each.
SELECT "name", "per_pupil_expenditure"
FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
WHERE "type" LIKE 'Public School%'
ORDER BY "per_pupil_expenditure" DESC
LIMIT 10;

-- write a SQL query to display the names of schools, their per-pupil expenditure, and their graduation rate. 
-- Sort the schools from greatest per-pupil expenditure to least. 
-- If two schools have the same per-pupil expenditure, sort by school name.
SELECT "name", "per_pupil_expenditure", "graduated"
FROM "schools"
JOIN "graduation_rates" ON "schools"."id" = "graduation_rates"."school_id"
JOIN "expenditures" ON "schools"."district_id" = "expenditures"."district_id"
ORDER BY "per_pupil_expenditure" DESC, "name";

-- write a SQL query to find public school districts with above-average per-pupil expenditures and an above-average percentage of teachers rated “exemplary”. 
-- Your query should return the districts’ names, along with their per-pupil expenditures and percentage of teachers rated exemplary. 
-- Sort the results first by the percentage of teachers rated exemplary (high to low), then by the per-pupil expenditure (high to low).
SELECT "districts"."name", "expenditures"."per_pupil_expenditure", "staff_evaluations"."exemplary"
FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
JOIN "staff_evaluations" ON "districts"."id" = "staff_evaluations"."district_id"
WHERE "districts"."type" = 'Public School District'
    AND "per_pupil_expenditure" >= (
        SELECT AVG("per_pupil_expenditure") FROM "expenditures"
    )
    AND "exemplary" >= (
        SELECT AVG("exemplary") FROM "staff_evaluations"
    )
ORDER BY "exemplary" DESC, "per_pupil_expenditure" DESC;
