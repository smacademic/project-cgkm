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


CREATE TABLE User
(
   UID VARCHAR(60) PRIMARY KEY CHECK(LENGTH((TRIM(UID)) = 60)),
   FirstName VARCHAR(60) NOT NULL, 
   LastName VARCHAR(60) NOT NULL,
   Email VARCHAR(319) CHECK(TRIM(Email) LIKE '_%@_%._%')
);

--enforce case-insensitive uniqueness of user e-mail addresses
CREATE UNIQUE INDEX idx_Unique_InstructorEmail
ON User(LOWER(TRIM(Email)));


CREATE TABLE Arc
(
   UID VARCHAR(60) NOT NULL CHECK(LENGTH((TRIM(UID)) = 60)),
   AID VARCHAR(60) NOT NULL CHECK(LENGTH((TRIM(AID)) = 60)),
   Title VARCHAR(60) NOT NULL,
   Description Text, 
   ParentArc VARCHAR(63) , 
   FOREIGN KEY UID REFERENCES User.UID, 
   PRIMARY KEY (UID AID)
);


CREATE TABLE Task
(
   AID VARCHAR(60) NOT NULL CHECK(LENGTH((TRIM(AID)) = 60)),
   TID VARCHAR(60) NOT NULL CHECK(LENGTH((TRIM(TID)) = 60)),
   Title VARCHAR(60) NOT NULL CHECK(LENGTH((TRIM(Title)) > 0))
   Description TEXT, 
   DueDate TIMESTAMP,
   Location VARCHAR(256), 
   FOREIGN KEY AID REFERENCES Arc.AID, 
   PRIMARY Key (AID, TID)
);


COMMIT;


\qecho ' '
\qecho ----------------------------
\qecho End of script

-- Turn off spooling
\o