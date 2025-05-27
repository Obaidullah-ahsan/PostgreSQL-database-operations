-- Active: 1747415128892@@127.0.0.1@5432@conservation_db

-- Create Ranger table

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(100) NOT NULL
)

-- Create Species table

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL CHECK (conservation_status IN ('Endangered' ,'Vulnerable', 'Historic'))
)


-- Create Sightings table

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers(ranger_id),
    species_id INTEGER REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(100) NOT NULL,
    notes TEXT
)

drop Table species;
drop Table sightings;

-- Insert data into rangers
INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range');

-- Insert data into species
INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- Insert data into sightings
INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


-- Problem 1
INSERT INTO rangers(ranger_id, name, region) VALUES(4,'Derek Fox', 'Coastal Plains')

-- Problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

-- Problem 3
SELECT * FROM sightings
    WHERE location LIKE '%Pass%'

-- problem 4
SELECT name, COUNT(*) FROM sightings
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
GROUP BY name


-- Problem 5
SELECT common_name FROM sightings
RIGHT JOIN species ON sightings.species_id = species.species_id
WHERE sighting_id  IS NULL


-- problem 6
SELECT common_name, sighting_time, name FROM sightings
JOIN species ON sightings.species_id = species.species_id 
JOIN rangers ON sightings.ranger_id = rangers.ranger_id 
ORDER BY sighting_time DESC 
LIMIT 2

UPDATE species
set conservation_status = 'Historic'
WHERE extract(YEAR FROM discovery_date) < 1800
 

