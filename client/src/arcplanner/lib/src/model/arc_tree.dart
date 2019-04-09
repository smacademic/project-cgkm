import 'arc.dart';
import 'task.dart';
import '../blocs/bloc.dart';

class ArcNode {
  Arc arc;
  ArcNode parent;
  List<dynamic> children;

  ArcNode(this.arc, this.parent, this.children);
  ArcNode.noChildren(this.arc, this.parent);
  
  addChild(dynamic child) {
    children.add(child);
  }

  deleteChild(dynamic child) {
    if (children.contains(child)) {
      children.remove(child);
    }
  }

  delete() {
    // store a copy of children in case there is an error during deletion
    List<dynamic> tempChildren = children;
    try {
      // make a call to DB for deletion of this Arc and subsequent SubArcs/Tasks
      // recursively delete all children and then delete this Arc
      for (dynamic child in children) {
        child.delete();
      }
      if (parent != null) {
        parent.deleteChild(this);
      }
    } catch (err) {
      // Undo any deletes that occured (atomicity) and return error code
      for (dynamic child in tempChildren) {
        if (child is ArcNode) {
          bloc.db.updateArc(child.arc); // if deletion occured, create the Arc with same aid***
        } else if (child is TaskNode) {
          bloc.db.updateTask(child.task); // if deletion occured, create the Task with same tid***
        }
      }
      return err;
    }
  }
}

class TaskNode {
  Task task;
  ArcNode parent;

  TaskNode(this.task, this.parent);

  delete() {
    // store a copy of task in case there is an error during deletion
    Task tempTask = task;
    try {
      // make a call to DB for deletion of this Task
      bloc.db.deleteTask(task.tid);
      // delete this Task from parent's children
      parent.deleteChild(this);
    } catch (err) {
      // Undo the delete if occurred and return error code
      bloc.db.updateTask(tempTask);  // if deletion occured, create the Task with same tid***
      return err;
    }
  }
}

class ArcTree {
  List<ArcNode> topLevel;

  // fills the ArcTree with data from DB
  populateTree() {
    // fill topLevel with Arcs that have no parent
    // build Arc/SubArc structure fully from Arc table
    // Iterate through the Task table placing tasks in the tree at appropriate locations
  }

  List<dynamic> getChildren(ArcNode arcNode) {
    return arcNode.children;
  }
} 