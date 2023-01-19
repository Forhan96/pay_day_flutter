import 'package:flutter/foundation.dart';

class Debugger {
  static void debug({required String title, dynamic data}) {
    if (kDebugMode) {
      print("-----------:> $title :<-----------:start");
      print(data);
      print("-----------:> $title :<-----------:end");
    }
  }
}
