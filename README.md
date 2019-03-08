# ArcPlanner
### A Team CGKM Project

Team Members:
- Matthew Chastain
- Justin Grabowski
- Kevin Kelly
- Jon Middleton


### Summary
ArcPlanner is an application that helps organize a busy life. It is a planner that will allow users to quickly add tasks to different Arcs. Arcs are long-term or over-reaching tasks such as large projects, classes, or life goals. Where this application differs from other planner apps is in its simplicity to add tasks. Other apps require the user to address multiple input fields such as time, date, location, other people, etc. ArcPlanner allows the user to input tasks all in the same field and then parses the input into the respective fields. An example of this would be "CS298 Exercise 4.8 due on 2/14/19." ArcPlanner will detect that the overall Arc is "CS298", the event is "Exercise 4.8", and the date is "2/14/19." This event could then be added to the in-app calendar with relevant notifications as the due date comes closer.

ArcPlanner is a three-tiered mobile application, consisting of a client, database, and intermediary server. The client that we will focusing on primarily is a flutter mobile application, though with the inclusion of the server tier, other clients can easily be developed and integrated into the product. 


### File Structure
* assets
  * images
* client
  * src
  * test
* database
  * src
  * test  
* server
  * src
  * test
* docs
