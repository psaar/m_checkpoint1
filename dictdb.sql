CREATE DATABASE dictdb;
CREATE TABLE dictionary (id SERIAL PRIMARY KEY, english_word VARCHAR(100) NOT NULL, local_translation VARCHAR(100) NOT NULL);
