import "package:flutter/material.dart";
import "package:fitness_app/Widgets/utils.dart";
import 'dart:math';

SizeUtil get _sizeUtil {
  return SizeUtil.getInstance(key: SizeKeyConst.CIRCLE_KEY);
}

class LineCircle {
  static Point<double> radianPoint(Point center, double r, double radian) {
    return Point(center.x + r * cos(radian), center.y + r * sin(radian));
  }
}

class CirclePainter extends CustomPainter {
  final double startAngle;
  final List<Color> colors;

  CirclePainter(
      {super.repaint,
      required this.startAngle,
      this.colors = const [Colors.blue, Colors.red]});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width > 1.0 && size.height > 1.0) {
      _sizeUtil.logicSize = size;
    }
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..isAntiAlias = true;
    paint.color = Colors.grey.shade900;
    paint.color = Colors.red;
    paint.strokeWidth = 20;
    paint.style = PaintingStyle.stroke;
    var center = Offset(
      _sizeUtil.getAxisX(250.0),
      _sizeUtil.getAxisY(250.0),
    );
    var radius = _sizeUtil.getAxisBoth(200);
    _drawArcGroup(
      canvas,
      center: center,
      radius: radius,
      sources: [1, 1, 1, 1, 1, 1, 1, 1, 1],
      colors: colors,
      paintWidth: 80.0,
      startAngle: 1.3 * startAngle / radius,
      hasEnd: true,
      hasCurrent: false,
      curPaintWidth: 45.0,
      curIndex: 1,
    );
    canvas.save();
    canvas.restore();
  }

  void _drawArcGroup(Canvas canvas,
      {required Offset center,
      required double radius,
      required List<double> sources,
      required List<Color> colors,
      double startAngle = 0.0,
      double paintWidth = 10.0,
      bool hasEnd = false,
      hasCurrent = false,
      int curIndex = 0,
      curPaintWidth = 12.0}) {
    assert(sources.isNotEmpty);
    assert(colors.isNotEmpty);

    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black
      ..strokeWidth = paintWidth
      ..isAntiAlias = true;
    double total = 0;
    for (double d in sources) {
      total += d;
    }
    assert(total > 0.0);
    List<double> radians = [];
    for (double d in sources) {
      double radian = d * 2 * pi / total;
      radians.add(radian);
    }
    var startA = startAngle;
    paint.style = PaintingStyle.stroke;
    var curStartAngle = 0.0;
    for (int i = 0; i < radians.length; i++) {
      var rd = radians[i];
      if (hasCurrent && curIndex == i) {
        curStartAngle = startA;
        startA += rd;
        continue;
      }
      paint.color = colors[i % colors.length];
      paint.strokeWidth = paintWidth;
      _drawArcWithCenter(canvas, paint,
          center: center, radius: radius, startRadian: startA, sweepRadian: rd);
      startA += rd;
    }
    if (hasEnd) {
      startA = startAngle;
      paint.strokeWidth = paintWidth;
      for (int i = 0; i < radians.length; i++) {
        var rd = radians[i];
        if (hasCurrent && curIndex == i) {
          startA += rd;
          continue;
        }
        paint.color = colors[i % colors.length];
        paint.strokeWidth = paintWidth;
        _drawArcTwoPoint(canvas, paint,
            center: center,
            radius: radius,
            startRadian: startA,
            sweepRadian: rd,
            hasEndArc: true);
        startA += rd;
      }
    }

    if (hasCurrent) {
      paint.color = colors[curIndex % colors.length];
      paint.strokeWidth = curPaintWidth;
      paint.style = PaintingStyle.stroke;
      _drawArcWithCenter(canvas, paint,
          center: center,
          radius: radius,
          startRadian: curStartAngle,
          sweepRadian: radians[curIndex]);
    }
    if (hasCurrent && hasEnd) {
      var rd = radians[curIndex % radians.length];
      paint.color = colors[curIndex % colors.length];
      paint.strokeWidth = curPaintWidth;
      paint.style = PaintingStyle.fill;
      _drawArcTwoPoint(canvas, paint,
          center: center,
          radius: radius,
          startRadian: curStartAngle,
          sweepRadian: rd,
          hasEndArc: true,
          hasStartArc: true);
    }
  }

  void _drawArcWithCenter(
    Canvas canvas,
    Paint paint, {
    required Offset center,
    required double radius,
    startRadian = 0.0,
    sweepRadian = pi,
  }) {
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startRadian,
      sweepRadian,
      false,
      paint,
    );
  }

  void _drawArcTwoPoint(Canvas canvas, Paint paint,
      {required Offset center,
      required double radius,
      startRadian = 0.0,
      sweepRadian = pi,
      hasStartArc = false,
      hasEndArc = false}) {
    var smallR = paint.strokeWidth / 2;
    paint.strokeWidth = smallR;
    if (hasStartArc) {
      var startCenter = LineCircle.radianPoint(
          Point(center.dx, center.dy), radius, startRadian);
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(startCenter.x, startCenter.y), smallR, paint);
    }
    if (hasEndArc) {
      var endCenter = LineCircle.radianPoint(
          Point(center.dx, center.dy), radius, startRadian + sweepRadian);
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(endCenter.x, endCenter.y), smallR, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
