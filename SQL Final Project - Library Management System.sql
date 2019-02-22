CREATE DATABASE db_book_library2
USE db_book_library2


/**********************
LIBRARY_BRANCH
Foreign ID 'BranchID' goes to BOOK_LOANS and BOOK_COPIES
**********************/


	CREATE TABLE tbl_branch (
		branch_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		branch_name VARCHAR(50) NOT NULL,
		branch_address VARCHAR(50) NOT NULL
);


/**********************
BOOK_COPIES
Takes foreign id 'BookID' from BOOKS and 'BranchID' from LIBRARY_BRANCH
**********************/

	CREATE TABLE tbl_copies (
		copies_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
		copies_number_of_copies INT NOT NULL
		
	);



/**********************
Create PUBLISHER table
Foreign key PublisherName linked to "BOOKS"
**********************/

	CREATE TABLE tbl_publishers (
		publisher_name VARCHAR(50) PRIMARY KEY NOT NULL,
		publisher_phone VARCHAR(50) NOT NULL,
		publisher_address VARCHAR(50) NOT NULL
	);


/**********************
BOOKS
foreign id 'BookID' TO "BOOK_AUTHORS" AND TO BOOK_COPIES
Takes fk 'PublisherName' FROM PUBLISHER
EXEC sp_rename 'tbl_books.book_author_name', 'book_title','COLUMN';
**********************/


	CREATE TABLE tbl_books (
		book_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		book_title VARCHAR(50) NOT NULL,
		book_publisher VARCHAR(50) NOT NULL CONSTRAINT fk_publisher_name FOREIGN KEY REFERENCES tbl_publishers(publisher_name) ON UPDATE CASCADE ON DELETE CASCADE
	);


/**********************
BOOK_AUTHORS
Takes 'BookID' FROM "BOOKS"

**********************/


	CREATE TABLE tbl_authors (
		author_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		author_book_id INT NOT NULL CONSTRAINT fk_book_id FOREIGN KEY REFERENCES tbl_books(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
		author_name VARCHAR(50) NOT NULL,
	);




/**********************
BORROWER
Links fk 'CardNo' TO BOOK LOANS
**********************/
	CREATE TABLE tbl_borrowers (
		borrower_card_no INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		borrower_name VARCHAR(50) NOT NULL,
		borrower_address VARCHAR(100) NOT NULL,
		borrower_phone VARCHAR(50) NOT NULL
	);

	/**********************
Create BOOK_LOANS
Takes fk 'Book ID' from BOOKS
and fk 'BranchID' from LIBRARY_BRANCH
and fk 'CardNo' from BORROWER

**********************/
	CREATE TABLE tbl_loans (
		loan_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		loan_book INT NOT NULL CONSTRAINT fk_loan_book_id FOREIGN KEY REFERENCES tbl_books(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
		loan_branch INT NOT NULL CONSTRAINT fk_loan_branch_id FOREIGN KEY REFERENCES tbl_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE,
		loan_card_no INT NOT NULL CONSTRAINT fk__loan_card_no FOREIGN KEY REFERENCES tbl_borrowers(borrower_card_no) ON UPDATE CASCADE ON DELETE CASCADE,
		loan_date_out DATE NOT NULL,
		loan_date_due DATE NOT NULL
	);




/*******
Alterations
*************/



ALTER TABLE tbl_copies ADD
copies_book INT NOT NULL CONSTRAINT fk_copies_book_id FOREIGN KEY REFERENCES tbl_books(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
copies_branch INT NOT NULL CONSTRAINT fk_copies_branch_id FOREIGN KEY REFERENCES tbl_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE
/**********************
INPUT DATA
YOU MAY CHOOSE YOUR OWN DATA TO POPULATE YOUR TABLES AS LONG AS YOUR DATABASE ENSURES THAT THE FOLLOWING CONDITIONS ARE TRUE:
There is a book called 'The Lost Tribe' found in the 'Sharpstown' branch.

There is a library branch called 'Sharpstown' and one called 'Central'.

There are at least 20 books in the BOOK table.

There are at least 10 authors in the BOOK_AUTHORS table.

Each library branch has at least 10 book titles, and at least two copies of each of those titles.

There are at least 8 borrowers in the BORROWER table, and at least 2 of those borrowers have more than 5 books loaned to them.

There are at least 4 branches in the LIBRARY_BRANCH table.

There are at least 50 loans in the BOOK_LOANS table.

There must be at least two books written by 'Stephen King' located at the 'Central' branch.
**********************/
SELECT * FROM tbl_branch
SELECT * FROM tbl_copies
SELECT * FROM tbl_publishers
SELECT * FROM tbl_loans
SELECT * FROM tbl_books
SELECT * FROM tbl_authors
SELECT * FROM tbl_borrowers

	INSERT INTO tbl_branch
		(branch_name, branch_address)
		VALUES 
		('Sharpstown', '483 Denver St'),
		('Central', '345 Apex Dr'),
		('North Side', '123 N 3rd St'),
		('East Side', '456 E 10th Dr'),
		('South Side', '789 S Blake St'),
		('West Side', ' 158 W Grand Blvd')
	;

	SELECT * FROM tbl_branch;
	


	INSERT INTO tbl_publishers
		(publisher_name, publisher_phone, publisher_address)
		VALUES 
		('No Starch Press', '111-111-1111', '245 8th St'),
		('O''Reilly Media', '222-222--2222', '1005 Gravenstein Hwy N'),
		('Franklin, Beedle & Associates INC.', '333-333-3333', '2154 NE Broadway, Ste 100 '),
		('Wiley' , '444-444-4444' , '10475 Crosspoint Blvd'),
		('Pearson' , '555-555-5555' , '5601 Green Valley Drive'),
		('Donald M. Grant Publisher, Inc.' , '777-777-7777' , 'PO Box 187'),
		('Blackstone Publishing', '888-888-8888' , '31 Mistletoe Road'),
		('Harper Collins' , '999-999-9999', '195 Broadway New York'),
		('Del Rey' , '123-456-5839' , '1745 Broadway')
	;
	SELECT * FROM tbl_publishers;



	INSERT INTO tbl_books
		(book_title, book_publisher)
		VALUES 
		('Python Cookbook:', 'O''Reilly Media'),
		('Python Programming', 'Franklin, Beedle & Associates INC.'),
		('Fluent Python:', 'O''Reilly Media'),
		('Introduction to Machine Learning with Python', 'O''Reilly Media'),
		('The Lost Tribe', 'O''Reilly Media'),
		('Python for Data Science For Dummiesds','Wiley'),
		('Introduction to JavaScript programming', 'Pearson'),
		('Eloquent JavaScript' , 'No Starch Press'),
		('The Dark Tower' , 'Donald M. Grant Publisher, Inc.'),
		('The 4 Hour Work Week' , 'Blackstone Publishing'),
		('10 % Happier' , 'Harper Collins'),
		('Stress Less, Accomplish More' , 'Harper Collins'),
		('Curveballs' , 'Harper Collins'),
		('The Fall of Shannara' , 'Del Rey'),
		('The Defenders of Shannara', 'Del Rey'),
		('The Dark Legacy of Shannara' , 'Del Rey'),
		('Python Crash Course' , 'No Starch Press'),
		('Learn Robotics with Rasberry Pi' , 'No Starch Press'),
		('Python Flash Cards' , 'No Starch Press'),
		('Algorithms Illustrated' , 'No Starch Press')
	;
	SELECT * FROM tbl_books;


	INSERT INTO tbl_authors
		(author_book_id, author_name)
		VALUES 
		(5, 'Mark W. Lee'),
		(3 , 'Luciano Ramalho'),
		(1 , 'David Beazley and Brian K. Jones'),
		(2 , 'John Zelle'),
		(4 , 'Sarah Guido and Andreas C. Muller'),
		(6 , 'John Mueller and Luca Massaron'),
		(7 , 'Elizabeth Drake'),
		(8 , 'Marijn Haverbeke'),
		(9 , 'Stephen King'),
		(10 , 'Tim Ferriss'),
		(11, 'Dan Harris'),
		(12, 'Emily Fletcher'),
		(13, 'Emma Markezic'),
		(14, 'Terry Brooks'),
		(15, 'Terry Brooks'),
		(16, 'Terry Brooks'),
		(17, 'Eric Matthes'),
		(18, 'Matt Timmons-Brown'),
		(19, 'Eric Matthes'),
		(20, 'Moriteru Ishida and Shuichi Miyazaki')
	;
	SELECT * FROM tbl_authors;


	INSERT INTO tbl_borrowers
		(borrower_name, borrower_address, borrower_phone)
		VALUES 
		('Alex', '1 1st st', '384-576-2899'),
		('Adam', '2 2nd st', '213-234-2342'),
		('Avery', '3 3rd st', '324-523-3251'),
		('Adel' , '4 4th st', '222-234-1230'),
		('Aaron' , '5 5th st', '342-209-0932'),
		('Allen' , '6 6th st', '234-233-3329'),
		('Andrew A' , '7 7th st', '222-125-5583'),
		('Andrew B' , '8 8th st', '433-344-4980'),
		('Brian A' , '9 9th st' , '221-948-8584' ),
		('Brian B' ,'10 10th st' , '383-848-4839' ),
		('Brian C' , '11 11th st' , '320-393-9948' ),
		('Brian D' , '12 12th st' , '209-289-8928'),
		('Brian E' , '13 13th st' , '382-223-4823'),
		('Brian F' , '14 14th st' , '093-329-2928'),
		('Brian G' , '15 15th st' , '239-928-9980'),
		('Carl A' , '16 16th st' , '234-443-4444'),
		('Carl B' , '17 17th st' , '423-432-4343'),
		('Carl C' , '18 18th st' , '344-434-5555'),
		('Carl D' , '19 19th st' , '555-444-6521'),
		('Carl E' , '20 20th st' , '888-995-5186'),
		('Carl F' , '21 21st st' , '112-113-1515'),
		('Carl G' , '22 22nd st' , '445-446-4545'),
		('Carl H' , '23 23rd st' , '156-123-4455'),
		('Carl I' , '24 24th st' , '123-123-4523'),
		('Carl J' , '25 25th st' , '123-333-5546'),
		('Dana A' ,'27 27th st' , '456-6654-5236' ),
		('Dana B' ,'28 28th st' , '659-852-5563' ),
		('Dana C' ,'29 29th st' , '667-778-7895' ),
		('Dana D' ,'30 30th st' , '345-995-7542' ),
		('Dana E' ,'31 31st st' , '126-658-8562' ),
		('Dana F' ,'32 32nd st' , '365-541-4512' ),
		('Dana G' ,'33 33rd st' , '745-656-6326' ),
		('Dana H' ,'34 34th st' , '632-262-1515' ),
		('Dana I' ,'35 35th st' , '122-223-3213' ),
		('Dana J' ,'36 36th st' , '133-355-6235' ),
		('Dana K' ,'38 38th st' , '445-655-5626' ),
		('Dana L' ,'39 39th st' , '556-567-6523' ),
		('Dana M' ,'40 40th st' , '132-654-8456' ),
		('Eric A' , '41 41st st' , '789-454-1452'),
		('Eric B' , '42 42nd st' , '234-523-5559'),
		('Eric C' , '43 43rd st' , '333-232-3556'),
		('Eric D' , '44 44th st' , '443-223-3928'),
		('Eric E' , '45 45th st' , '234-221-2211')
	;
	SELECT * FROM tbl_borrowers;

	INSERT INTO tbl_copies
		(copies_number_of_copies, copies_book, copies_branch)
		VALUES 
		(5 , 9 , 2),
		(3 , 5 , 2),
		(6 , 5 , 5),
		(4 , 5 , 6),
		(2 , 5 , 3),
		(0 , 5 , 4),
		(2 , 5 , 1),
		(1, 1, 1),
		(2 ,2 , 2),
		(3 ,3 , 3),
		(1 ,4 , 4),
		(3 , 6, 6),
		(4 , 7, 1),
		(2 , 8, 2),
		(3 , 9, 3),
		(2 , 10, 4),
		(2 , 11, 5),
		(3 , 12, 6),
		(3 , 13, 1),
		(4 , 14, 2),
		(5 , 15, 3),
		(5 , 16, 4),
		(2 , 17, 5),
		(3 , 18, 6),
		(3 , 19, 1),
		(2 , 20, 2)
	;
	SELECT * FROM tbl_copies;

	INSERT INTO tbl_loans
		(loan_book, loan_branch, loan_card_no, loan_date_out, loan_date_due)
		VALUES 
		(2, 2, 2, '2019-02-12', '2019-02-19'),
		(3, 2, 2, '2019-02-12', '2019-02-19'),
		(4, 2, 2, '2019-02-12', '2019-02-19'),
		(5, 2, 2, '2019-02-12', '2019-02-19'),
		(1, 1, 2, '2019-02-14', '2019-02-21'),
		(1, 1, 1, '2019-02-12', '2019-02-19'),
		(2, 2, 2, '2019-02-12', '2019-02-19'),
		(3, 3, 3, '2019-02-12', '2019-02-19'),
		(4, 4, 4, '2019-02-12', '2019-02-19'),
		(5, 5, 5, '2019-02-12', '2019-02-19'),
		(6, 6, 6, '2019-02-12', '2019-02-19'),
		(7, 1, 7, '2019-02-12', '2019-02-19'),
		(8, 2, 8, '2019-02-12', '2019-02-19'),
		(9, 3, 9, '2019-02-12', '2019-02-19'),
		(10, 4, 10, '2019-02-12', '2019-02-19'),
		(11, 5, 11, '2019-02-13', '2019-02-20'),
		(12, 6, 12, '2019-02-13', '2019-02-20'),
		(13, 1, 13, '2019-02-13', '2019-02-20'),
		(14, 2, 14, '2019-02-13', '2019-02-20'),
		(15, 3, 15, '2019-02-13', '2019-02-20'),
		(16, 4, 16, '2019-02-13', '2019-02-20'),
		(17, 5, 17, '2019-02-13', '2019-02-20'),
		(18, 6, 18, '2019-02-13', '2019-02-20'),
		(19, 1, 19, '2019-02-13', '2019-02-20'),
		(20, 2, 20, '2019-02-13', '2019-02-20'),
		(1, 3, 21, '2019-02-14', '2019-02-21'),
		(2, 4, 22, '2019-02-14', '2019-02-21'),
		(3, 5, 23, '2019-02-14', '2019-02-21'),
		(4, 6, 24, '2019-02-14', '2019-02-21'),
		(5, 1, 25, '2019-02-14', '2019-02-21'),
		(6, 2, 26, '2019-02-14', '2019-02-21'),
		(7, 3, 27, '2019-02-14', '2019-02-21'),
		(8, 4, 28, '2019-02-14', '2019-02-21'),
		(9, 5, 29, '2019-02-14', '2019-02-21'),
		(10, 6, 30, '2019-02-14', '2019-02-21'),
		(11, 1, 1, '2019-02-15', '2019-02-22'),
		(12, 2, 2, '2019-02-15', '2019-02-22'),
		(13, 3, 3, '2019-02-15', '2019-02-22'),
		(14, 4, 4, '2019-02-15', '2019-02-22'),
		(15, 5, 5, '2019-02-15', '2019-02-22'),
		(16, 6, 6, '2019-02-15', '2019-02-22'),
		(17, 1, 7, '2019-02-15', '2019-02-22'),
		(18, 2, 8, '2019-02-15', '2019-02-22'),
		(19, 3, 9, '2019-02-15', '2019-02-22'),
		(20, 4, 10, '2019-02-15', '2019-02-22'),
		(1, 5, 11, '2019-02-16', '2019-02-23'),
		(2, 6, 12, '2019-02-16', '2019-02-23'),
		(3, 1, 13, '2019-02-16', '2019-02-23'),
		(4, 2, 14, '2019-02-16', '2019-02-23'),
		(5, 3, 15, '2019-02-16', '2019-02-23'),
		(6, 4, 16, '2019-02-16', '2019-02-23'),
		(7, 5, 17, '2019-02-16', '2019-02-23'),
		(8, 6, 18, '2019-02-16', '2019-02-23'),
		(9, 1, 19, '2019-02-16', '2019-02-23'),
		(10, 3, 20, '2019-02-16', '2019-02-23')
	;
	SELECT * FROM tbl_loans;




/**********************
CREATE STORED PROCEDURES THAT WILL QUERY FOR EACH OF THE FOLLOWING QUESTIONS:
**********************/
/**********************
1.) How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
**********************/


GO
CREATE PROC lostTribeInSharpstown
AS

Declare @book VARCHAR(100)
Declare @results varchar(5)
DECLARE @howManyCopies INT
DECLARE @branch VARCHAR (5)
SET @book = (SELECT book_id FROM tbl_books WHERE book_title = 'The Lost Tribe')
SET @branch = (SELECT branch_id FROM tbl_branch WHERE branch_name = 'Sharpstown')
SET @results = (SELECT copies_number_of_copies FROM tbl_copies  WHERE copies_book = @book AND copies_branch = @branch)
	IF @results >= 1
		BEGIN
		PRINT 'There are ' + @results + ' copies of The Lost Tribe at the Sharpstown branch'
		END
	Else 
		BEGIN
		PRINT 'there are no copies of The Lost Tribe at the Sharpstown branch'
		END
END


/**********************
2.) How many copies of the book titled "The Lost Tribe" are owned by each library branch?
**********************/
GO

CREATE PROC lostTribeInAll
AS

Declare @book VARCHAR(100)

SET @book = (SELECT book_id FROM tbl_books WHERE book_title = 'The Lost Tribe')

	SELECT
		a1.copies_number_of_copies as 'Number of Copies:', a2.branch_name as 'Branch Name:'
		FROM tbl_copies a1
		INNER JOIN tbl_branch a2 ON a2.branch_id = a1.copies_branch
		INNER JOIN tbl_books a3 ON a3.book_id = a1.copies_branch
		WHERE a1.copies_book = 5
	;
END

/**********************
3.) Retrieve the names of all borrowers who do not have any books checked out.

**********************/

GO
CREATE PROC noLoanBorrowers
AS

SELECT 
a1.borrower_name
FROM tbl_borrowers a1
LEFT JOIN tbl_loans a2 ON a1.borrower_card_no = a2.loan_card_no
WHERE a2.loan_card_no IS NULL
;
END



/**********************
4.) For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address. 
**********************/

GO 
CREATE PROC dueTodayInSharpstown
AS
DECLARE @today DATE
SET @today = GETDATE()

SELECT 
a4.book_title, a3.borrower_name, a3.borrower_address
FROM tbl_loans a1
RIGHT JOIN tbl_branch a2 on a1.loan_branch = a2.branch_id
RIGHT JOIN tbl_borrowers a3 on a1.loan_card_no = a3.borrower_card_no
RIGHT JOIN tbl_books a4 on a1.loan_book = a4.book_id
WHERE a2.branch_id = 1 AND a1.loan_date_due = @today


END


/**********************
5.) For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
**********************/
GO
CREATE PROC outstandingPerBranch
AS
SELECT 
	a2.branch_name AS 'Branch Name:', count(*) AS 'Number of Loans:'
	FROM tbl_loans a1
	INNER JOIN tbl_branch a2 ON a2.branch_id = a1.loan_branch
	GROUP BY a2.branch_name
END

/**********************
6.) Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out.
**********************/
GO 
CREATE PROC warningBorrowers
AS
	DECLARE @warningLimit VARCHAR(5)
	SET @warningLimit = 5
	DECLARE @borrowed VARCHAR(5)
	SET @borrowed = (count(tbl_loans.loan_card_no) FROM tbl_loans WHERE 


	SELECT warning.borrower_name, warning.borrower_address (SELECT 
	a2.borrower_name, a2.borrower_address, count(*) AS 'Borrowed Book Count:'
	From tbl_loans a1
	LEFT JOIN tbl_borrowers a2 ON a2.borrower_card_no = a1.loan_card_no 
	GROUP BY a2.borrower_address , a2.borrower_name 
	) warning





/**********************
7.) For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
**********************/

GO 
CREATE PROC searchByAuthor
AS

SELECT
	a3.book_title, a1.copies_number_of_copies
	FROM tbl_copies a1
	INNER JOIN tbl_branch a2 ON a2.branch_id = a1.copies_branch
	INNER JOIN tbl_books a3 ON a3.book_id = a1.copies_book
	INNER JOIN tbl_authors a4 ON a4.author_book_id = a1.copies_book
	WHERE author_name = 'Stephen King' and branch_name = 'Central'

END

