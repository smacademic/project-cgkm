# Arcplanner Localhost Server Setup

## Step 1: Install [PostgreSQL](https://www.postgresql.org/) 
The recommended interactive installer is distributed by EnterpriseDB and can be found [here](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads).

* Run the installer as an administrator if not prompted.
* The installation directory can be left as the default, although this may be changed with no side-effects.
* Leave the default selections for components.
* The default data directory can be left as the default, although if the installation directory was changed, append to it a child `\data` directory.
* Set the password to: `password`.
* Set the server to listen to port `5432`, which is the default.
* The locale can be left as the default.
* When the files have completed installing, the installer can be closed without launching StackBuilder. (An unnecessary utility)

## Step 2: Create the ArcPlanner database
* Open an administrator Command Prompt or Powershell and navigate to the installation directory for PostgreSQL.
    * Example installation directory: `C:\ Program Files\PostgreSQL\10\bin`
* Type, `psql -U postgres`, where `postgres` is the default user.
* Enter the password defined during the installation process. Ignore errors regarding the incorrect rendering of 8-bit characters.
* Now type the following statement to create the database:
*    `CREATE DATABASE arcplanner;`
* Switch to the `arcplanner` database just created using `\c arcplanner`.
* Create the tables for this database using: `\i <file path to arcplanner repo>/database/src/createTables.sql`

## Step 5: Install Node.js
* The installer can be found [here](https://nodejs.org/en/download/) and will include `npm`. Use the installer defaults.

## Step 5: Install the Web Server
* Open a Command Prompt or Powershell as administrator
* Navigate to the root of the Arcplanner/Server directory and type `npm install`.
* To start the server type `npm start`
