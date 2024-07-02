DROP VIEW IF EXISTS view_contacts;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS contact_types;
DROP TABLE IF EXISTS contact_categories;

-- creating contact_categories table
CREATE TABLE contact_categories (
	id SERIAL PRIMARY KEY,
	contact_category VARCHAR(50) NOT NULL
);

-- creating the contact_types table
CREATE TABLE contact_types (
	id SERIAL PRIMARY KEY,
	contact_type VARCHAR(50) NOT NULL
);

-- creating the contacts table
CREATE TABLE contacts (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	title VARCHAR(50),
	organization VARCHAR(100),
	contact_type_id INTEGER,
	contact_category_id INTEGER,
	FOREIGN KEY (contact_type_id) REFERENCES contact_types(id),
	FOREIGN KEY (contact_category_id) REFERENCES contact_categories(id)
);

-- creating the items table
CREATE TABLE items (
	contact VARCHAR(100) UNIQUE,
	contact_id INTEGER,
	contact_type_id INTEGER,
	contact_category_id INTEGER,
	FOREIGN KEY (contact_id) REFERENCES contacts(id),
	FOREIGN KEY (contact_type_id) REFERENCES contact_types(id),
	FOREIGN KEY (contact_category_id) REFERENCES contact_categories(id)
);

-- inserting data into contact_categories
INSERT INTO contact_categories (contact_category) VALUES
	('Home'),
	('Work'),
	('Fax');

-- inserting data into contact_types
INSERT INTO contact_types (contact_type) VALUES 
	('Email'),
	('Phone'),
	('Skype'),
	('Instagram');

-- inserting data into contacts
INSERT INTO contacts (first_name, last_name, title, organization) VALUES
	('Erik', 'Eriksson', 'Teacher', 'Utbildning AB'),
	('Anna', 'Sundh', NULL, NULL),
	('Goran', 'Bregovic', 'Coach', 'Dalens IK'),
	('Ann-Marie', 'Bergqvist', 'Cousin', NULL),
	('Herman', 'Appelkvist', NULL, NULL);

-- inserting data into items
INSERT INTO items (contact, contact_id, contact_type_id, contact_category_id) VALUES
	('011-12 33 45', 3, 2, 1),
	('goran@infoab.se', 3, 1, 2),
	('010-88 55 44', 4, 2, 2),
	('erik57@hotmail.com', 1, 1, 1),
	('@annapanna99', 2, 4, 1),
	('077-563578', 2, 2, 1),
	('070-156 22 78', 3, 2, 2);

-- inserting myself into the contacts table
INSERT INTO contacts (first_name, last_name, title, organization, contact_type_id, contact_category_id) VALUES
	('Petter', 'Saarela', 'Manager/technical coordinator', 'Kulturhuset Stadsteatern', 1, 2);

-- adding item for my contact
INSERT INTO items (contact_id, contact) VALUES
	((SELECT id FROM contacts WHERE first_name = 'Petter' AND last_name = 'Saarela'), 'petter.saarela@kulturhusetstadsteatern.se');

-- Query for unused contact types
-- SELECT ct.contact_type
-- FROM contact_types ct
-- LEFT JOIN items i ON ct.id = i.contact_type_id
-- WHERE i.contact_type_id IS NULL;

-- creating view_contacts
CREATE VIEW view_contacts AS
SELECT
	c.first_name,
	c.last_name,
	i.contact AS contact,
	ct.contact_type AS contact_type,
	cc.contact_category AS contact_category
FROM
	contacts c
JOIN
	items i ON c.id = i.contact_id
JOIN
	contact_types ct ON i.contact_type_id = ct.id
JOIN
	contact_categories cc ON i.contact_category_id = cc.id;

-- querying everything except IDs
SELECT
	c.first_name,
	c.last_name,
	c.title,
	c.organization,
	i.contact AS contact,
	ct.contact_type AS contact_type,
	cc.contact_category AS contact_category
FROM
	contacts c
JOIN
	items i ON c.id = i.contact_id
JOIN
	contact_types ct ON i.contact_type_id = ct.id
JOIN
	contact_categories cc ON i.contact_category_id = cc.id;