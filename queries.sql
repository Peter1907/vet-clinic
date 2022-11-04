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

SELECT animal_name AS "last seen animal", MAX(date) as date
FROM visits
WHERE vet_name = 'William Tatcher'
GROUP BY animal_name
ORDER BY date DESC LIMIT 1;

SELECT animal_name AS "animals seen", COUNT(animal_name) AS "visits count"
FROM visits
WHERE vet_name = 'Stephanie Mendez'
GROUP BY animal_name;

SELECT vets.name AS "vet name", specializations.speciality
FROM vets LEFT JOIN specializations
ON vets.name = specializations.vet_name;

SELECT animal_name AS "animals seen", visits.date
FROM visits
WHERE vet_name = 'Stephanie Mendez' AND
visits.date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animal_name, COUNT(date) AS "number of visits"
FROM visits
GROUP BY animal_name
ORDER BY "number of visits" DESC LIMIT 1;

SELECT animal_name AS "first animal seen", MIN(date) as date
FROM visits
WHERE vet_name = 'Maisy Smith'
GROUP BY animal_name
ORDER BY date ASC LIMIT 1;

SELECT visits.date as "date of last visit", visits.animal_name,
vets.name AS vet, vets.age, vets.date_of_graduation,
specializations.speciality
FROM visits
JOIN vets ON visits.vet_name = vets.name
JOIN specializations ON visits.vet_name = specializations.vet_name
WHERE vets.name = 'William Tatcher'
ORDER BY "date of last visit" DESC LIMIT 1;

SELECT COUNT(visits.vet_name) AS "Unspecialized visits", specializations.speciality AS "species",
specializations.vet_name
FROM visits
JOIN specializations ON visits.vet_name = specializations.vet_name
JOIN animals ON visits.animal_name = animals.name
WHERE specializations.speciality_id != animals.species_id
GROUP BY animals.species_id, specializations.vet_name, "species";

SELECT COUNT(visits.animal_name) AS "max number of visits",
species.name AS "should get a speciality in:"
FROM visits
JOIN animals ON animals.name = visits.animal_name
JOIN species ON animals.species_id = species.id
WHERE visits.vet_name = 'Maisy Smith'
GROUP BY species.name
ORDER BY "max number of visits" DESC LIMIT 1;
