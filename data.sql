/* Populate database with sample data. */
INSERT INTO animals VALUES(default, 'Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals VALUES(default, 'Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals VALUES(default, 'Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals VALUES(default, 'Devimon', '2017-05-12', 5, true, 11);
INSERT INTO animals VALUES(default, 'Charmander', '2020-02-08', 0, false, -11);
INSERT INTO animals VALUES(default, 'Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO animals VALUES(default, 'Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals VALUES(default, 'Angemon', '2005-06-12', 1, true, -45);
INSERT INTO animals VALUES(default, 'Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals VALUES(default, 'Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals VALUES(default, 'Ditto', '2022-05-14', 4, true, 22);

INSERT INTO owners (full_name, age) VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES
  ('Pokemon'),
  ('Digimon');

BEGIN;
  UPDATE animals
  SET species_id = species.id
  FROM species
  WHERE animals.name LIKE '%mon' AND species.name = 'Digimon';
COMMIT;
BEGIN;
  UPDATE animals
  SET species_id = species.id
  FROM species
  WHERE animals.name NOT LIKE '%mon' AND species.name = 'Pokemon';
COMMIT;
BEGIN;
  UPDATE animals
  SET owner_id = owners.id
  FROM owners
  WHERE animals.name = 'Agumon' AND owners.full_name = 'Sam Smith';
  UPDATE animals
  SET owner_id = owners.id
  FROM owners
  WHERE animals.name IN ('Gabumon', 'Pikachu') AND owners.full_name = 'Jennifer Orwell';
  UPDATE animals
  SET owner_id = owners.id
  FROM owners
  WHERE animals.name IN ('Devimon', 'Plantmon') AND owners.full_name = 'Bob';
  UPDATE animals
  SET owner_id = owners.id
  FROM owners
  WHERE animals.name IN ('Charmander', 'Squirtle', 'Blossom') AND owners.full_name = 'Melody Pond';
  UPDATE animals
  SET owner_id = owners.id
  FROM owners
  WHERE animals.name IN ('Angemon', 'Boarmon') AND owners.full_name = 'Dean Winchester';
COMMIT;

INSERT INTO vets (name, age, date_of_graduation) VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations VALUES
  ('William Tatcher', 'Pokemon'),
  ('Stephanie Mendez', 'Digimon'),
  ('Stephanie Mendez', 'Pokemon'),
  ('Jack Harkness', 'Digimon');

INSERT INTO visits VALUES
  ('Agumon', 'William Tatcher', '2020-05-24'),
  ('Agumon', 'Stephanie Mendez', '2020-07-22'),
  ('Gabumon', 'Jack Harkness', '2021-02-02'),
  ('Pikachu', 'Maisy Smith', '2020-01-05'),
  ('Pikachu', 'Maisy Smith', '2020-03-08'),
  ('Pikachu', 'Maisy Smith', '2020-05-14'),
  ('Devimon', 'Stephanie Mendez', '2021-05-04'),
  ('Charmander', 'Jack Harkness', '2021-02-24'),
  ('Plantmon', 'Maisy Smith', '2019-12-21'),
  ('Plantmon', 'William Tatcher', '2020-08-10'),
  ('Plantmon', 'Maisy Smith', '2021-04-07'),
  ('Squirtle', 'Stephanie Mendez', '2019-09-29'),
  ('Angemon', 'Jack Harkness', '2020-10-03'),
  ('Angemon', 'Jack Harkness', '2020-11-04'),
  ('Boarmon', 'Maisy Smith', '2019-01-24'),
  ('Boarmon', 'Maisy Smith', '2019-05-15'),
  ('Boarmon', 'Maisy Smith', '2020-02-27'),
  ('Boarmon', 'Maisy Smith', '2020-08-03'),
  ('Blossom', 'Stephanie Mendez', '2020-05-24'),
  ('Blossom', 'William Tatcher', '2021-01-11');
