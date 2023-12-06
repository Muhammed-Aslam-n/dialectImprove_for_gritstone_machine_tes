import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gritstone_machine_test/constants/app_relates.dart';
import 'package:gritstone_machine_test/constants/theme.dart';
import 'package:gritstone_machine_test/providers/theme_provider/theme_provider.dart';
import 'package:gritstone_machine_test/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../providers/launch_provider.dart';
import '../utils/route_transition.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  double _opacity = 0.0;
  final double _logoRotation = 0.0;

  @override
  void initState() {
    // Start the animation after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    // Future.delayed(
    //     const Duration(seconds: 3),
    //     () => Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(builder: (context) => const HomeScreen()),
    //         ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureProvider(
        create: (_) {
          final LaunchProvider authProvider = LaunchProvider();
          return authProvider.makeADelay();
        },
        initialData: null,
        child: Consumer<LaunchProvider>(
          builder: (context, authProvider, _) {
            if (mounted) {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.pushReplacement(
                  context,
                  CustomPageRoute(page: const HomeScreen()),
                );
              });
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: -0.1, end: 0.0),
                    duration: const Duration(milliseconds: 2500),
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value + _logoRotation,
                        child: Image.asset(
                          'assets/icons/launch_icon.png',
                          height: 50,
                          width: 50,
                          color: Provider.of<ThemeProvider>(context).currentTheme == AppTheme.darkTheme? Colors.black:Colors.green,
                        ),
                      );
                    },
                  ),
                  AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: _opacity,
                    child: Text(
                      AppConst.appName,
                      style: GoogleFonts.aBeeZee(
                        color: Provider.of<ThemeProvider>(context).currentTheme == AppTheme.darkTheme? Colors.black:Colors.green,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
