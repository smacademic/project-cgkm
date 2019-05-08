/** 
 *  Team CGKM - Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 
 *
 *  Authors: 
 *    Primary: Kevin Kelly
 *    Contributors: 
 * 
 *  Provided as is. No warranties expressed or implied. Use at your own risk.
 *
 *  This file contains ArcPlanner's home screen which will be displayed on 
 *  launch. The screen shows users a list of upcoming tasks along with a Task 
 *  quick-add button.
 */

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:date_utils/date_utils.dart';
import 'drawer_menu.dart';
import '../blocs/bloc.dart';
import 'arc_tile.dart';
import 'task_tile.dart';
import '../model/arc.dart';
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

    _controller.forward();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  void _updateFromStream(int month, int year) {
    bloc.calendarInsert({'month': month,'year': year, 'flag': 'getCalendarEvents'});
  }

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

                    if (snapshot.connectionState == ConnectionState.done) {
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
                      } else {
                        return _noItemsWidget();
                      }
                    } else {
                      return _noItemsWidget();
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

  void _populateBuildList() {
    _buildList.clear();
    _dayEvents.forEach((String key, dynamic obj) {
      _buildList.add(obj);
    });

    //_buildList.sort((a, b) => a.timeDue.compareTo(b.timeDue));
  }

  // Takes the Arcs/Tasks in _loadedEvents and adds them to the _events List
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

    _visibleEvents = _events;

    _controller.forward(from: 0.0);
  }

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

  // More advanced TableCalendar configuration (using Builders & Styles)
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
}

Widget tile(dynamic obj, BuildContext context) {
  if (obj is Arc) {
    return arcTile(obj, context);
  } else if (obj is Task) {
    return taskTile(obj, context);
  } else {
    return Text('tile tried to build not an Arc or Task');
  }
}