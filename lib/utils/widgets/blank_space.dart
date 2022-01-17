import 'package:flutter/cupertino.dart';

class BlankSpace {
  static Widget bottom(double amount) =>
      Padding(padding: EdgeInsets.only(bottom: amount));
  static Widget right(double amount) =>
      Padding(padding: EdgeInsets.only(right: amount));
}
