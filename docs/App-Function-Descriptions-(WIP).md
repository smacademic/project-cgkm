The following function descriptions are planned functions to be implemented in the app. They are separated into the following three categories:
- [General Functions](#general-functions)
- [Arc Member Functions](#arc-member-functions)
- [Task Member Functions](#task-member-functions) 

# General Functions
These functions are designed to be static functions to be used anywhere in the app.

## Login Function
**Signature**: `Bool login ( String Username, String Password )`

**Parameter 1**: `Username` represents the user id of the user trying to authenticate

**Parameter 2**: `Password` represents the user chosen and hashed password

**Return**: Boolean is true if successfully authenticated user

**Description**: This function is given a username and password. It then takes the password and hashes/salts it using a chosen hash. Once hashed the username and hash is sent to the server to get authenticated. This function is very liable to change as more review and planning is done for accounts and syncing via the server.

## Load All Active Arcs Function
**Signature**: `List<Arc> loadAllActiveArcs ( Bool activeTasks = true, DateTime startDate = DateTime.Now(), DateTime endDate = null )`

**Parameter 1**: `activeTask` Boolean represents whether you want retrieve only active tasks/Arcs

**Parameter 2**: `startDate` represents the start of a date range to be used to find specified range of arcs. The default is current `dateTime`

**Parameter 3**: `endDate` represents the end of date range to be used to find specified range of arcs. The default is null meaning that user wants to search all active arcs

**Return**: a list of all arcs within the specified range

**Description**: When given a range of dates this function will return all Arcs and related tasks. The first part of this function will retrieve the needed data from SQLite. Once the data is retrieved the data will need to be converted to the Arc class for each tuple of data returned. This list will then be returned. By default this function will only return active Arcs/Tasks but if false is supplied as first parameter then it will return inactive Arcs/Task as well.

## Load Arc Function
**Signature**: `Arc loadArc ( arcID )`

**Parameter 1**: `arcID` represents the ID number used within the SQLite schema for the arc that needs to be returned

**Return**: Returns the specified arc

**Description**: When given an arc ID the specified Arc will be returned. The first part of this function will retrieve the needed data from SQLite. This includes the Arc data and also the Tasks that belong to that Arc. Once the data is retrieved the data will need to be converted to an Arc class object. The tasks and subarcs that belong to that arc will also have to be made into objects and added to the associated collection within the object. The new Arc object will then be returned.

## Load Task Function
**Signature**: `Task loadTask ( taskID )`

**Parameter 1**: `taskID` represents the ID number used within the SQLite schema for the task that needs to be returned

**Return**: Returns the specified task

**Description**: When given an arc ID the specified Task will be return. The first part of this function will retrieve the needed data from SQLite. Once the data is retrieved the data will need to be converted to the task class. The new task object will then be returned.

## Add Arc Function
**Signature**: `Arc addArc ( String title, { String description = null, String ParentArc null })`

**Parameter 1**: `title` represents the title of the Arc

**Parameter 2**: `description` is the information that describes the Arc objective

**Parameter 3**: `parentArc` is the Arc ID of the parent if the Arc being created is a subarc

**Return**: Returns the created Arc

**Description**: The parameters supply needed information to create an Arc within the SQLite database with the exception of the ID. This ID needs to be generated with a UUID. The data is then sent to the SQLite database to be inserted into the Arc table. The data should then be used to create an Arc object and returned. If subArc the generated Arc should be added to the parent's subarc collection via addSubArc instance method.

## Remove Arc Function
**Signature**: `Void removeArc ( String arcID )`

**Parameter 1**: `arcID` is the ID of the arc to be deleted

**Description**: Making sure to start a transaction the arc and all of its tasks/subarcs. If all are removed successfully complete the transaction otherwise rollback (if it doesn't automatically) and give error message. Once the transaction is complete then each task/subArc should be deleted with their respective destructor functions. Once those are complete the original arc should call a destructor.

## Parse Arc Function
**Signature**: `Arc parseArc ( String text, { Bool createArc = true, String parentArcID = null })`

**Parameter 1**: `text` represents the user inputted text that needs to be parsed into an Arc

**Parameter 2**: `createArc` bool represents whether the user wants to automatically create arc or view the parsed results first

**Parameter 3**: `parentArcID` represents the parent arc, if the arc being created is a sub arc.

**Return**: Returns the created Arc if available

**Description**: This function needs to parse though the text to find at least title. Once title is found other optional parameters should be found. Once all possible values are found there are three possible routes based on the value of `createArc` and if the parse was successful. If `createArc` is true and all data was parsed then the parsed data should use the addArc function to create an arc. If `createArc` is true but all data could not be parsed then the function should redirect to the manual view of creating an arc with what was successfully parsed(if any) filled into the correct fields. If `createArc` is false then all parsed information should be redirected into the manual Arc creation fields.


# Arc Member Functions
These functions are designed to be member functions of the Arc Class.

## Add Task Function
**Signature**: `Task addTask ( String title, {String description = null, DateTime dueDate = null, String location = null })`

**Parameter 1**: `title` represents the title of the Task

**Parameter 2**: `description` is the information that describes the task objective. This is null by default

**Parameter 3**: `dueDate` is the date when the task should be completed by. This is null by default

**Parameter 4**: `location` is where the task takes place. This is null by default

**Return**: Returns the created task

**Description**: The parameters supply needed information to create a Task within the SQLite database with the exception of the ID. This ID needs to be generated with a UUID. This data is sent to the SQLite database to be inserted into the task table. If successfully inserted the data should be used to create a task object. That task object should then be added to the list of tasks belonging to the Arc which called the instance method.

## Remove Task Function
**Signature**: Void removeTask ( String taskID )

**Parameter 1**: taskID is the ID of the task to be deleted

**Description**: Given a taskID it deletes the task entry for the supplied task ID. It then searches the collection of task objects in the instance of Arc until it finds the correct task. It then removes and deletes that task from the arc object. The deletion of the class will call the destructor function of the Task object.

## Add Sub Arc Function
**Signature**: `Void addSubArc ( Arc subArc )`

**Parameter 1**: `subArc` is the subArc to be added to the parent's collection of subarcs

**Description**: Adds the given subArc to the collection of subArcs that the Arc class has.

## Remove Sub Arc Function
**Signature**: `Void removeSubArc ( String subArcID )`

**Parameter 1**: `subArcID` is the ID that represents the subArc that is going to removed.

**Description**: Given the ID of the sub arc the correct Arc is found in the SQLite file and deleted. It is then also found in the arc instance's collection of sub arcs. Once found that arc runs its own destructor function.

## Complete Arc Function
**Signature**: `Void completeArc ( )`

**Description**: Updates the SQLite related arc completed field to true. It then also changes its on instance variable to true.

## Parse task Function
**Signature**: `Task parseTask ( String text, [Bool createTask = true] )`

**Parameter 1**: `text` represents the user inputted text that needs to be parsed into a task

**Parameter 2**: `createTask` bool represents whether the user wants to automatically create task or view the parsed results first

**Return**: Returns the created task if available

**Description**: This function needs to parse though the text to find at least title. Once title is found other optional parameters should be found. Once all possible values are found there are three possible routes based on the value of `createTask` and if the parse was successful. If `createTask` is true and all data was parsed then the parsed data should use the `addTask` function to create a task. If `createTask` is true but all data could not be parsed then the function should redirect to the manual view of creating a task with what was successfully parsed(if any) filled into the correct fields. If `createTask` is false then all parsed information should be redirected into the manual task creation fields.

# Task Member Functions
These functions are designed to be member functions of the Task Class.

## Complete Task Function
**Signature**: `Void completeTask ( )`

**Description**: Updates the SQLite related task completed field to true. It then also changes its on instance variable to true.