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

  List<dynamic> _loadedEvents;
  List<dynamic> _dayEvents;
  int _month;
  int _year;
  DateTime _selectedDay;
  Map<DateTime, List> _events;
  Map<DateTime, List> _visibleEvents;
  List _selectedEvents;
  AnimationController _controller;

  @override
  void initState() {    
    super.initState();
    _month = DateTime.now().month;
    _year = DateTime.now().year;
    _selectedDay = DateTime.now();
    _events = {};
    _loadedEvents = [];
    _dayEvents = [];

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

  void _updateFromStream() {
    bloc.calendarInsert({'month': _month,'year': _year, 'flag': 'getCalendarEvents'});
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    _year = first.year;
    _month = first.month;
    
    setState(() {
      _visibleEvents = Map.fromEntries(
        _events.entries.where(
          (entry) =>
              entry.key.isAfter(first.subtract(const Duration(days: 1))) &&
              entry.key.isBefore(last.add(const Duration(days: 1))),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    bool firstTimeLoading = true;

    return Scaffold(
      appBar: AppBar(
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
                return new FutureBuilder(
                  future: snapshot.data,
                  builder: (context, snapshot) {
                    if (firstTimeLoading) {
                      _updateFromStream();
                      firstTimeLoading = false;
                    }

                    if (snapshot.hasData) {
                      dynamic snapshotData = snapshot.data;

                      if (snapshotData.toString() != '[]') {
                        _dayEvents.clear();
                        _loadedEvents.clear();

                        for (dynamic obj in snapshotData) {
                          _loadedEvents.add(obj);
                        }



                        for (dynamic obj in _loadedEvents) {
                          _events.addAll({DateTime.parse(obj.dueDate): ['']});
                          if (DateTime.parse(obj.dueDate).year == _selectedDay.year && DateTime.parse(obj.dueDate).month == _selectedDay.month && DateTime.parse(obj.dueDate).day == _selectedDay.day) {
                            _dayEvents.add(obj);
                          }
                        }

                        //_dayEvents.sort((a, b) => a.timeDue.compareTo(b.timeDue));

                        if (_dayEvents.isNotEmpty) {
                          return ListView.builder(
                            itemCount: _dayEvents.length,
                            itemBuilder: (context, index) {
                              return tile(_dayEvents[index], context);
                            },
                          );
                        } else {
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
                      } else {
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

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents.map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: () => print('$event tapped!'),
        ),
      )).toList(),
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