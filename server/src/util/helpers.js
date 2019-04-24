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
 *  This script creates the default routes for the arcplanner web server
 */

const db = require('../db/db.js');
const logger = require('../logs/winston.js');


/**
 * This function queries the arcplanner database for all arcs and returns them
 *
 * @return all arcs in arcplanner database
 */
function getArcs(req, res) {
  return new Promise((resolve, reject) => {
    db.any('SELECT * FROM Arc')
      .then((result) => {
        resolve();
        return res.status(200).json(result);
      })
      .catch((error) => {
        logger.error(`getArcs: \n${error}`);
        reject(new Error('Server Error: Could not query the Arcs'));
      });
  });
}

module.exports = {
    getArcs,
};