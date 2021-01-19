/* CREATE statements allow us to create a new table in the database. You can use the CREATE statement anytime you want to create a new table from scratch. The statement below creates a new table named celebs. 
*/  
CREATE TABLE celebs (
   id INTEGER, 
   name TEXT, 
   age INTEGER
);

/*
1. CREATE TABLE is a clause that tells SQL you want to create a new table.
2. celebs is the name of the table.
3. (id INTEGER, name TEXT, age INTEGER) is a list of parameters defining each column, or attribute in the table and its data type:

    id is the first column in the table. It stores values of data type INTEGER
    name is the second column in the table. It stores values of data type TEXT
    age is the third column in the table. It stores values of data type INTEGER
*/

-- Insert
/* The INSERT statement inserts a new row into a table. You can use the INSERT statement when you want to add new records. The statement below enters a record for Justin Bieber into the celebs table.
*/
INSERT INTO celebs (id, name, age) 
VALUES (1, 'Justin Bieber', 22);

/*
1. INSERT INTO is a clause that adds the specified row or rows.
2. celebs is the name of the table the row is added to.
3. (id, name, age) is a parameter identifying the columns that data will be inserted into.
4. VALUES is a clause that indicates the data being inserted.
(1, 'Justin Bieber', 22) is a parameter identifying the values being inserted.

    1 is an integer that will be inserted into the id column
    'Justin Bieber' is text that will be inserted into the name column
    22 is an integer that will be inserted into the age column
*/
