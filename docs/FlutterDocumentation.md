
This page describes all non-ui files within the flutter section of the project  

All documentation is generated with 'documentGeneratorFlutter.py' which can
be found in the docs folder

This page is sectioned by file. The following files can be found:
- [main.dart](maindart)  
- [arcplanner.dart](arcplannerdart)  
- [bloc.dart](blocdart)  
- [validators.dart](validatorsdart)  
- [date.dart](datedart)  
- [arc.dart](arcdart)  
- [task.dart](taskdart)  
- [user.dart](userdart)  
- [databaseHelper.dart](databaseHelperdart)  
<br/><br/><br/><br/>
# main.dart
  This file contains ArcPlanner's main method which runs the application.

<br/><br/><br/><br/>
# arcplanner.dart
  This file contains the ArcPlanner class, defining the screens present in 
  the application as well as setting up the Navigator that allows for screen 
  navigation within ArcPlanner.

<br/><br/><br/><br/>
# bloc.dart
  This file contains the implementation of the BLoC Pattern for Software Design for use with 
  Flutter. The Bloc present in this file handles data flow throughout the application.

### _arcViewInsert Function_
Inserts a dynamic object into the `arcViewController` sink
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| obj | any object that needs to be added to the `arcViewController` sink |

### _homeInsert Function_
Inserts a dynamic object into the `homeController` sink
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| obj | any object that needs to be added to the `homeController` sink |

### _parentSelectInsert Function_
Inserts a dynamic object into the `arcParentSelectViewController` sink
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| obj | any object that needs to be added to the `arcParentSelectViewController` sink |

### _transformData Function_
Map function that based on the given flag from stream will perform
  varying operations that return needed arcs to stream
   on given object
   stream
   the given flag
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| data | a map containing a flag and object |
| flag | `data` map attribute that signifies what operation to use  on given object |
| object | `data` map attribute that hold the objects to be sent by the  stream |


  **return type**: `dynamic`  
**return**:  a list of objects. That list type and quantity is determined by  the given flag
### _toArc Function_
When given a map of an Arc object, presumably from the database, this
   function converts the map into a Arc object using the `Arc.read`
   constructor
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| map | A map of an Arc object |


  **return type**: `Arc`  
**return**:  The Arc object that was constructed 

### _toTask Function_
When given a map of an Task object, presumably from the database, this
   function converts the map into a Task object using the `Task.read`
   constructor
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| map | A map of a Task object |


  **return type**: `Task`  
**return**:  The Task object that was constructed 

### _insertObjectIntoMap Function_
Given a map of a Task or Arc object it will insert its UUID and itself
   into the `loadedObjects` map. UUID represents the key of the map
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| map | contains a map of either a Task or Arc |


  **return type**: `dynamic`  
**return**:  Task or Arc object that was sent via map

### _insertListIntoMap Function_
Inserts a map of Arcs/Tasks into the `LoadedObjects` map using
   `insertObjectIntoMap` function foreach object in list.
   to the `LoadedObjects` map
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| list | A list of Arc and/or Task maps to be converted and added  to the `LoadedObjects` map |


  **return type**: `List<dynamic>`  
**return**:  the List of objects that was converted from the list of maps

### _checkMap Function_
Determines whether the given UUID exists within the `LoadedObjects` map
   map
   `LoadedObjects` map
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| uuid | A uuid to be checked if it exists within the `LoadedObjects`  map |


  **return type**: `bool`  
**return**:  boolean value representing whether the UUID exists in the  `LoadedObjects` map
### _getFromMap Function_
Loads Arc or Task from `LoadedObjects` map given a UUID.
   `LoadedObjects` map
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| UUID | represents a UUID of the object that will be returned |


  **return type**: `dynamic`  
**return**:  The object whos UUID matches the given UUID. UUID is the key of  `LoadedObjects` map
### _getChildren Function_
Checks to see if children are in map. If they exist in map then send them
   back via stream. Otherwise load them from database and into map. Then
   to the UI via stream
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| parentUUID | the UUID of the parent whos children will be returned |


  **return type**: `Future<List<dynamic>>`  
**return**:  All Tasks and Arcs that have `parentUUID` set as their `parentArc`

### _getChildArcs Function_
Checks to see if children are in map. If they exist in map then send them
   back via stream. Otherwise load them from database and into map. Then
   to the UI via stream
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| parentUUID | the UUID of the parent whos children will be returned |


  **return type**: `Future<List<dynamic>>`  
**return**:  All Arcs that have `parentUUID` set as their `parentArc`

### _submitArc Function_
Using the various streams from `add_arc_screen.dart` an arc object is
   created and then added to the database
 
### _submitTask Function_
Using the various streams from `add_task_screen.dart` an Task object is
   created and then added to the database
 
### _initializeAddArcStreams Function_
Resets the streams used by the add arc screen
 
### _initializeAddTaskStreams Function_
Reset the streams used by the add task screen
 
### _dispose Function_
Closes the stream controllers
 
<br/><br/><br/><br/>
# validators.dart
  This file defines the Validators class to be utilized from the Bloc class
   in order to validate data passed to it's streams

<br/><br/><br/><br/>
# date.dart
  This file contains functions that involve specifying Arcs and Tasks by their
  dueDate.

### _getItemsBetweenDates Function_
Retrieves all Arcs and Tasks inclusively between the given two dates
   result in maps of these objects
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| fromDate | Represents the starting date of range of dates to be searched |
| toDate | Represents the ending date of range of dates to be searched |


  **return type**: `Future<List<dynamic>>`  
**return**:  a future list of Arcs and Tasks from the data. This inherently willresult in maps of these objects
<br/><br/><br/><br/>
# arc.dart
  This file has the Arc class and associated functions

### _Arc Function_
The default Constructor for Arc object
   The default is null
   of the given arc. The default is null
   arc. The default is null
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| uid | The UUID of the user |
| title | the title of the arc |
| description | an optional parameter which is the description of Arc.  The default is null |
| dueDate | an optional parameter which is the expected completion date  of the given arc. The default is null |
| parentArc | an optional parameter representing the UUID of the parent  arc. The default is null |

### _Arc.read Function_
A Constructor for Arc object that is used to upon reading from database
   to create an Arc object
   The default is null
   of the given arc. The default is null
   arc. The default is null
   Arcs and Tasks
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| uid | The UUID of the user |
| title | the title of the arc |
| description | an optional parameter which is the description of Arc.  The default is null |
| dueDate | an optional parameter which is the expected completion date  of the given arc. The default is null |
| parentArc | an optional parameter representing the UUID of the parent  arc. The default is null |
| completed | represents whether the arc has been completed |
| childrenUUIDs | A list of UUIDs repesenting the UUIDs of the children  Arcs and Tasks |

### _Arc.map Function_
Defines a Arc map. Converts a map to arc
 
### _toMap Function_
Converts arc objects to a map of its attributes and its values
 

  **return type**: `Map<String,dynamic>`  
**return**:  a map of the object

### _Arc.fromMap Function_
Puts user map data into a arc object
 
<br/><br/><br/><br/>
# task.dart
  This file has the Task class and associated functions

### _Task Function_
The default Constructor for Task object
   The default is null
   of the Task. The default is null
   task is to be completed. The default is null
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| aid | The UUID of the parent Arc |
| description | an optional parameter which is the description of Task.  The default is null |
| dueDate | an optional parameter which is the expected completion date  of the Task. The default is null |
| location | an optional parameter representing the location where  task is to be completed. The default is null |

### _Task.read Function_
The default Constructor for Task object
   The default is null
   of the Task. The default is null
   task is to be completed. The default is null
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| aid | The UUID of the parent Arc |
| description | an optional parameter which is the description of Task.  The default is null |
| dueDate | an optional parameter which is the expected completion date  of the Task. The default is null |
| location | an optional parameter representing the location where  task is to be completed. The default is null |

### _toMap Function_
Puts object data onto a map and returns it
 

  **return type**: `Map<String,dynamic>`  
**return**:  A map of the Task

<br/><br/><br/><br/>
# user.dart
  This file has the User class and associated functions

### _User Function_
The default Constructor for Task object
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| firstName | the first name of the user |
| lastName | the Last name of the user |
| email | the email of the user |

<br/><br/><br/><br/>
# databaseHelper.dart
  This file the DatabaseHelper class and associated functions, which are
  used by the app to interact with the database.

### _initDb Function_
Initializes the database
 
### _startTransaction Function_
Runs the BEGIN TRANSACTION; query in the database.
 
### _rollback Function_
Runs the ROLLBACK; command in the database.
 
### __onCreate Function_
Creates database tables and views
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| db | the db object which the tables will be created |
| version | the version of the database |

### _insertUser Function_
Inserts a new user to the DB using a User object as an input
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| usr | a User object that will be inserted into the database |


  **return type**: `Future<int>`  
**return**:  the result of inserting a user into the database

### _deleteUser Function_
Deletes a user with the given ID
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| id | the UUID of the user that will be deleted from database |


  **return type**: `Future<int>`  
**return**:  the status code result of delete a user into the database

### _updateUser Function_
Updates a user in the DB using a User object (with matching UID)
   in the database
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| usr | the user object that will be used to update the user information  in the database |


  **return type**: `Future<int>`  
**return**:  the status code result of updating a user into the database

### _getUserCount Function_
Gets count of all users within the datbase
 

  **return type**: `Future<int>`  
**return**:  the count of users in database

### _getMasterArcs Function_
Returns a list of Arcs with no parent. Highest level Arcs
 

  **return type**: `Future<List<Map>>`  
**return**:  a list of Arcs with no parent aka null parent

### _getArc Function_
Gets a single Arc from the database
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| uuid | the UUID of the Arc that is being returned |


  **return type**: `Future<List<Map>>`  
**return**:  the Arc associated with the given UUID

### _getTask Function_
Gets a single Arc from the database
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| uuid | the UUID of the Task that is being returned |


  **return type**: `Future<List<Map>>`  
**return**:  the Task associated with the given UUID

### _getChildren Function_
Returns a list of mapped children of the given Arc
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| uuid | the UUID of the parent Arc |


  **return type**: `Future<List<Map>>`  
**return**:  a list of all children Tasks and Arcs

### _getItemsBetweenDates Function_
Retrieves all Arcs and Tasks inclusively between the given two dates. 
   result in maps of these objects
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| fromDate | Represents the starting date of range of dates to be searched |
| toDate | Represents the ending date of range of dates to be searched |


  **return type**: `Future<List<Map>>`  
**return**:  a future list of Arcs and Tasks from the data. This inherently will  result in maps of these objects
### _getChildArcs Function_
Returns a list of mapped children of the given Arc, only arcs
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| uuid | the UUID of the parent Arc |


  **return type**: `Future<List<Map>>`  
**return**:  a list of all children Arcs

### _getArcList Function_
Retrieves all Arcs from the database
 

  **return type**: `Future<List<Map>>`  
**return**:  All Arcs in the database

### _getTaskList Function_
Retrieves all Tasks from the database
 

  **return type**: `Future<List<Map>>`  
**return**:  All Tasks in the database

### _insertTask Function_
Inserts a new Task to the DB
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| tsk | The Task object to be inserted into the database |


  **return type**: `Future<int>`  
**return**:  the status code of the database operation

### _deleteTask Function_
Deletes a Task
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| id | the UUID of the Task that will be deleted |


  **return type**: `Future<int>`  
**return**:  the status code of the database operation

### _updateTask Function_
Updates Task information in the database
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| tsk | the Task that will be used to update information in the database |


  **return type**: `Future<int>`  
**return**:  the status code of the database operation

### _getTaskCount Function_
Get count of all tasks
 

  **return type**: `Future<int>`  
**return**:  the count of all tasks within the database

### _insertArc Function_
Inserts a new Arc to the DB
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| ar | The Arc object to be inserted into the database |


  **return type**: `Future<int>`  
**return**:  the status code of the database operation

### _deleteArc Function_
Deletes an Arc
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| id | the UUID of the Arc that will be deleted |


  **return type**: `Future<int>`  
**return**:  the status code of the database operation

### _updateArc Function_
Updates Arc information in the database
 
**Parameters**   

 | Parameter | Definition | 
|-|-|
| ar | the Arc that will be used to update information in the database |


  **return type**: `Future<int>`  
**return**:  the status code of the database operation

### _getArcCount Function_
Gets count of all Arcs in the database
 

  **return type**: `Future<int>`  
**return**:  the count of all Arcs within the database

### _close Function_
Closes the database object
 
