import 'package:flutter/cupertino.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static BuildContext get currentContext => navigatorKey.currentContext!;
}
