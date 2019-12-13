import 'dart:async';
import 'package:coder_matthews_clock/drawTools.dart';
import 'package:coder_matthews_clock/utils/utilFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'package:intl/intl.dart';

final radiansPerTick = radians(360 / 60);
final radiansPerHour = radians(360 / 12);

class ClockHome extends StatefulWidget {
  const ClockHome(this.model);

  final ClockModel model;
  @override
  _ClockHomeState createState() => _ClockHomeState();
}

class _ClockHomeState extends State<ClockHome> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  List<Widget> numbers;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(ClockHome oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      // _timer = Timer(
      //   Duration(seconds: 1) -
      //       Duration(seconds: _dateTime.second) -
      //       Duration(milliseconds: _dateTime.millisecond) - Duration(microseconds: _dateTime.microsecond),
      //   _updateTime,
      // );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(
            milliseconds:
                1), // - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    double siz = MediaQuery.of(context).size.longestSide *0.4;
    int second = _dateTime.second;
    int minute = _dateTime.minute;
    int hour = _dateTime.hour;
    Brightness brightness = Theme.of(context).brightness;
    double iconSize = MediaQuery.of(context).size.longestSide *0.4;
    Color strokeColor = 
        brightness == Brightness.dark ? Color(0xFF2B8ED9) : Color(0xFF0D2A40);
    Color handFill = brightness == Brightness.dark ? Color(0xFF1e6499) : Color(0xFF267cbe);
    Color background = brightness == Brightness.dark ? Color(0xFF170721) : Color(0x6fb0acff);
    String date = DateFormat('MMM. dd').format(_dateTime);
    return SafeArea(
      child: Container(
        color: background,
          child: Stack(
        children: <Widget>[
          //temperature
          Container(
            alignment: Alignment.bottomLeft,
            child: FractionallySizedBox(
              heightFactor: 0.076,
              child: FittedBox(child: getTemperature(widget.model.temperature, widget.model.unitString, iconSize, strokeColor),
              )
            )
          ),
          //digital time
          Container(
            alignment: Alignment.bottomRight,
            child: FractionallySizedBox(
              heightFactor: 0.115,
              child: FittedBox(
                  child: getTime(_dateTime, widget.model.is24HourFormat, iconSize, strokeColor)),
            ),
          ),
          //date
          Container(
            child: Text(
              date,
            ),
            alignment: Alignment.bottomCenter,
          ),
          //location
          Container(
            child: Text(
              widget.model.location,
            ),
            alignment: Alignment.topRight,
          ),
          //weather symbol
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(8),
            child: FractionallySizedBox(
              heightFactor: 0.4,
              child: FittedBox(
                child: getWeatherIcon(widget.model.weatherString, 64),
              ),
            ),
          ),
          //clock tick marks
          new DrawItem(
            item: TickMarks(0.8, strokeColor),
          ),
          //hour hand
          new DrawItem(
            item: new DrawClockHand(
              hour * radiansPerHour + (minute / 60) * radiansPerHour,
              0.58,
              outline: strokeColor,
              fill: handFill,
            ),
          ),
          //minute hand
          new DrawItem(
            item: new DrawClockHand(minute * radiansPerTick, 0.84,
                outline: strokeColor, fill: handFill),
          ),
          //seconds hand
          new DrawItem(
            item: new DrawClockHand(
                (second + _dateTime.millisecond / 1000) * radiansPerTick, 0.95,
                outline: strokeColor, fill: Colors.white, wings: false),
          ),
          new DrawItem(
            item: new DrawCircle(0.02, PaintingStyle.fill, color: strokeColor),
          ),
        ],
      )),
    );
  }
}