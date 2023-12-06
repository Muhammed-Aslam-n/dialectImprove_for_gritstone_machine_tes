
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gritstone_machine_test/constants/app_relates.dart';
import 'package:gritstone_machine_test/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

import '../providers/tts_provider.dart';
import '../screens/about_screen.dart';
import '../screens/invite_friends_screen.dart';
import '../screens/settings_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final List<String> drawerItemList = [
    'Home',
    'Invite Friends',
    'Settings',
    'About'
  ];

  final List<String> drawerImages = [
    'assets/icons/home.png',
    'assets/icons/invitation.png',
    'assets/icons/settings.png',
    'assets/icons/info.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.12,
            decoration:
            BoxDecoration(color: Theme
                .of(context)
                .scaffoldBackgroundColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  runSpacing: 0,
                  spacing: 0,
                  children: [
                    Image.asset(
                      'assets/icons/launch_icon.png',
                      height: 35,
                      width: 25,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        AppConst.appName,
                        style: GoogleFonts.aBeeZee(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Improve your tasks',
                  style: GoogleFonts.abel(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          for (var drawerIndex = 0;
          drawerIndex < drawerItemList.length;
          drawerIndex++)
            DrawerItemWidget(
              onTap: () => changeThePage(drawerIndex, context),
              leadingItemUrl: drawerImages[drawerIndex],
              titleText: drawerItemList[drawerIndex],
              index: drawerIndex,
            ),
          const Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'All Right Reserved ©',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  changeThePage(index, BuildContext context) {
    switch (index) {
      case 0:
        Scaffold.of(context).closeDrawer();
        break;
      case 1:
        Scaffold.of(context).closeDrawer();
        final ttsProvider = Provider.of<TtsProvider>(context,listen: false);
        ttsProvider.speak('Invite Friends screen selected');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => const InviteFriendsScreen()));

        break;
      case 2:
        Scaffold.of(context).closeDrawer();
        final ttsProvider = Provider.of<TtsProvider>(context,listen: false);
        ttsProvider.speak('settings screen selected');
        Navigator.push(context,
            MaterialPageRoute(builder: (builder) => const SettingsScreen()));
        break;
      case 3:
        Scaffold.of(context).closeDrawer();
        final ttsProvider = Provider.of<TtsProvider>(context,listen: false);
        ttsProvider.speak('About app screen selected');
        Navigator.push(context,
            MaterialPageRoute(builder: (builder) => const AboutScreen()));
        break;
    }
  }
}

class DrawerItemWidget extends StatelessWidget {
  final Function()? onTap;
  final String? leadingItemUrl;
  final String? titleText;
  final int index;

  const DrawerItemWidget({
    Key? key,
    this.onTap,
    this.leadingItemUrl,
    this.titleText,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        // tileColor: Theme.of(context).col,
        leading: AspectRatio(
            aspectRatio: index == 2
                ? 0.5 / 1.68
                : index == 4
                ? 0.5 / 1.2
                : 0.5 / 1.5,
            child: Image.asset(
              leadingItemUrl ?? '',
              height: 30,
              width: 30,
              color: Theme
                  .of(context)
                  .highlightColor,
            )),
        title: Text(
          titleText ?? '',
          style:TextStyle(
            color:  Theme
                .of(context)
                .highlightColor
          ),
        ),
      ),
    );
  }
}
