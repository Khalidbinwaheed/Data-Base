use UniversityGeographyDB;

CREATE TABLE countries (
    name VARCHAR(100) PRIMARY KEY,
    continent VARCHAR(50),
    capital VARCHAR(100),
    population BIGINT,
    region VARCHAR(50)
);

INSERT INTO countries VALUES
('Namibia', 'Africa', 'Windhoek', 2540916, 'Southern Africa'),
('Austria', 'Europe', 'Vienna', 8917205, 'Western Europe'),
('Brazil', 'South America', 'Brasília', 212559409, NULL),
('China', 'Asia', 'Beijing', 1439323776, NULL),
('India', 'Asia', 'New Delhi', 1380004385, NULL),
('Singapore', 'Asia', 'Singapore', 5685807, NULL),
('Vatican City', 'Europe', 'Vatican City', 825, NULL),
('Suriname', 'South America', 'Paramaribo', 586634, NULL),
('United States', 'North America', 'Washington, D.C.', 331002651, NULL),
('United Kingdom', 'Europe', 'London', 67886011, NULL);



CREATE TABLE cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(100),
    continent VARCHAR(50),
    population BIGINT,
    latitude DECIMAL(10,6),
    FOREIGN KEY (country) REFERENCES countries(name)
);

INSERT INTO cities VALUES
(NULL, 'Windhoek', 'Namibia', 'Africa', 431000, -22.5609),
(NULL, 'Vienna', 'Austria', 'Europe', 1897000, 48.2082),
(NULL, 'Salzburg', 'Austria', 'Europe', 155000, 47.8095),
(NULL, 'Graz', 'Austria', 'Europe', 289440, 47.0707),
(NULL, 'Rio de Janeiro', 'Brazil', 'South America', 6748000, -22.9068),
(NULL, 'São Paulo', 'Brazil', 'South America', 12330000, -23.5505),
(NULL, 'Beijing', 'China', 'Asia', 21710000, 39.9042),
(NULL, 'Shanghai', 'China', 'Asia', 26320000, 31.2304),
(NULL, 'Mumbai', 'India', 'Asia', 12442373, 19.0760),
(NULL, 'Singapore', 'Singapore', 'Asia', 5685807, 1.3521),
(NULL, 'Paramaribo', 'Suriname', 'South America', 223757, 5.8520),
(NULL, 'New York City', 'United States', 'North America', 8419000, 40.7128),
(NULL, 'London', 'United Kingdom', 'Europe', 8982000, 51.5074),
(NULL, 'Manchester', 'United Kingdom', 'Europe', 547627, 53.4808),
(NULL, 'Birmingham', 'United Kingdom', 'Europe', 1149000, 52.4862),
(NULL, 'Anomaly City', 'Vatican City', 'Europe', 900, 41.9029),  -- Purposely larger than country
(NULL, 'Another Anomaly', 'Vatican City', 'Europe', 850, 41.9029); -- Purposely larger than country

-- Add some NULL values for the lab exercises
UPDATE cities SET region = NULL WHERE name = 'Windhoek';
UPDATE countries SET capital = 'Missing Capital' WHERE name = 'Suriname';

-- Verify tables were created
SHOW TABLES;

-- Verify data was inserted
SELECT * FROM countries;
SELECT * FROM cities;

-- Verify the anomaly cities (should show 2 cities larger than Vatican City)
SELECT ci.name AS city_name, ci.population AS city_pop, 
       co.name AS country_name, co.population AS country_pop
FROM cities ci
JOIN countries co ON ci.country = co.name
WHERE ci.population > co.population;



SELECT country, continent 
FROM cities 
WHERE name = 'Windhoek';

SELECT name 
FROM cities 
WHERE country = 'Austria';

SELECT continent, COUNT(*) AS city_count
FROM cities
GROUP BY continent;

SELECT country, COUNT(*) AS city_count
FROM cities
WHERE continent = 'South America'
GROUP BY country;


SELECT c.name AS country, COUNT(ci.name) AS city_count
FROM countries c
LEFT JOIN cities ci ON c.name = ci.country AND ci.continent = 'South America'
WHERE c.continent = 'South America'
GROUP BY c.name;



SELECT name, population, 'country' AS type
FROM countries
WHERE population > 1000000000
UNION
SELECT name, population, 'city' AS type
FROM cities
WHERE population > 12000000
ORDER BY population DESC;

SELECT continent, COUNT(*) AS southern_city_count
FROM cities
WHERE latitude < 0
GROUP BY continent;

SELECT ci.name AS city_name, ci.population AS city_pop, 
       co.name AS country_name, co.population AS country_pop
FROM cities ci
JOIN countries co ON ci.country = co.name
WHERE ci.population > co.population;

SELECT ci.name AS city_name, ci.country, 
       (ci.population * 1.0 / co.population) AS population_ratio
FROM cities ci
JOIN countries co ON ci.country = co.name
ORDER BY population_ratio DESC
LIMIT 10;

SELECT co.name AS country, co.capital
FROM countries co
LEFT JOIN cities ci ON co.capital = ci.name AND co.name = ci.country
WHERE co.continent = 'Europe' AND ci.name IS NULL;