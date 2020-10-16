///遇到的问题：
///问题1：如何全局引用context？

import 'package:flutter/material.dart';

void colog(String strMsg) {}

class SACContext {
  static double screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(context) {
    return MediaQuery.of(context).size.height;
  }
}
