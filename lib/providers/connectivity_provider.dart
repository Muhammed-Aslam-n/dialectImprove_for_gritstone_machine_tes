import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gritstone_machine_test/providers/tts_provider.dart';

class ConnectivityProvider extends ChangeNotifier {
  static final ConnectivityProvider _instance =
      ConnectivityProvider._internal();

  factory ConnectivityProvider() => _instance;

  ConnectivityProvider._internal();

  bool _isConnected = true; // Assume initially connected

  bool get isConnected => _isConnected;

  void initConnectivity() {
    debugPrint('connectivityListenerInitiated');
    Connectivity().onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        // No internet connection
        await Future.delayed(const Duration(seconds: 3))
            .then((value) => TtsProvider().speak('Welcome, No network found'));
        _isConnected = false;
      } else {
        // Internet connected
        await Future.delayed(const Duration(seconds: 3))
            .then((value) => TtsProvider().speak('Welcome, Network connected'));
        _isConnected = true;
      }
      notifyListeners();
    });
  }
}
