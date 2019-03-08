Overview
--------

ArcPlanner is an application that helps organize a busy life. It is a
planner that will allow users to quickly add and track tasks. These
tasks are organized into Arcs, which are long-term or over-reaching
tasks such as large projects, classes, or life goals. Where this
application differs from other planner apps is in its simplicity to add
tasks. Other apps require the user to address multiple input fields such
as time, date, location, other people, etc. ArcPlanner allows the user
to input tasks all in the same field and then extracts the important
information from the string, creates a task in the correct Arc, and adds
it to the list of active tasks. In the input string, a user can have the
desired Arc, event title, time, and location. The app will be able to
extract these entities regardless of their orientation in the string,
thus allowing the user to input tasks in the way that seems most natural
to them.

In addition to the ability to input a string and have the app
automatically create a task, the user can also manually input a task.
This more closely resembles the method that many other planning
applications create their events.

Arcs in ArcPlanner must be set up before the user can add a task to
them. Arcs only serve to organize tasks, and as such are not able to be
added using the parser. Arcs can also contain other Arcs, which are
known as SubArcs. These SubArcs also serve to further organize an Arc.
Likewise, SubArcs can also have SubArcs, increasing the level of
organization. Tasks must be added to an Arc, whether it is the largest
Arc or a SubArc the level does not matter. Tasks cannot exist on their
own without an Arc.

An example of a possible input string is \"CS298 Exercise 4.8 due on
2/14/19.\" ArcPlanner will detect that the overall Arc is \"CS298\", the
event is \"Exercise 4.8\", and the date is \"2/14/19.\" This event will
then be added to the in-app calendar with relevant notifications as the
due date comes closer.

ArcPlanner has two methods in which the user can view their created
tasks. The first is the Arc View, which presents the user with a list of
their current Arcs at the highest level, only showing the main Arc and
no SubArcs within. A user may tap on the desired Arc, and the app will
now show them the next level of that Arc, the tasks and SubArcs that
exist one level below the root Arc. This process can be repeated until
the user has reached the desired level and taps on a task. This will
show the user the Task View, which is a screen that details all input
information about the task. From this screen the user is allowed to
modify the entries.

The second method of viewing tasks is from the Calendar View, which is a
scrollable calendar that shows on what dates upcoming tasks are due.
Users can tap on a task from this view and be brought to the Task View
as described above.

ArcPlanner is a three-tiered mobile application, consisting of a client,
database, and intermediary server. The client will be a Flutter mobile
application, though with the inclusion of the server tier, other clients
can easily be developed and integrated into the product. The Flutter
project will contain an SQLite database, allowing for local storage and
offline use, but then will resync the data when internet connection is
re-established.

Users
-----

The intended users of ArcPlanner are anyone who wants a planner app that
specializes in the quick creation of new tasks. This focuses heavily
upon high school and university level students, but also is easily
applicable to use in a work environment. Arcs can be created that
encompass classes, where the tasks would be assignments and assessments,
or can be created for projects at work, where tasks will reflect the
work that needs to be done in that specific field.

Requirements
------------

1.  Login

    1.  Authentication

2.  View tasks

    1.  Calendar view

        1.  View upcoming items on a scrollable calendar

    2.  Arc view

        1.  View tasks in specified Arcs

    3.  Task View

3.  Add an item

    1.  Adding Arcs

    2.  Adding tasks

        1.  Single string creation and parsing/entity extraction

        2.  Manual task creation

4.  Completing items

    1.  Completing Arcs

    2.  Completing tasks

5.  Remove an item

    1.  Remove Arc

    2. Remove task

6.  Information storage

    1. Self-contained relational database

    2. Cloud database storage

        1.  Data sync when internet is available

Requirements Descriptions
-------------------------

### Req 1.1: Authentication

The use of the planner app should be restricted to the owner of the
device, and thus should be protected by device authentication at a
minimum. The app will allow users to set up a local account but should
also allow them to use a cloud account for multiple device syncing.
Authentication for syncing to the cloud will consist of a username and
password. If the app is in local-only mode and not connecting to the
cloud to sync data, the user will not be required to log in at all and
the device's own authentication will suffice. If the user is connecting
to cloud services, they will need to log in once upon initial
installation, but then the device's own authentication will be enough to
keep the data secure. This approach allows the user to continue using
the application with no interruptions, such as needing to log in every
time they want to add a task.

### Req 2.1.1: View upcoming items on a scrollable calendar

The app will have a screen where users can view a calendar populated
with their tasks. This allows them to see upcoming tasks in a visual way
and helps them plan accordingly. Tapping on a task in this view will
take the user to the Task View for that specific task.

### Req 2.2.1: View tasks in specified Arcs

Users will be able to view their created Arcs in a list format, with
sub-lists being presented when the parent Arc is tapped. This is called
the Arc View. For reference, this view will function similarly to a
typical file hierarchy view where users can delve deeper into an
Arc/SubArc by tapping on the relevant tile. This will present users with
a list of tasks at each level of the Arc that lets them tap on a task,
taking them to the Task View for that specific task. From the Arc View
the user can archive/delete an Arc, or modify Arc values with a pop-up
dialog.

### Req 2.3: Task View

The task view shows the user a screen that has all input data for a
specific task, including title, Arcs/SubArcs the task belongs to, date
created, end date, location, and description. The user will be able to
modify these entries to change the task if they so desire. The user will
also have the option to mark the task as 'complete' from this screen, or
delete the task if they desire.

### Req 3.1: Adding Arcs

A user will be able to create an Arc, typing in the title of the Arc and
an optional description. The Arc will then be available to add tasks to
and will function as a form of organization for tasks. A user will also
be able to add Arcs to another Arc, creating a SubArc. This is also for
organizational purposes only. These functionalities will help the user
maintain a well-organized planner.

### Req 3.2.1: Single string creation and parsing/entity extraction

Users will be able to input a string containing information about a
task, and the app will extract the different parts of the event and
build a task from them. The task should be put into the proper
Arc/SubArc automatically. The user will be taken to the task view screen
for the new task upon creation to verify that the information is
correct, and if not, they can change the fields.

Examples of user strings:

> CS 298 - Homework 2 due 3/12\
> CS 298 - Homework 2 due March 12th\
> CS 298 Homework 2 3/12\
> Homework 2 for CS298 due 3/12\
> CS298 - 3/12 - Homework 2\
> 3/12 - CS 298 Homework 2

Resulting Event:

> Arc: CS 298\
> Title: Homework 2\
> Date: 3/12

### Req 3.2.2: Manual task creation

The user will have the option to create a task using a more traditional
method of filling out separate fields for title, end date, location, and
description. This gives the user the highest level of control over the
creation of a task. This option will be available from the Task View at
each level of an Arc, allowing the user to also specify exactly at which
level of an Arc the task will exist.

### Req 4.1: Complete Arc

If an Arc has an end date, once the date has been reached and the user
next opens the app, they will be given a prompt asking if that Arc
should be archived or the end date extended. If there are still
unfinished SubArcs or tasks in the Arc, the prompt will note this and
not allow archiving until these are completed. This allows the user to
add more time if required. Archived Arcs will be stored and can be
viewed from an option in the Arc View screen. If the Arc does not have
an end date, the user can manually archive or delete it from the Arc
View screen.

### Req 4.1: Complete task

When a task reaches its end-date or if the user manually marks it as
complete from the Task View screen, it will be archived. The task will
still appear on the Calendar View but will no longer be viewable by
default from the Task View screen. The user will have the option to view
completed/archived tasks in the Task View.

### Req 5.1: Remove Arc

The user will have an option to remove an Arc or SubArc from the Arc
View. If there are any SubArcs or tasks that are children of the
Arc/SubArc that are to be removed, the user will be given a warning that
all children tasks and SubArcs will also be deleted and not archived.

### Req 5.2: Remove task

The user will have the option to remove tasks from the Task View screen.
As this is a leaf of the Arc tree, there will be no need for a warning
about other deletions. The user will be asked to confirm deletion. If
they respond 'yes' the task will be deleted and not archived.

### Req 6.1: Self-contained relational database

The application contains a local SQLite database that stores all
application data. This allows the app to store persistent data for the
user to use while offline or as a local-only planner app.

### Req 6.2.1: Data sync when internet is available

The application will connect to a cloud database to upload any changes
to the local database and download any new tasks from the cloud
database. This functionality will allow ArcPlanner to be used on
multiple different devices for the same user and maintain the same tasks
across all. The primary motivation for this is to have a web-based or
desktop client that will share information with the mobile app.
