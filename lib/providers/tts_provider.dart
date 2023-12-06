import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gritstone_machine_test/models/notes_model.dart';

import '../service/sqflite_db_service.dart';

class TtsProvider extends ChangeNotifier {
  static final TtsProvider _instance = TtsProvider._internal();

  factory TtsProvider() => _instance;

  TtsProvider._internal() {
    fetchSavedNotes();
  }

  // Create a FlutterTts instance
  final FlutterTts _flutterTts = FlutterTts();
  final SqfliteNotesTable _notesTable =
      SqfliteNotesTable(); // Your table configuration instance

  bool isSpeaking = false;

  // A method to speak the given text
  Future<void> speak(String text) async {
    // Stop any previous speech
    await _flutterTts.stop();
    // Speak the text

    if (text.isEmpty) {
      await _flutterTts.speak(emptyTextAlert);
      isSpeaking = true;
      _flutterTts.setCompletionHandler(() {
isSpeaking = false;
      });
    } else {
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setPitch(1.0);
      await _flutterTts.speak(text);
      isSpeaking = true;
      _flutterTts.setCompletionHandler(() {
isSpeaking = false;
      });
    }
    // Notify the listeners
    notifyListeners();
  }

  stopSpeaking()async{
    await _flutterTts.stop();
    isSpeaking = false;
    notifyListeners();
  }

  List<NoteModel?> _noteList = [];

  List<NoteModel?> get noteList => _noteList;

  Future<List<NoteModel?>> fetchSavedNotes() async {
    debugPrint('fetchAllNotesCalled');
    try {
      _noteList.clear();
      _noteList = await _notesTable.getAllSavedNotes();
      notifyListeners();
      return noteList;
    } catch (exc, stack) {
      log('exceptionCaughtAt fetchSavedNotes $exc \n $stack');
      return [];
    }
  }

  Future<bool> saveNote(NoteModel? note) async {
    if (note == null) {
      speak(emptyTextAlert);
      return Future.value(false);
    } else {
      try {
        final saveRes = await _notesTable.insert(note);
        if (saveRes != null && saveRes > 0) {
          await fetchSavedNotes();
          speak('Your Note stored successfully');
        } else {
          speak(someErrorOccurred);
        }
        notifyListeners();
        return Future.value(true);
      } catch (exc, stack) {
        log('exceptionCaughtAt SaveNote $exc \n $stack');
        return Future.value(false);
      }
    }
  }

  fetchSpecificNote({int? id}) {
    try {
      notifyListeners();
    } catch (exc, stack) {
      log('exceptionCaughtAt $exc \n $stack');
      return Future.value(false);
    }
  }

  Future<bool> removeCurrentNote({required int id}) async {
    try {
      final removeRes = await _notesTable.deleteNoteById(id);
      if (removeRes > 0) {
        await fetchSavedNotes();
        speak(noteRemoved);
        notifyListeners();

        return true;
      } else {
        speak(someErrorOccurred);
        return true;
      }
    } catch (exc, stack) {
      log('exceptionCaughtAt removeCurrentNote $exc \n $stack');
      return Future.value(false);
    }
  }

  Future<bool> updateSelectedNote({required NoteModel newNote}) async {
    try {
      final updateRes = await _notesTable.updateNote(newNote);
      if (updateRes > 0) {
        await fetchSavedNotes();
        speak(noteUpdated);
        return true;
      } else {
        speak(someErrorOccurred);
        notifyListeners();
        return true;
      }
    } catch (exc, stack) {
      log('exceptionCaughtAt $exc \n $stack');
      return Future.value(false);
    }
  }

  Future<bool> deleteAllNotes() async {
    try {
      final deleteAllRes = await _notesTable.deleteAllNotes();
      if (deleteAllRes > 0) {
        await fetchSavedNotes();
        speak(allNoteDeleted);
        notifyListeners();
        return true;
      } else {
        speak(someErrorOccurred);
        return true;
      }
    } catch (exc, stack) {
      log('exceptionCaughtAt $exc \n $stack');
      return Future.value(false);
    }
  }

  final emptyTextAlert = 'Please enter your note and try again';
  final noteRemoved = 'Note removed successfully';
  final noteUpdated = 'Note updated successfully';
  final allNoteDeleted = 'All notes deleted successfully';

  final someErrorOccurred = 'Sorry,Some error occurred while performing this';
}
