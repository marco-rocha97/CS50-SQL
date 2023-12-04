-- QUESTION 1
-- At what type of address did the Lost Letter end up?: Residential
-- At what address did the Lost Letter end up?: 2 Finnigan Street
-- FinnIgan and not FinnEgan, so it's possible to use LIKE statement
SELECT *
FROM scans
WHERE package_id = (
    SELECT id
    FROM packages
    WHERE from_address_id = (SELECT id FROM addresses WHERE address = '900 Somerville Avenue')
    AND to_address_id = (SELECT id FROM addresses WHERE address = '2 Finnigan Street')
);

SELECT type
FROM addresses
WHERE address = '2 Finnigan Street';

-- QUESTION 2
-- At what type of address did the Devious Delivery end up?: Police Station
-- What were the contents of the Devious Delivery?: Duck debugger
SELECT type
FROM addresses
WHERE id = (
    SELECT address_id
    FROM scans
    WHERE package_id = (
        SELECT id
        FROM packages
        WHERE from_address_id IS NULL
    )
    ORDER BY timestamp DESC
    LIMIT 1
);

SELECT contents
FROM packages
WHERE from_address_id IS NULL;

-- QUESTION 3
-- What are the contents of the Forgotten Gift?: Flowers
-- Who has the Forgotten Gift?: Mikel
SELECT contents
FROM packages
WHERE from_address_id = (
    SELECT id
    FROM addresses
    WHERE address = '109 Tileston Street'
);

SELECT name
FROM drivers
WHERE id = (
    SELECT driver_id
    FROM scans
    WHERE package_id = (
        SELECT id
        FROM packages
        WHERE from_address_id = (
            SELECT id
            FROM addresses
            WHERE address = '109 Tileston Street'
        )
    )
    ORDER BY timestamp DESC
    LIMIT 1
);
