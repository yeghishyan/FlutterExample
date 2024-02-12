// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'dart:math';

LinearGradient linearBlue(
    {Alignment start = Alignment.bottomRight,
    Alignment end = Alignment.topLeft}) {
  return LinearGradient(
    begin: start,
    end: end,
    colors: const [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
    stops: const [0.0, 1.0],
  );
}

class SizeKeyConst {
  static const DEVICE_KEY = "device_size";
  static const ROUND_ANGLE_KEY = "round_angle_size";
  static const REGULAR_POLYGON_KEY = "regular_angle_size";
  static const CIRCLE_KEY = "circle custom painter";
  static const CIRCLE_TRIANGLE_KEY = "circle triangle painter";
  static const LOGO_KEY = "logo_page_size";
}

class SizeUtil {
  static final Map<String, SizeUtil> _keyValues = {};

  static initDesignSize() {
    getInstance(key: SizeKeyConst.ROUND_ANGLE_KEY).designSize =
        const Size(500.0, 500.0);
    getInstance(key: SizeKeyConst.REGULAR_POLYGON_KEY).designSize =
        const Size(500.0, 500.0);
    getInstance(key: SizeKeyConst.LOGO_KEY).designSize = 
        const Size(580, 648.0);
    getInstance(key: SizeKeyConst.CIRCLE_KEY).designSize = 
        const Size(500.0, 500.0);
    getInstance(key: SizeKeyConst.CIRCLE_TRIANGLE_KEY).designSize =
        const Size(500.0, 500.0);
  }

  static SizeUtil getInstance({key = SizeKeyConst.DEVICE_KEY}) {
    if (_keyValues.containsKey(key)) {
      return _keyValues[key]!;
    } else {
      _keyValues[key] = SizeUtil();
      return _keyValues[key]!;
    }
  }

  late Size _designSize;

  set designSize(Size size) {
    _designSize = size;
  }

  late Size _logicalSize;

  get width => _logicalSize.width;
  get height => _logicalSize.height;

  set logicSize(Size size) => _logicalSize = size;

  double getAxisX(double w) {
    return (w * width) / _designSize.width;
  }

  double getAxisY(double h) {
    return (h * height) / _designSize.height;
  }

  double getAxisBoth(double s) {
    return s *
        sqrt((width * width + height * height) /
            (_designSize.width * _designSize.width +
                _designSize.height * _designSize.height));
  }
}