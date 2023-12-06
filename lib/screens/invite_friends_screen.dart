import 'package:flutter/material.dart';
import 'package:gritstone_machine_test/constants/app_relates.dart';
import 'package:gritstone_machine_test/widgets/text_widgets.dart';
import 'package:share_plus/share_plus.dart';

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
            const Text('Discover the joy of Helping People! ',
                style: TextStyle(
                  fontSize: 25,
                )),
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
