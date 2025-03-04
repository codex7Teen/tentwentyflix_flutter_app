import 'package:flutter/cupertino.dart';

class ScreenDimensionsUtil {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
