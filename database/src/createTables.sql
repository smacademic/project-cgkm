/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Justin Grabowski, Kevin Kelly
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This script creates schema, tables, and indexes for the arcPlanner server
 *   application
 */


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
   UID VARCHAR(60) PRIMARY KEY,
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
   AID VARCHAR(60) NOT NULL PRIMARY KEY,
   UID VARCHAR(60) NOT NULL REFERENCES ArcUser,
   Title VARCHAR(60) NOT NULL,
   Description Text,
   DueDate DATE,
   ParentArc VARCHAR(63),
   Completed BOOLEAN
);

--Define a table to store a task
-- Primary Key:TID
-- TID is the ID of the Task within this table 
CREATE TABLE Task
(
   TID VARCHAR(60) NOT NULL PRIMARY KEY,
   AID VARCHAR(60) NOT NULL REFERENCES Arc,
   Title VARCHAR(60) NOT NULL CHECK(CHAR_LENGTH(TRIM(Title)) > 0),
   Description TEXT, 
   DueDate TIMESTAMP,
   Location VARCHAR(256),
   Completed BOOLEAN
);


COMMIT;


\qecho ' '
\qecho ----------------------------
\qecho End of script

-- Turn off spooling
\o