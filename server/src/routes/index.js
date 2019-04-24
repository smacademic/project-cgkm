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

var express = require('express');
var router = express.Router();

const helpers = require('../util/helpers.js');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

/**
 * This method returns all arcs in the arcplanner database
 *
 * @return All arcs in arcplanner database
 */
router.get('/getArcs', (req, res) => helpers.getArcs(req, res)
  .catch((err) => {
    handleResponse(res, 500, err);
  }));

module.exports = router;
