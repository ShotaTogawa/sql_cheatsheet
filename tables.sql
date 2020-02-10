-- 3-1
CREATE TABLE tests(
    test VARCHAR(255)
);

-- 3-2

CREATE TABLE owners(
    -- PRIMARY KEY must be unique.
    -- AUTO_INCREMENT gives a number from 0
	id INT AUTO_INCREMENT PRIMARY KEY,
    -- If you set NOT NULL, the column has to have data
	name VARCHAR(50) NOT NULL,
    -- It is enable to set default data.
	created_at TIMESTAMP DEFAULT NOW() 
);

-- 3-3

CREATE TABLE pets(
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
	sex CHAR,
    -- FOREGIN KEY makes a relation with a parent table.
    FOREIGN KEY(owner_id) REFERENCES owners(id)
);