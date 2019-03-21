### Overview  
The purpose of this document is to give a visual template for each screen of ArcPlanner’s mobile user interface to be used when building the screens with Dart and Flutter. This document also serves as a reference for the purpose of each screen and how it fits into the overall app. 

### Login  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/Login.png)</kbd>  
ArcPlanner Login screen, consisting of standard username and password authentication. This screen will only be shown to the user once after installation, unless an event occurs that requires re-authentication. This is to allow for quick adding of tasks without needing to log in each time. Tapping Login without a correct username/password combination will result in an error stating the problem. If Login is tapped with a valid username/password combination, then the user will be brought to the Home screen.
 
### Loading Screen  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/LoadingScreen.png)</kbd>  
This screen is what a user will see upon opening the app if they have previously authenticated. This will also be the screen that appears if it takes time to perform an action between other screens. 
 
### Home  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/Home.png)</kbd>  
The Home screen displays the number of upcoming tasks in the next week, a large button for quickly adding a task, and a list of the upcoming tasks. Tapping on a task will take the user to the Task View page for the tapped task. 
 
### Side-Menu  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/SideMenu.png)</kbd>  
ArcPlanner’s menu is a side-menu that slides out from the left-hand side of the screen. A user need only drag from the left side of their screen towards the middle to pull out the menu. The menu provides in-app navigation, as tapping ‘Home’, ‘Create New Task’, ‘Create New Arc’, ‘Arc View’, ‘Calendar View’, ‘Archived Items’, ‘About’, ‘Settings’, or ‘Logout’ will take the User to the appropriate screen to perform that action. ‘Logout’ will return the user to the Login screen. Tapping the ‘Help’ button will show the user a relevant help screen for the screen they are currently on. To dismiss the Side-Menu, swipe from the right-hand side of the screen towards the middle. 

### Settings  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/Settings.png)</kbd>  
ArcPlanner has multiple settings planned that can be changed. As the settings are not all planned at this time, dummy settings have been written in and will be replaced by actual settings later.
 
### About  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/About.png)</kbd>  
The About screen contains a basic description of ArcPlanner, along with the names of team-CGKM who developed the application. Tapping the back arrow in the bottom right will return the user to the previous screen.
 
### Calendar View  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/CalendarView.png)</kbd>  
The Calendar View show the user a scrollable calendar with days highlighted that are relevant dates for tasks and Arcs. When the user taps on a date, the tasks and Arcs that are set to be due then will appear in a scrollable list underneath the calendar. Tapping on these items brings up their View page. 
 
### Help – Calendar View  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/Help_CalendarView.png)</kbd>  
This screen provides the user with a quick description of the Calendar View page. Accessed from the Help button on the side-menu. Tapping ‘OK’ will dismiss this dialogue.
 
### Arc View  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/ArcView.png)</kbd>  
The Arc View screen shows the user their top-level Arcs, along with end dates and descriptions if they have them. The list is scrollable and if the user taps on an Arc, they will be taken to the next level down in that Arc tree. Tapping the ‘New Task’ button here will present the user with the task creation screen. Tapping the ‘New Arc’ button will take the user to the Arc Creation screen. Tapping the back button in the bottom right of the screen will return the user to the previous screen.
 
### Arc View – Lower Level  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/ArcView_LowerLevel.png)</kbd>  
This screen shows the lower level of an Arc. It presents the user with a list of SubArcs and tasks that exist at the current level. Tapping a SubArc here will take the user into the next level of that SubArc tree. Tapping a task here will take the user to the Task View screen for that task. Tapping the ‘New Task’ button will create a new task that defaults to this level of the Arc, but this can be changed in the Task Creation Screen. Tapping the ‘New SubArc’ button will create a new SubArc that defaults to the current level of this tree, but this can be changed in the Arc Creation Screen. Tapping the back button in the lower right-hand side of the screen will return the user to the previous page. 

### Help – Arc View  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/Help_ArcView.png)</kbd>  
This screen provides the user with a quick description of the Arc View page. Accessed from the Help button on the side-menu. Tapping ‘OK’ will dismiss this dialogue.
 
### Arc View – Tap and Hold an Arc/SubArc  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/ArcView_TapAndHold.png)</kbd>  
Tapping and holding on an Arc or SubArc tile will present the user with this pop-up. It shows the Arc’s/SubArc’s information and gives the option to Mark the Arc/SubArc completed, Edit the Arc/SubArc, or delete the Arc/SubArc. Tapping ‘Mark’ will prompt the user if they wish to archive the Arc. This can only be done if the Arc has no tasks in its tree. ‘Edit’ will allow the user to edit the details of the Arc in the Arc Edit screen. ‘Delete’ will prompt the user if they wish to delete the Arc and all SubArcs and task in the Arc tree. Tapping the dimmed area outside the dialog will dismiss the pop-up.
 
### Arc View – New Arc  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/ArcView_NewArc.png)</kbd>  
This screen shows the user the Arc Creation screen. It allows the user to enter the Arc’s location, name, end date, and description. ‘Cancel’ will remove the screen and show the user the previous screen they were on. ‘Accept’ will create the Arc and add it to the user’s Arc list. 
 
### Arc View – New Arc Location Select  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/ArcView_NewArc_LocationSelect.png)</kbd>  
This screen is shown when a user is creating a new Arc or SubArc and taps on ‘Select Arc Location’. It displays an expandable and collapsible Arc tree list that lets the user decide exactly where they want the new Arc or SubArc to be. ‘Cancel’ will remove the screen and show the user the Arc Creation screen they were on previously. ‘Accept’ will confirm the choice of Arc or SubArc location.

### Arc View – Delete  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/ArcView_Delete.png)</kbd>  
This is the dialogue that is shown to the user when they indicate that they wish to delete an Arc or SubArc. ‘Cancel’ will not delete the Arc or SubArc, while ‘Delete’ will delete the Arc or SubArc along with all contained SubArcs and tasks.
 
### Arc View – Edit Arc/SubArc  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/ArcView_EditArc_SubArc.png)</kbd>  
This screen allows the user to edit an Arc or SubArc. Users can modify the Name, End Date, and Description. Users are not permitted to modify an Arc’s or SubArc’s location in the overall Arc tree. 
 
### Task View  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/TaskView.png)</kbd>  
This screen shows the details of a task. Tapping ‘Mark’ will prompt the user if they wish to archive the task. Tapping ‘Edit’ will bring the user to the Task Edit screen for this task. Tapping ‘Delete’ will prompt the user if they wish to delete this task. Tapping the back arrow in the bottom right-hand corner will return the user to the previous screen they were on. 
 
### Help – Task View  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/Help_TaskView.png)</kbd>  
This screen provides the user with a quick description of the Task View page. Accessed from the Help button on the side-menu. Tapping ‘OK’ will dismiss this dialogue. 
 
### Task View – Delete  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/TaskView_Delete.png)</kbd>  
This is the prompt asking users if they want to delete a task. Tapping ‘Cancel’ will return the user to the Task View screen and tapping ‘Delete’ will delete the task.
 
### Task Creation/Edit  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/TaskCreation_Edit.png)</kbd>  
This screen facilitates the creation of a new task. ‘Arc Path Select’ can be tapped to change the defaulted location for the new task. ‘Cancel’ will return the user to the previous screen and ‘Accept’ will create a new task with the input values.
 
### Help – Task Creation/Edit  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/Help_TaskCreationEdit.png)</kbd>  
This screen provides the user with a quick description of the Task Creation/Edit page. Accessed from the Help button on the side-menu. Tapping ‘OK’ will dismiss this dialogue.

### Task Creation – Arc Selection  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/TaskCreation_ArcSelect.png)</kbd>  
This prompt allows the user to select which Arc or SubArc they would like the new task to be associated under. The list is an expandable and collapsible Arc tree, allowing the user to specify the depth in an Arc they would like the task. ‘Cancel’ returns the user to the Task Creation/Edit screen without changing the default Arc and ‘Accept’ will return the user with the new Arc selected.
 
### Arc View – Archived  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/ArcView_Archived.png)</kbd>  
This screen presents a scrollable list of past Arcs. There may also be Arcs that are still active in this list but that is only to organize the archived tasks in their tree. Tapping on an Arc tile will go deeper into the archived Arc tree. Tapping the back arrow in the bottom right-hand side will return the user to the previous screen.
 
### Task View – Archived  
<kbd>![](https://github.com/smacademic/project-cgkm/wiki/assets/uiDesignTemplateScreenshots/TaskView_Archived.png)</kbd>  
This screen shows the user the details of an archived task. This is only to allow the user to review their completed tasks, then cannot edit a task after it has been archived. Tapping the back arrow in the bottom right-hand side will return the user to the previous screen.


