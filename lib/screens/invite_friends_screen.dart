import 'package:flutter/material.dart';
import 'package:gritstone_machine_test/constants/app_relates.dart';
import 'package:gritstone_machine_test/widgets/text_widgets.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/tts_provider.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({Key? key}) : super(key: key);

  final String inviteLink =
      'https://github.com/Muhammed-Aslam-n/dialectImprove_for_gritstone_machine_tes';

  void shareInviteLink(BuildContext context) {
    Share.share('Check out this app! Join using the link: $inviteLink');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invite Friends',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),floatingActionButton: Consumer<TtsProvider>(
        builder: (context,tts,_) {
          if(tts.isSpeaking){
            return FloatingActionButton(
              onPressed: () {
                final tts = Provider.of<TtsProvider>(context, listen: false);
                tts.stopSpeaking();
              },
              child: const Icon(
                Icons.stop,
                color: Colors.white,
              ),
            );
          }
          return FloatingActionButton(
            onPressed: () {
              final tts = Provider.of<TtsProvider>(context, listen: false);
              tts.speak(AppConst.appInvite);
            },
            child: const Icon(
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
          children: [
            const SizedBox(height: 40),
            const Text(AppConst.appName,
                style: TextStyle(
                  fontSize: 25,
                )),
            const SizedBox(height: 60),
            const Text(AppConst.appInvite,
                style: TextStyle(
                  fontSize: 21,color: Colors.black
                ),),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                shareInviteLink(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                fixedSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: const Text('Share Invite Link'),
            ),
          ],
        ),
      ),
    );
  }
}
