import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' show radians;

class DrawClockHand extends CustomPainter {
  final double time;
  final double length;
  final Color outline;
  final bool wings;
  final Color fill;
  DrawClockHand(this.time, this.length,
      {this.fill,
      this.wings = true,
      this.outline});
  @override
  void paint(Canvas canvas, Size size) {
   Offset center = (Offset.zero & size).center;
   final length = size.shortestSide * 0.5 * this.length;
    final angle = time - math.pi / 2;
    final firstAngle = angle + math.pi / 16;
    final secondAngle = firstAngle - 3 * math.pi / 32;
    final inverseFirstAngle = angle - math.pi / 16;
    final inverseSecondAngle = inverseFirstAngle + 3 * math.pi / 32;
    final firstOffset = center +
        Offset(math.cos(firstAngle), math.sin(firstAngle)) * (length / 4);
    final secondOffset = firstOffset +
        Offset(math.cos(secondAngle), math.sin(secondAngle)) * (length / 2);

    final inverseFirstOffset = center +
        Offset(math.cos(inverseFirstAngle), math.sin(inverseFirstAngle)) *
            (length / 4);
    final inverseSecondOffset = inverseFirstOffset +
        Offset(math.cos(inverseSecondAngle), math.sin(inverseSecondAngle)) *
            (length / 2);
    var paint = new Paint();

    paint
      ..color = this.outline
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    canvas.drawLine(center,
        center + Offset(math.cos(angle), math.sin(angle)) * length, paint);
    //canvas.drawCircle(new Offset(size.width/2, size.height/2),me, paint);
    paint
      ..color = this.fill
      ..style = PaintingStyle.fill;
    if (this.wings) {
      var path = Path()
        ..moveTo(center.dx, center.dy)
        //..relativeConicTo( center.dx, center.dy,firstOffset.dx, firstOffset.dy, 1.2)
        ..lineTo(firstOffset.dx, firstOffset.dy)
        ..lineTo(secondOffset.dx, secondOffset.dy)
        ..lineTo(inverseFirstOffset.dx, inverseFirstOffset.dy)
        ..lineTo(center.dx, center.dy)
        ..close();
      canvas.drawPath(path, paint);
      paint.color = this.outline;
      canvas.drawLine(center, firstOffset, paint);
      canvas.drawLine(firstOffset, secondOffset, paint);
      canvas.drawLine(center, inverseFirstOffset, paint);
      canvas.drawLine(inverseFirstOffset, inverseSecondOffset, paint);
    }

    // canvas.drawLine(center,
    //     center + Offset(math.cos(angle), math.sin(angle)) * length, paint);
  }

  @override
  bool shouldRepaint(DrawClockHand oldDelegate) {
    return oldDelegate.time != time;
  }
}

class DrawCircle extends CustomPainter {
  final double radius;
  final PaintingStyle style;
  final Color color;
  DrawCircle(this.radius, this.style, {this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    double rad = size.shortestSide * 0.5 * radius;
    var paint = new Paint();
    paint
      ..color = this.color
      ..strokeWidth = 1
      ..style = this.style;
    canvas.drawCircle(
        (Offset.zero & size).center, rad, paint);
  }

  @override
  bool shouldRepaint(DrawCircle oldDelegate) {
    return true;
  }
}

class TickMarks extends CustomPainter {
  final double size;
  final Color color;


  TickMarks(this.size, this.color);
    Offset getTicking(int tickDistance) {
    return Offset(math.cos(tickDistance * radians(360 / 60) - math.pi / 2),
        math.sin(tickDistance * radians(360 / 60) - math.pi / 2));
  }
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    Offset center = (Offset.zero & size).center;
    var paint = new Paint();
    double lineLength = size.shortestSide * 0.5;
    paint
      ..color = this.color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 60; i++) {
      double strokeLength = i % 5 == 0 ? lineLength * 1 : lineLength * 0.96;
      double fifth = i % 5 == 0 ? lineLength * 0.82 : lineLength * 0.88;
      canvas.drawLine(center + getTicking(i) * this.size * strokeLength,
          center + getTicking(i) * this.size * fifth, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawItem extends StatefulWidget {
  final CustomPainter item;

  const DrawItem({Key key, this.item}) : super(key: key);
  @override
  _DrawItemState createState() => _DrawItemState();
}

class _DrawItemState extends State<DrawItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox.expand(
        child: CustomPaint(
      painter: widget.item,
    )));
  }
}
