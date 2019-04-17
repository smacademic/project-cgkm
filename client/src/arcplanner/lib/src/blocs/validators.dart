/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Justin Grabowski
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file defines the Validators class to be utilized from the Bloc class
 *   in order to validate data passed to it's streams
 */

import 'dart:async';


class Validators {

  final validateTitle = 
    StreamTransformer<String, String>.fromHandlers(handleData: (title, sink) {
      if (title.isNotEmpty)  {
        sink.add(title);
      } else {
        sink.addError('Please enter a title');
      }
    });

  final validateDesc = 
    StreamTransformer<String, String>.fromHandlers(handleData: (desc, sink) {
        if (desc.isNotEmpty)  {
        sink.add(desc);
      } else {
        sink.addError('Please enter a description');
      }
    });

 
}