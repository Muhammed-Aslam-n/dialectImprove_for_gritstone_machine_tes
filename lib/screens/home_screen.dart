import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gritstone_machine_test/constants/theme.dart';
import 'package:gritstone_machine_test/models/notes_model.dart';
import 'package:gritstone_machine_test/providers/connectivity_provider.dart';
import 'package:gritstone_machine_test/providers/stt_provider.dart';
import 'package:gritstone_machine_test/providers/theme_provider/theme_provider.dart';
import 'package:gritstone_machine_test/providers/tts_provider.dart';
import 'package:gritstone_machine_test/screens/stt.dart';
import 'package:provider/provider.dart';

import '../widgets/home_widgets.dart';

// class HomeScreenHolder extends StatelessWidget {
//   const HomeScreenHolder({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Consumer<ConnectivityProvider>(builder: (builder,provider,_){
//       final isSynced = await provider.isConnected;
//       if(provider.isConnected){
//
//       }
//       return const SizedBox.shrink();
//     });
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TtsProvider ttsProvider = TtsProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ttsProvider = Provider.of<TtsProvider>(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          onDrawerChanged: (k) {
            if (k == true) {
              ttsProvider.speak('drawer opened');
            } else {
              ttsProvider.speak('drawer closed');
            }
          },
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Home',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          drawer: const DrawerWidget(),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<TtsProvider>(
                    builder: (context, ttsProvider, _) {
                      if (ttsProvider.noteList.isEmpty) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 250,
                            ),
                            Center(
                              child: Text(
                                'Create your first Note',
                                style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        );
                      }
                      return ListView.builder(
                        itemCount: ttsProvider.noteList.length,
                        itemBuilder: (context, index) {
                          return noteWidget(
                            index: index,
                            id: ttsProvider.noteList[index]?.id,
                            dateTime: ttsProvider.noteList[index]?.dateTime,
                            note: ttsProvider.noteList[index]?.note,
                            onRemoveClicked: () {
                              ttsProvider.removeCurrentNote(
                                  id: ttsProvider.noteList[index]?.id ?? 0);
                            },
                            onPlayClicked: () {
                              ttsProvider.speak(
                                ttsProvider.noteList[index]?.note ??
                                    'Note could not found',
                              );
                            },
                            isPlaying: ttsProvider.isSpeaking,
                            onEditClicked: () {
                              showNewTextPopup(
                                  isUpdate: true,
                                  node: ttsProvider.noteList[index]);
                            },
                            onStopClicked: (){
                              ttsProvider.stopSpeaking();
                            }
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 70.0,
                width: 70.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    onPressed: () async {
                      debugPrint('speechToTextCalled');
                      final available =
                          await SpeechToUserTextProvider().initSpeech();
                      if (available) {
                        SpeechToUserTextProvider().startListening();
                        await showSpeechPopup();
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (builder)=>SpeechSampleApp()));
                    },
                    child: Image.asset(
                      'assets/icons/speech_to_text1.png',
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                height: 70.0,
                width: 70.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    onPressed: () {
                      showNewTextPopup();
                    },
                    child: Image.asset(
                      'assets/icons/text_to_speech.png',
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSpeechPopup() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
              child: Container(
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Text(
                      'Listening',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/gifs/listening_gif.gif',
                        height: MediaQuery.of(context).size.width * 0.3,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ),
                    Consumer<SpeechToUserTextProvider>(
                      builder: (builder, speech, _) {
                        if (speech.text.isNotEmpty) {
                          return Text(speech.text);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    TextButton(
                      onPressed: () async {
                        final stop = SpeechToUserTextProvider().stopListening();
                        if (await stop) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Stop Listening'),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  TextEditingController textEditingController = TextEditingController();
  final _key = GlobalKey<FormState>();

  showNewTextPopup({isUpdate = false, NoteModel? node}) {
    showDialog(
      context: context,
      builder: (context) {
        if (isUpdate) {
          debugPrint('isUpdate $isUpdate ${jsonEncode(node)}');
          textEditingController.text = node!.note ?? '';
        }
        return Dialog(
          child: Container(
            height: 250,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'New Note',
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: textEditingController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      // Adjusts the internal padding
                      border: OutlineInputBorder(),
                      hintText: isUpdate?null:'Enter your note',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 3,
                    onChanged: (typed) {
                      ttsProvider.speak(typed.split('').last);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              ttsProvider.speak(textEditingController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.75, 20,),backgroundColor: Colors.white
                            ),
                            child: Text(
                              'Try out',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final NoteModel note = NoteModel(
                                id: isUpdate ? node?.id : null,
                                note: textEditingController.text,
                                dateTime: isUpdate
                                    ? node?.dateTime
                                    : DateTime.now().toString(),
                                locale: isUpdate
                                    ? node?.locale ?? "en-US"
                                    : "en-US",
                              );
                              if (isUpdate) {
                                final updateRes = await ttsProvider
                                    .updateSelectedNote(newNote: note);
                                if (updateRes == true) {
                                  debugPrint('hrerer---');
                                  textEditingController.clear();
                                  Navigator.pop(context);
                                }
                              } else {
                                final saveRes =
                                    await ttsProvider.saveNote(note);
                                if (saveRes == true) {
                                  textEditingController.clear();
                                  Navigator.pop(context);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.5,
                                20,
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              isUpdate ? 'Update' : 'Save',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    textEditingController.clear();
  }

  Widget noteWidget({
    index,
    note,
    id,
    dateTime,
    onRemoveClicked,
    onEditClicked,
    onPlayClicked,isPlaying,required onStopClicked
  }) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 0.3),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(note ?? 'Note could not found')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isPlaying?IconButton(
                  onPressed: onStopClicked,
                  icon: const Icon(
                    CupertinoIcons.stop,
                    color: Colors.blue,
                  ),
                ):IconButton(
                  onPressed: onPlayClicked,
                  icon: const Icon(
                    CupertinoIcons.play_arrow_solid,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: onEditClicked,
                  icon: const Icon(
                    CupertinoIcons.pencil,
                    size: 18,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: onRemoveClicked,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}