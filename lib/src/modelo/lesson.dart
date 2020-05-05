import 'package:flutter/cupertino.dart';

class Lesson {
  String title;
  String level;
  double indicatorValue;
  int price;
  String content;
  Color colour_indicator;

  Lesson(
      {this.title, this.level, this.indicatorValue, this.price, this.content, this.colour_indicator});
}
