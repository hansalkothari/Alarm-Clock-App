import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  late Timer timer;
  @override
  void initState() {
    this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerx = size.width / 2;
    var centery = size.height / 2;
    var center = Offset(centerx, centery);
    var radius = min(centerx, centery);

    var fillBrush = Paint()..color = Color(0xFF444974);

    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;

    var centerFillBrush = Paint()..color = Color(0xFFEAECFF);

    var secHandBrush = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(
              Rect.fromCenter(center: center, height: radius, width: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(
              Rect.fromCenter(center: center, height: radius, width: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;

    var dashBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var secHandx = centerx + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandy = centerx + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandx, secHandy), secHandBrush);

    var minHandx = centerx + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandy = centerx + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandx, minHandy), minHandBrush);

    var hourHandx = centerx +
        80 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandy = centerx +
        80 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);

    canvas.drawLine(center, Offset(hourHandx, hourHandy), hourHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    var outerRadius = radius;
    var innerRadius = radius * 0.9;
    for (var i = 0; i < 360; i += 12) {
      var x1 = centerx + outerRadius * cos(i * pi / 180);
      var y1 = centery + outerRadius * sin(i * pi / 180);

      var x2 = centerx + innerRadius * cos(i * pi / 180);
      var y2 = centery + innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
