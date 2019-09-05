import 'dart:ui';

import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-05 09:21
 * 类说明:
 */

class RhombusCustomPainter extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, 0.0)
      ..lineTo(10.0, 20.0)
      ..lineTo(0.0, 40.0)
      ..lineTo(70.0, 40.0)
      ..lineTo(80.0, 20.0)
      ..lineTo(70.0, 0.0)
      ..lineTo(0.0, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
