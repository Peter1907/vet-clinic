/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
  UPDATE animals
  SET species = 'digimon'
  WHERE name LIKE '%mon';
  UPDATE animals
  SET species = 'pokemon'
  WHERE species = '';
COMMIT;

BEGIN;
  DELETE FROM animals;
ROLLBACK;

BEGIN;
  DELETE FROM animals
  WHERE date_of_birth > '2022-01-01';
  SAVEPOINT SP1;
  UPDATE animals
  set weight_kg = weight_kg * -1;
  ROLLBACK TO SP1;
  UPDATE animals
  SET weight_kg = weight_kg * -1
  WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(id) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts > 0;
SELECT AVG(weight_kg) FROM animals;
SELECT COUNT(escape_attempts), neutered FROM animals GROUP BY neutered;
SELECT AVG(escape_attempts), species FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

SELECT name, date_of_birth, escape_attempts,neutered, weight_kg, full_name AS owner 
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, date_of_birth, escape_attempts,neutered, weight_kg, species.name AS type
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT ALL full_name AS owner, name as animals
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
WHERE owners.full_name LIKE '%%';

SELECT species.name as species, COUNT(species_id)
FROM species
JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT owners.full_name AS owner, animals.name AS Digimons
FROM animals
RIGHT JOIN owners ON owners.id = animals.owner_id
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT owners.full_name AS owner, animals.name AS "animals haven't tried to escape"
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE animals.escape_attempts = 0 AND owners.full_name LIKE '%Dean%';

SELECT owners.full_name, COUNT(animals.id) AS "count of animals owned"
FROM owners
JOIN animals ON owner_id = owners.id
GROUP BY owners.full_name
ORDER BY "count of animals owned" DESC LIMIT 1;
