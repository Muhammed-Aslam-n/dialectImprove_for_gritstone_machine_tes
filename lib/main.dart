import 'package:flutter/material.dart';
import 'package:gritstone_machine_test/providers/connectivity_provider.dart';
import 'package:gritstone_machine_test/providers/launch_provider.dart';
import 'package:gritstone_machine_test/providers/stt_provider.dart';
import 'package:gritstone_machine_test/providers/theme_provider/theme_provider.dart';
import 'package:gritstone_machine_test/providers/tts_provider.dart';
import 'package:gritstone_machine_test/screens/launch_screens.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (create) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LaunchProvider(),
        ),
        FutureProvider(
          create: (create) => TtsProvider().fetchSavedNotes(),
          initialData: const [],
        ),
        ChangeNotifierProvider(
          create: (create) => TtsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SpeechToUserTextProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
  ConnectivityProvider().initConnectivity();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final currentTheme = themeProvider.currentTheme;
        return Builder(
          builder: (context) => MaterialApp(
            theme: currentTheme,
            debugShowCheckedModeBanner: false,
            home: const LaunchScreen(),
          ),
        );
      },
    );
  }
}
