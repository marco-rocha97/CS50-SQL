-- Your task at hand is to create a MySQL database for LinkedIn from scratch. 
-- The implementation details are up to you, though you should minimally ensure that your database meets the platform’s specification and that it can represent the given sample data. 
-- You’re welcome to use, or improve upon, your design of a SQLite database—just keep in mind that you’ll now have a new set of types at your disposal!

-- Platform
-- Users
-- The heart of LinkedIn’s platform is its people. 
-- Your database should be able to represent the following information about LinkedIn’s users:
--     Their first and last name
--     Their username
--     Their password
--     Keep in mind that, if a company is following best practices, application passwords are “hashed.” 
--     No need to worry about hashing passwords here, though it might be helpful to know that some hashing algorithms can produce strings up to 128 characters long.
CREATE TABLE "users" (
    "id" INT AUTO_INCREMENT,
    "first_name" VARCHAR(32) NOT NULL,
    "last_name" VARCHAR(32) NOT NULL,
    "username" VARCHAR(32) NOT NULL UNIQUE,
    "password" VARCHAR(128) NOT NULL,
    PRIMARY KEY("id")
);

-- Schools and Universities
-- LinkedIn also allows for official school or university accounts, such as that for Harvard, so alumni (i.e., those who’ve attended) can identify their affiliation. 
-- Ensure that LinkedIn’s database can store the following information about each school:
--     The name of the school
--     The type of school
--     The school’s location
--     The year in which the school was founded
--     You should assume that LinkedIn only allows schools to choose one of three types: “Primary,” “Secondary,” and “Higher Education.”
CREATE TABLE "schools" (
    "id" INT AUTO_INCREMENT,
    "name" VARCHAR(32) NOT NULL,
    "type" ENUM('Primary', 'Secondary', 'Higher Education') NOT NULL,
    "location" VARCHAR(32) NOT NULL,
    "year" TINYINT NOT NULL,
    PRIMARY KEY("id")
);

-- Companies
-- LinkedIn allows companies to create their own pages, like the one for LinkedIn itself, so employees can identify their past or current employment with the company. 
-- Ensure that LinkedIn’s database can store the following information for each company:
--     The name of the company
--     The company’s industry
--     The company’s location
--     You should assume that LinkedIn only allows companies to choose from one of three industries: “Technology,” “Education,” and “Business.”
CREATE TABLE "companies" (
    "id" INT AUTO_INCREMENT,
    "name" VARCHAR(32) NOT NULL,
    "industry" ENUM('Technology', 'Education', 'Higher Business') NOT NULL,
    "location" VARCHAR(32) NOT NULL,
    PRIMARY KEY("id")
);

-- Connections
-- And finally, the essence of LinkedIn is its ability to facilitate connections between people. 
-- Ensure LinkedIn’s database can support each of the following connections.

-- Connections with People
-- LinkedIn’s database should be able to represent mutual (reciprocal, two-way) connections between users. 
-- No need to worry about one-way connections user A “following” user B without user B “following” user A.
CREATE TABLE "people_connections" (
    "id" INT AUTO_INCREMENT,
    "user_id_a" INT NOT NULL,
    "user_id_b" INT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id_a") REFERENCES "users"("id"),
    FOREIGN KEY("user_id_b") REFERENCES "users"("id")
);

-- Connections with Schools
-- A user should be able to create an affiliation with a given school. 
-- And similarly, that school should be able to find its alumni. Additionally, allow a user to define:
--     The start date of their affiliation (i.e., when they started to attend the school)
--     The end date of their affiliation (i.e., when they graduated), if applicable
--     The type of degree earned/pursued (e.g., “BA”, “MA”, “PhD”, etc.)
CREATE TABLE "schoools_connections" (
    "id" INT AUTO_INCREMENT,
    "user_id" INT NOT NULL,
    "school_id" INT NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE,
    "type" ENUM('BA', 'MA', 'PhD'),
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("school_id") REFERENCES "schools"("id")
);

-- Connections with Companies
-- A user should be able to create an affiliation with a given company. 
-- And similarly, a company should be able to find its current and past employees. Additionally, allow a user to define:
--     The start date of their affiliation (i.e., the date they began work with the company)
--     The end date of their affiliation (i.e., when left the company), if applicable
CREATE TABLE "companies_connections" (
    "id" INT AUTO_INCREMENT,
    "user_id" INT NOT NULL,
    "companies_id" INT NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("companies_id") REFERENCES "companies"("id")
);
