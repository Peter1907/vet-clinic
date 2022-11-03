/* Populate database with sample data. */
-- animals table
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

-- owners table
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
