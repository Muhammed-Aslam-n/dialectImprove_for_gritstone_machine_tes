import 'package:flutter/material.dart';
import 'package:gritstone_machine_test/providers/tts_provider.dart';
import 'package:gritstone_machine_test/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

import '../constants/theme.dart';
import '../providers/theme_provider/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onDoubleTap: (){
      //   final tts = Provider.of<TtsProvider>(context,listen: false);
      //   tts.speak('Changing app Fonts');
      // },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                tileColor: Colors.white,
                title: Text(
                  'Turn on High Contrast Theme',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                trailing: Switch(
                  inactiveThumbColor: Colors.blue,
                  value: Provider.of<ThemeProvider>(context).currentTheme ==
                      AppTheme.darkTheme,
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                    final tts = Provider.of<TtsProvider>(context,listen: false);
                    tts.speak('App Theme changed Successfully');
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<ThemeProvider>(builder: (context, fontProvider, _) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  tileColor: Colors.white,
                  title: Text(
                    "Change App's Font",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  trailing: DropdownButton<String>(
                    value: fontProvider.selectedFont,
                    selectedItemBuilder: (BuildContext context) {
                      return <Widget>[
                        for (String value in [
                          'Kalam-Regular',
                          'Poppins-Regular',
                        ]) // Add your font options
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: fontProvider.currentTheme ==
                                    AppTheme.darkTheme
                                    ? Colors.black
                                    : Colors.black,
                              ), // Change font color for selected item
                            ),
                          ),
                      ];
                    },
                    items: <String>[
                      'Kalam-Regular',
                      'Poppins-Regular',
                      // Add more fonts if needed
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: fontProvider.currentTheme ==
                                      AppTheme.darkTheme
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) async {
                      if (newValue != null) {
                        fontProvider.changeFont(newValue);
                        final tts = Provider.of<TtsProvider>(context,listen: false);
                        tts.speak('App Font changed Successfully');
                      }
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
