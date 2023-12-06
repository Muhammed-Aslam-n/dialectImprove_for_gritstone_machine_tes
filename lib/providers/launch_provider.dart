import 'package:flutter/foundation.dart';

import '../service/shared_preference_helper.dart';

class LaunchProvider extends ChangeNotifier {

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<bool> makeADelay() async {
    return true;
  }
}
