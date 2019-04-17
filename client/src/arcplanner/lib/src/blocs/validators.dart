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