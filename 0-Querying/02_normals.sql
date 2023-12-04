-- write a SQL query to find the normal ocean surface temperature in the Gulf of Maine, off the coast of Massachusetts. To find this temperature, look at the data associated with 42.5° of latitude and -69.5° of longitude.
SELECT "0m" FROM "normals" WHERE "latitude" = '42.5' AND "longitude" = '-69.5';

-- write a SQL query to find the normal temperature of the deepest sensor near the Gulf of Maine, at the same coordinate above.
SELECT "225m" FROM "normals" WHERE "latitude" = '42.5' AND "longitude" = '-69.5';

-- choose a location of your own and write a SQL query to find the normal temperature at 0 meters, 100 meters, and 200 meters. You might find Google Earth helpful if you’d like to find some coordinates to use!
SELECT "0m", "100m", "200m" FROM "normals" WHERE "latitude" = '42.5' AND "longitude" = '-69.5';

-- write a SQL query to find the lowest normal ocean surface temperature.
SELECT "0m" FROM "normals" ORDER BY "0m" LIMIT 1;

-- write a SQL query to find the highest normal ocean surface temperature.
SELECT "0m" FROM "normals" ORDER BY "0m" DESC LIMIT 1;

-- write a SQL query to return all normal ocean temperatures at 50m of depth, as well as their respective degrees of latitude and longitude, within the Arabian Sea. Include latitude, longitude, and temperature columns. For simplicity, assume the Arabian Sea is encased in the following four coordinates:
-- 20° of latitude, 55° of longitude
-- 20° of latitude, 75° of longitude
-- 0° of latitude, 55° degrees of longitude
-- 0° of latitude, 75° degrees of longitude
SELECT "50m", latitude, longitude FROM normals WHERE (latitude BETWEEN '0' AND '20') AND (longitude BETWEEN '55' AND '75');

-- write a SQL query to find the average ocean surface temperature, rounded to two decimal places, along the equator. Call the resulting column “Average Equator Ocean Surface Temperature”.
SELECT ROUND(AVG("0m"), 2) AS 'Average Equator Ocean Surface Temperature' FROM "normals" WHERE "latitude" BETWEEN '-0.5' AND '0.5';

-- write a SQL query to find the 10 locations with the lowest normal ocean surface temperature, sorted coldest to warmest. If two locations have the same normal ocean surface temperature, sort by latitude, smallest to largest. Include latitude, longitude, and surface temperature columns.
SELECT "latitude", "longitude", "0m" FROM "normals" ORDER BY "0m", "latitude", "longitude" LIMIT 10;

-- write a SQL query to find the 10 locations with the highest normal ocean surface temperature, sorted warmest to coldest. If two locations have the same normal ocean surface temperature, sort by latitude, smallest to largest. Include latitude, longitude, and surface temperature columns.
SELECT "latitude", "longitude", "0m" FROM "normals" ORDER BY "0m" DESC, "latitude", "longitude" LIMIT 10;

-- write a SQL query to determine how many points of latitude we have at least one data point for. (Why might we not have data points for all latitudes?)
SELECT COUNT(DISTINCT "latitude") FROM "normals";
