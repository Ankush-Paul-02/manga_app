import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UIHelper {
  /// Returns a SizedBox with responsive height
  static SizedBox verticalSpace(double heightPercent) {
    return SizedBox(height: heightPercent.h);
  }

  /// Returns a SizedBox with responsive width
  static SizedBox horizontalSpace(double widthPercent) {
    return SizedBox(width: widthPercent.w);
  }
}
