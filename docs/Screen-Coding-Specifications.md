# ArcPlanner Screen Coding Specifications #
## Overview ##
This document specifies different aspects of ArcPlanner screen development, including but not limited to panel height and width, font style and size, and colors.  


## General Tips ##
* Wrapping a screen in a `SafeArea` widget avoids the device's OS items, such as the notification bar along the top of Android devices
* When getting the height and width of a device, using the following code snippets:
```
MediaQuery.of(context).size.height
MediaQuery.of(context).size.width
```


## Bottom App Bar ##
* If using a bottom bar in a screen, use the default height of the bar

## Panel Dimensions ##
Panels include the Arc/SubArc/Task tiles in the Arc and Task Views, Home Screen, and Calendar View.  
* Panels should span the width of the device's screen
* Arc/Task panels should be a total of 15% of the screen's height


## Fonts ##
* Use AutoSizeText Objects when possible for proper scaling
    * auto_size_text Dart library
    * `import 'package:auto_size_text/auto_size_text.dart';` after adding to pubspec.yaml

## Help Dialog ##
* Container should be 80% of the screen's height, 90% of the screen's width, and centered   


## Buttons ##
* Use RaisedButton
    * Embedding another structure such as a `Row` in the button allows for adding icons or other items
* Blue Background
* RoundedRectangleBorder
### Example ###
```
RaisedButton(
   onPressed: _sendLogin,
   color: Colors.blue,
   shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
   ),
   child: Text(
      'Login',
      style: TextStyle(
      color: Colors.white,
      fontSize: 22,
      ),
   ),
),
```


## Floating Buttons ##
* Use Icons library to specify desired icon
* Use small size (mini: true)
* Blue background
* White Icons
* onPressed methods need no “()” at the end of the function call and should be given a private member function
### Example ###
```
floatingActionButton: FloatingActionButton(
   child: Icon(Icons.arrow_back),
   backgroundColor: Colors.blue,
   onPressed: _toPreviousScreen,
   mini: true,
),

```

