import 'package:flutter/material.dart';
import 'package:gritstone_machine_test/constants/app_relates.dart';
import 'package:provider/provider.dart';
import '../providers/tts_provider.dart';
import '../widgets/text_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SizedBox sizedBox = SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      floatingActionButton: Consumer<TtsProvider>(
        builder: (context,tts,_) {
          if(tts.isSpeaking){
            return FloatingActionButton(
              onPressed: () {
                final tts = Provider.of<TtsProvider>(context, listen: false);
                tts.stopSpeaking();
              },
              child: Icon(
                Icons.stop,
                color: Colors.white,
              ),
            );
          }
          return FloatingActionButton(
            onPressed: () {
              final tts = Provider.of<TtsProvider>(context, listen: false);
              tts.speak(AppConst.appAbout);
            },
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          );
        }
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sizedBox,
            sizedBox,
            const Text(
              AppConst.appAbout,
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            sizedBox,
            sizedBox,
            sizedBox,
            sizedBox,
            const Text(
              'Thank you for choosing DialectImprove. We hope it serves your needs and respects your privacy.',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
