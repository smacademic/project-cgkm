
import 'dart:async';
import '../model/arc.dart';
import '../model/task.dart';
import '../util/databaseHelper.dart';

class Bloc {
  final DatabaseHelper db = DatabaseHelper();

  //final _arcTree = ArcTree();
  Map<String, Arc> _arcMap;
  final _arcStream = StreamController<Arc>();
  final _taskStream = StreamController<Task>();

  // Adding data to the stream
  Stream<Arc> get arc => _arcStream.stream;
  Stream<Task> get task => _taskStream.stream;

  // Changeing data
  Function(Arc) get newArc => _arcStream.sink.add;
  Function(Task) get newTask => _taskStream.sink.add;

  dispose() {
    _arcStream.close();
    _taskStream.close();
  }
}

final bloc = Bloc();