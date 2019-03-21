--createTables.sql - ArcPlanner

--Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
-- CS298 Spring 2019 Team CGKM

--Version 1

--*Add licence*

--PROVIDED AS IS. NO WARRANTIES EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.

--This script creates schema, tables, and indexes for the arcPlanner application

--E-mail address management is based on the discussion presented at:
-- https://gist.github.com/smurthys/feba310d8cc89c4e05bdb797ca0c6cac


--The results of running this script will be spooled to 
-- 'spoolCreateTables.txt'

\o 'spoolCreateTables.txt'

--Output script execution data
\qecho -n 'Script run on '
\qecho -n `date /t`
\qecho -n 'at '
\qecho `time /t`
\qecho -n 'Script run by ' :USER ' on server ' :HOST ' with db ' :DBNAME
\qecho ' '
\qecho


START TRANSACTION;


--Define a table to store an ArcUser
-- Primary Key: UID
-- UID is the ID of the user within the table
CREATE TABLE ArcUser
(
   UID VARCHAR(60) PRIMARY KEY CHECK(CHAR_LENGTH(TRIM(UID)) = 60),
   FirstName VARCHAR(60) NOT NULL, 
   LastName VARCHAR(60) NOT NULL,
   Email VARCHAR(319) CHECK(TRIM(Email) LIKE '_%@_%._%')
);

--Enforce case-insensitive uniqueness of user e-mail addresses
CREATE UNIQUE INDEX idx_Unique_InstructorEmail
ON ArcUser(LOWER(TRIM(Email)));

--Define a table to store an Arc
-- Primary Key: AID
-- AID is the ID of the Arc within the table
CREATE TABLE Arc
(
   AID VARCHAR(60) NOT NULL PRIMARY KEY CHECK(CHAR_LENGTH(TRIM(AID)) = 60),
   UID VARCHAR(60) NOT NULL REFERENCES ArcUser,
   Title VARCHAR(60) NOT NULL,
   Description Text, 
   ParentArc VARCHAR(63)
);

--Define a table to store a task
-- Primary Key:TID
-- TID is the ID of the Task within this table 
CREATE TABLE Task
(
   TID VARCHAR(60) NOT NULL PRIMARY KEY CHECK(CHAR_LENGTH(TRIM(TID)) = 60),
   AID VARCHAR(60) NOT NULL REFERENCES Arc,
   Title VARCHAR(60) NOT NULL CHECK(CHAR_LENGTH(TRIM(Title)) > 0),
   Description TEXT, 
   DueDate TIMESTAMP,
   Location VARCHAR(256)
);


COMMIT;


\qecho ' '
\qecho ----------------------------
\qecho End of script

-- Turn off spooling
\o