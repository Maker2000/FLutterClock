import 'package:coder_matthews_clock/utils/coder_matthews_custom_clock_icons_icons.dart';
import 'package:flutter/material.dart';

Widget getWeatherIcon(String weather, double size) {
  weather.toLowerCase();
  Color darkCloud = Color(0xFF777777);
  
  switch (weather) {
    case 'cloudy':
      return Stack(
        children: <Widget>[
          Positioned(
            left: 1,
            top: 1.4,
            child: Icon(CoderMatthewsCustomClockIcons.weather_cloudy, size: size, color: Colors.grey,),
          ),Icon(CoderMatthewsCustomClockIcons.weather_cloudy, size: size, color: Colors.grey,)
        ]
      );
    case 'foggy':
      return  Stack(
        children: <Widget>[
          Positioned(
            left: 1,
            top: 1.4,
            child: Icon(CoderMatthewsCustomClockIcons.weather_foggy, size: size, color: Colors.grey,),
          ),Icon( CoderMatthewsCustomClockIcons.weather_foggy, size: size, color: Colors.grey,)]);
    case 'rainy':
      return Stack(
        children: <Widget>[
          Positioned(
            left: 1,
            top: 1.4,
            child: Icon(CoderMatthewsCustomClockIcons.weather_rainy, size: size, color: Colors.grey,),
          ),Icon( CoderMatthewsCustomClockIcons.weather_rainy, size: size, color: darkCloud,)]);
    case 'snowy':
      return  Stack(
        children: <Widget>[
          Positioned(
            left: 1,
            top: 1.4,
            child: Icon(CoderMatthewsCustomClockIcons.weather_snowy, size: size, color: Colors.grey,),
          ),
          Icon(CoderMatthewsCustomClockIcons.weather_snowy, size: size, color: Colors.white,),
        ],
      );
    case 'sunny':
      return  Stack(
        children: <Widget>[
          Positioned(
            left: 1,
            top: 1.4,
            child: Icon(CoderMatthewsCustomClockIcons.weather_sunny, size: size, color: Colors.grey,),
          ),Icon(CoderMatthewsCustomClockIcons.weather_sunny, size: size, color: Colors.orange,)]);
    case 'thunderstorm':
      return  Stack(
        children: <Widget>[
          Positioned(
            left: 1,
            top: 1.4,
            child: Icon(CoderMatthewsCustomClockIcons.weather_thunderstorm, size: size, color: Colors.grey,),
          ),Icon(CoderMatthewsCustomClockIcons.weather_thunderstorm, size: size, color: darkCloud,)]);
    case 'windy':
      return Stack(
        children: <Widget>[
          Positioned(
            left: 1,
            top: 1.4,
            child: Icon(CoderMatthewsCustomClockIcons.weather_windy, size: size, color: Colors.grey,),
          ),Icon(CoderMatthewsCustomClockIcons.weather_windy, size: size,  color: Colors.cyan,)
        ]);
    default:
      return Text(weather);
  }
}

IconData getNumber(int number) {
  switch (number) {
    case 0:
      return CoderMatthewsCustomClockIcons.block_num_0;
    case 1:
      return CoderMatthewsCustomClockIcons.block_num_1;
    case 2:
      return CoderMatthewsCustomClockIcons.block_num_2;
    case 3:
      return CoderMatthewsCustomClockIcons.block_num_3;
    case 4:
      return CoderMatthewsCustomClockIcons.block_num_4;
    case 5:
      return CoderMatthewsCustomClockIcons.block_num_5;
    case 6:
      return CoderMatthewsCustomClockIcons.block_num_6;
    case 7:
      return CoderMatthewsCustomClockIcons.block_num_7;
    case 8:
      return CoderMatthewsCustomClockIcons.block_num_8;
    default:
      return CoderMatthewsCustomClockIcons.block_num_9;
  }
}

Widget getTime(DateTime time, bool is24Hr, double iconSize, Color strokeColor) {
  List<Widget> returnTime = new List();
  List<Widget> am = [
    Icon(
      CoderMatthewsCustomClockIcons.block_let_a,
      size: iconSize / 1.5,
      color: strokeColor,
    ),
    Icon(
      CoderMatthewsCustomClockIcons.block_let_m,
      size: iconSize / 1.5,
      color: strokeColor,
    )
  ];
  List<Widget> pm = [
    Icon(
      CoderMatthewsCustomClockIcons.block_let_p,
      size: iconSize / 1.5,
      color: strokeColor,
    ),
    Icon(
      CoderMatthewsCustomClockIcons.block_let_m,
      size: iconSize / 1.5,
      color: strokeColor,
    )
  ];
  int amPm = time.hour ~/ 12;

  String hour = is24Hr ? time.hour.toString() : (time.hour % 12).toString();
  String minute = time.minute.toString();
  List hr = hour.split('');
  List min = minute.split('');
  List<Widget> minutes;
  List<Widget> hours;
  if (hour == '0' && !is24Hr)
    hours = [
      Icon(
        getNumber(1),
        size: iconSize,
        color: strokeColor,
      ),
      Icon(
        getNumber(2),
        size: iconSize,
        color: strokeColor,
      )
    ];
  else if (hr.length == 1 && is24Hr)
    hours = [
      Icon(
        getNumber(0),
        size: iconSize,
        color: strokeColor,
      ),
      Icon(
        getNumber(int.parse(hr[0])),
        size: iconSize,
        color: strokeColor,
      )
    ];
  else if (hr.length == 1 && is24Hr == false)
    hours = [
      Icon(
        getNumber(int.parse(hr[0])),
        size: iconSize,
        color: strokeColor,
      )
    ];
  else
    hours = [
      Icon(
        getNumber(int.parse(hr[0])),
        size: iconSize,
        color: strokeColor,
      ),
      Icon(
        getNumber(int.parse(hr[1])),
        size: iconSize,
        color: strokeColor,
      )
    ];

  if (min.length == 1)
    minutes = [
      Icon(
        getNumber(0),
        size: iconSize,
        color: strokeColor,
      ),
      Icon(
        getNumber(int.parse(min[0])),
        size: iconSize,
        color: strokeColor,
      )
    ];
  else
    minutes = [
      Icon(
        getNumber(int.parse(min[0])),
        size: iconSize,
        color: strokeColor,
      ),
      Icon(
        getNumber(int.parse(min[1])),
        size: iconSize,
        color: strokeColor,
      )
    ];
  returnTime.addAll(hours);
  returnTime.add(Container(
    padding: EdgeInsets.only(bottom: 4),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            CoderMatthewsCustomClockIcons.block_dot,
            size: iconSize / 4,
            color: strokeColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            CoderMatthewsCustomClockIcons.block_dot,
            size: iconSize / 4,
            color: strokeColor,
          ),
        ),
      ],
    ),
  ));
  returnTime.addAll(minutes);
  if (!is24Hr) {
    if (amPm > 0)
      returnTime.addAll(pm);
    else
      returnTime.addAll(am);
  }

  return Container(
    padding: EdgeInsets.only(bottom: 4),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: returnTime,
    ),
  );
}

Widget getTemperature(
    double temperature, String format, double iconSize, Color strokeColor) {
  String temp = temperature.toStringAsFixed(1);
  List<Widget> returnTemp = new List();
  List<Widget> dF = [
    Icon(
      CoderMatthewsCustomClockIcons.block_degree,
      size: iconSize,
      color: strokeColor,
    ),
    Icon(
      CoderMatthewsCustomClockIcons.block_let_f,
      size: iconSize,
      color: strokeColor,
    )
  ];
  List<Widget> dC = [
    Icon(
      CoderMatthewsCustomClockIcons.block_degree,
      size: iconSize,
      color: strokeColor,
    ),
    Icon(
      CoderMatthewsCustomClockIcons.block_let_c,
      size: iconSize,
      color: strokeColor,
    )
  ];
  List<String> numbers = temp.split('');
  for (var item in numbers)
    returnTemp.add(Icon(
      item == '.'
          ? CoderMatthewsCustomClockIcons.block_dot
          : getNumber(int.parse(item)),
      size: item == '.' ? iconSize / 4 : iconSize,
      color: strokeColor,
    ));
  if (format == '°C')
    returnTemp.addAll(dC);
  else
    returnTemp.addAll(dF);
  return Container(
    padding: EdgeInsets.only(bottom: 12),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: returnTemp,
    ),
  );
}
