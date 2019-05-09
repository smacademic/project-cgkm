/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Matthew Chastain, Kevin Kelly
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains ArcPlanner's Calendar Screen which displays an on-screen 
 *  Calendar which can be scrolled for different months. Below the Calendar is a
 *  list of Arcs or Tasks that are set to be due on the selected day. Due to the 
 *  scrolling nature of the Calendar, it is implemented as a exention of a 
 *  StatefulWidget.
 */

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:date_utils/date_utils.dart';
import 'drawer_menu.dart';
import '../blocs/bloc.dart';
import '../helpers/tile.dart';
import '../model/task.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreen createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen> with TickerProviderStateMixin { 

  List<dynamic> _buildList;
  Map<String, dynamic> _loadedEvents;
  Map<String, dynamic> _dayEvents;
  int _month;
  int _year;
  DateTime _selectedDay;
  Map<DateTime, List> _events;
  Map<DateTime, List> _visibleEvents;
  List _selectedEvents;
  AnimationController _controller;
  List<dynamic> snapshotData;

  /// Establishes initial state of the Calendar Screen
  @override
  void initState() {    
    super.initState();
    _month = DateTime.now().month;
    _year = DateTime.now().year;
    _selectedDay = DateTime.now();
    _events = {};
    _loadedEvents = Map<String, dynamic>();
    _dayEvents = Map<String, dynamic>();
    _buildList = List<dynamic>();
    _selectedEvents = _events[_selectedDay] ?? [];
    _visibleEvents = _events;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    // _controller.forward();
  }

  /// Changes the selected date in response to user event
  /// @param day the day selected by the user
  /// @param events list of events associated with that day
  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  /// Sends information to `bloc.dart` through bloc.calendarStream
  /// @param month month to retrieve items for
  /// @param year year to retrieve items for 
  void _updateFromStream(int month, int year) {
    bloc.calendarInsert({'month': month,'year': year, 'flag': 'getCalendarEvents'});
  }

  /// Changes the current calendar view in response to user event
  /// @param first the first day of new calendar view
  /// @param last the last day of new calendar view
  /// @param format the formatting of the calendar view
  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    _year = first.year;
    _month = first.month;

    _selectedDay = first;
    _selectedEvents.clear();
    _visibleEvents.clear();
    _events.clear();
    _loadedEvents.clear();
    
    setState(() {});
  }

  /// Build method for the Calendar Screen
  /// @param context BuildContext for Calendar Screen
  @override
  Widget build(BuildContext context) {
    bool firstTimeLoading = true;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Calendar"),
      ),
      
      body: Column(
        children: <Widget>[
          _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          Expanded(
            child: StreamBuilder(
              stream: bloc.calendarStream,
              builder: (context, snapshot) {
                _controller.forward(from: 0.0);
                return new FutureBuilder(
                  future: snapshot.data,
                  builder: (context, snapshot) {
                    if (firstTimeLoading) {
                      _updateFromStream(_month, _year);
                      firstTimeLoading = false;
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildTileList();
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      snapshotData = snapshot.data;

                      if (snapshotData.toString() != '[]') {
                        // adding objects from stream into _loadedEvents
                        for (dynamic obj in snapshotData) {
                          if (!_isInLoadedEvents(obj)) {
                            if (_events[DateTime.parse(obj.dueDate)] == null) {
                              _events[DateTime.parse(obj.dueDate)] = [];
                            }
                            _events[DateTime.parse(obj.dueDate)].add(obj);
                            if (obj is Task) {
                              _loadedEvents.addAll({obj.tid: obj});
                            } else {
                              _loadedEvents.addAll({obj.aid: obj});
                            }
                          }
                        }

                        _loadedEvents.removeWhere((String key, dynamic obj) {
                          return DateTime.parse(obj.dueDate).month != _month;
                        });

                        _updateDayEvents();
                        return _buildTileList();
                      } else {
                        return _noItemsWidget();
                      }
                    } else {
                      return Container();
                    }
                  },
                );
              }
            ),
          ),
        ],
      ),
      
      drawer: drawerMenu(context)
    );
  }

  /// Builds the list of items to display below the on-screen Calendar
  void _populateBuildList() {
    _buildList.clear();
    _dayEvents.forEach((String key, dynamic obj) {
      _buildList.add(obj);
    });

    //_buildList.sort((a, b) => a.timeDue.compareTo(b.timeDue));
  }

  /// Updates the list of events occuring on the selected day
  void _updateDayEvents() {
    _dayEvents.clear();

    _loadedEvents.forEach((String key, dynamic obj) {
      if (!_isInDayEvents(obj) &&
      DateTime.parse(obj.dueDate).year == _selectedDay.year && 
      DateTime.parse(obj.dueDate).month == _selectedDay.month && 
      DateTime.parse(obj.dueDate).day == _selectedDay.day) {
        _dayEvents.addAll({key: obj});
      }
    });
  }

  /// Checks if an obj is in the list of selected day events
  /// @param obj Arc or Task to check for
  bool _isInDayEvents(dynamic obj) {
    if (obj is Task) {
      if (_dayEvents.containsKey(obj.tid)) {
        return true;
      } else {
        return false;
      }
    } else {
      if (_dayEvents.containsKey(obj.aid)) {
        return true;
      } else {
        return false;
      }
    }
  }

  /// Checks if an obj is in the list of currently loaded events
  /// @param obj Arc or Task to check for
  bool _isInLoadedEvents(dynamic obj) {
    if (obj is Task) {
      if (_loadedEvents.containsKey(obj.tid)) {
        return true;
      } else {
        return false;
      }
    } else {
      if (_loadedEvents.containsKey(obj.aid)) {
        return true;
      } else {
        return false;
      }
    }
  }

  /// Build script for 'No Arcs/Tasks' message
  Widget _noItemsWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'There are no items for this day',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }


  /// Build roster for TableCalendar
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'en_US',
      events: _visibleEvents,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        outsideWeekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_controller),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.red[200],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.green[300],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events) {
          return Positioned(
            right: 1,
            bottom: 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Utils.isSameDay(date, _selectedDay)
                    ? Colors.deepOrange
                    : Utils.isSameDay(date, DateTime.now()) ? Colors.deepOrange : Colors.blue[400],
              ),
              width: 16.0,
              height: 16.0,
              child: Center(
                child: Text(
                  '${events.length}',
                  style: TextStyle().copyWith(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _controller.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  /// Builds the list of tiles displayed underneath the on-screen Calendar
  Widget _buildTileList() {
    if (_dayEvents.isNotEmpty) {
      _populateBuildList();
      return ListView.builder(
        itemCount: _buildList.length,
        itemBuilder: (context, index) {
          return tile(_buildList[index], context);
        },
      );
    } else {
      return _noItemsWidget();
    }
  }
}