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
-- Primary Key: UID is the ID of the user that created the arc
CREATE TABLE Arc
(
   UID VARCHAR(60) NOT NULL CHECK(CHAR_LENGTH(TRIM(UID)) = 60) REFERENCES ArcUser,
   AID VARCHAR(60) NOT NULL CHECK(CHAR_LENGTH(TRIM(AID)) = 60),
   Title VARCHAR(60) NOT NULL,
   Description Text, 
   ParentArc VARCHAR(63) , 
   PRIMARY KEY (UID, AID)
);

--Define a table to store a task
-- Primary Key: AID and TID
-- AID is the ID of the Arc the task belongs to
-- TID is the ID of the task within this table 
CREATE TABLE Task
(
   AID VARCHAR(60) NOT NULL CHECK(CHAR_LENGTH(TRIM(AID)) = 60),
   UID VARCHAR(60) NOT NULL CHECK(CHAR_LENGTH(TRIM(UID)) = 60),
   TID VARCHAR(60) NOT NULL CHECK(CHAR_LENGTH(TRIM(TID)) = 60),
   Title VARCHAR(60) NOT NULL CHECK(CHAR_LENGTH(TRIM(Title)) > 0),
   Description TEXT, 
   DueDate TIMESTAMP,
   Location VARCHAR(256), 
   FOREIGN KEY (AID, UID) REFERENCES Arc,
   PRIMARY Key (AID, TID)
);


COMMIT;


\qecho ' '
\qecho ----------------------------
\qecho End of script

-- Turn off spooling
\o