CREATE DATABASE dictdb;
CREATE TABLE dictionary (id SERIAL PRIMARY KEY, english_word VARCHAR(100) NOT NULL, local_translation VARCHAR(100) NOT NULL);
INSERT INTO dictionary (english_word, local_translation) VALUES ('coffee', 'kaffe');