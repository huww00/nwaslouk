import 'package:flutter/material.dart';

class AppShadows {
  static const List<BoxShadow> card = [
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), offset: Offset(0, 6), blurRadius: 12),
    BoxShadow(color: Color.fromRGBO(255, 255, 255, 0.8), offset: Offset(-6, -6), blurRadius: 12),
  ];

  static const List<BoxShadow> button = [
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.10), offset: Offset(0, 3), blurRadius: 6),
  ];

  static const List<BoxShadow> fab = [
    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.14), offset: Offset(0, 8), blurRadius: 18),
  ];
}