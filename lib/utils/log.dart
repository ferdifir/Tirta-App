// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

class Log {
  static const String _TAG_DEFAULT = "###Default###";

  static void i([Object? message, String tag = _TAG_DEFAULT]) {
    if(kDebugMode) {
      debugPrint("$tag: $message");
    }
  }
}