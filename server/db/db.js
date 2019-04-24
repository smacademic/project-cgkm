/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Kevin Kelly
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file creates a db object for the arcplanner database
 */

// Loading and initializing the library:
const pgp = require('pg-promise')({
// Initialization Options
});

// Preparing the connection details:
const connectionString = `postgresql://${process.env.DB_USER}:`
                        + `${process.env.DB_PASSWORD}`
                        + '@localhost:5432/arcplanner';

// Creating a new database instance from the connection details:
const db = pgp(connectionString);

// Exporting the database object for shared use:
module.exports = db;