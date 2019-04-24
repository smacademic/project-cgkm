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
 *  This file is used to set up the winston logging system
 */

const { createLogger, format, transports } = require('winston');

const {
  combine, timestamp, printf,
} = format;

const myFormat = printf(info => `${info.timestamp} ${info.level}: ${info.message}`);

const logger = createLogger({
  level: 'info',
  format: combine(
    timestamp(),
    myFormat,
  ),
  transports: [
    //
    // - Write to all logs with level `info` and below to `combined.log`
    // - Write all logs error (and below) to `error.log`.
    //
    new transports.File({ filename: 'src/logs/error.log', level: 'error' }),
    new transports.File({ filename: 'src/logs/combined.log' }),
  ],
});

module.exports = logger;
module.exports.stream = {
  write(message) {
    logger.info(message);
  },
};