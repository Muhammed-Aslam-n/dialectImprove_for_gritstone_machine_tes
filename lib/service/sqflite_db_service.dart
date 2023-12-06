import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:gritstone_machine_test/models/notes_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// class DBHelperClass{
//   static final DBHelperClass _instance = DBHelperClass._internal();
//
//   factory DBHelperClass() => _instance;
//
//   DBHelperClass._internal();
// }

class SqfliteNotesTable {
  static final SqfliteNotesTable _instance = SqfliteNotesTable._internal();

  factory SqfliteNotesTable() => _instance;

  SqfliteNotesTable._internal();

  static Database? _database;

  static const String dbName = 'improve_dialect_db_1';
  static const String noteTableName = 'note_table_3';

  // define columns

  final columnId = 'id';
  final columnNote = 'note';
  final columnDatTime = 'dateTime';
  final columnLocale = 'locale';

  // Open the database

  Future<void> openDB() async {
    if (_database != null) return;
    _database = await openDatabase(join(await getDatabasesPath(), dbName));
  }

  Future<void> createNoteTable() async {
    debugPrint('calledCreateTable');
    await openDB();
    await _database!.execute('''  
          CREATE TABLE IF NOT EXISTS $noteTableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnNote TEXT,
            $columnDatTime TEXT,
            $columnLocale TEXT
          )
        ''');
  }

  // Insert a record into the table
  Future<int?> insert(NoteModel note) async {
    try {
      if (await doesNoteTableExist()) {
        final newUserId = await _database!.insert(noteTableName, note.toJson());
        return newUserId;
      } else {
        await createNoteTable();
        final newUserId = await _database!.insert(noteTableName, note.toJson());
        return newUserId;
      }
    } catch (exc, stack) {
      log('ExceptionCaughtWhile InsertingToPatientDB $exc \n $stack');
      return null;
    }
  }

  // Get a record by ID
  Future<NoteModel?> getNoteById(
    String? phoneNumber,
  ) async {
    try {
      await openDB();
      if (await doesNoteTableExist()) {
        List<Map<String, dynamic>> maps = await _database!.query(
          noteTableName,
          columns: ['*'], // Include all desired columns
          where: '$columnId = ?',
          whereArgs: [columnId],
        );

        if (maps.isNotEmpty) {
          return NoteModel(
            id: maps.first[columnId],
            note: maps.first[columnNote],
            dateTime: maps.first[columnDatTime],
            locale: maps.first[columnLocale],
          );
        } else {
          return null;
        }
      }

      return null;
    } catch (exc, stack) {
      log('ExceptionCaughtWhile getNoteById  $exc \n $stack');
      return null;
    }
  }

  Future<List<NoteModel>> getAllSavedNotes() async {
    try {
      debugPrint('getNotCalled');
      await openDB();

      debugPrint('getNotCalled 2');
      if (await doesNoteTableExist()) {
        List<Map<String, dynamic>> maps = await _database!.query(
          noteTableName,
          columns: ['*'],
        );

        debugPrint('getNotCalled 3 ');

        List<NoteModel> savedNotes = [];
        for (var map in maps) {
          savedNotes.add(NoteModel.fromJson(map));
        }

        return savedNotes;
      }
      return [];
    } catch (exc, stack) {
      log('ExceptionCaughtWhile getAllSavedNotes  $exc \n $stack');
      return [];
    }
  }

  Future<bool?> doesNoteAlreadyExists({required String note}) async {
    try {
      await openDB();
      List<Map<String, dynamic>> maps = await _database!.query(
        noteTableName,
        columns: ['*'], // Include all desired columns
        where: '$columnNote = ?',
        whereArgs: [note],
      );
      // debugPrint('MatchedAlreadyExistingUser ${jsonEncode(maps)}');
      if (maps.isNotEmpty) {
        return true;
      }
      return false;
    } catch (exc, stack) {
      log('ExceptionCaughtWhile doesNoteAlreadyExists $exc \n $stack');
      return false;
    }
  }

  // Update a record
  Future<int> updateNote(NoteModel newNote, {whereArgs}) async {
    try {
      await openDB();
      if (await doesNoteTableExist()) {
        return await _database!.update(
          noteTableName,
          newNote.toJson(),
          where: '$columnId = ?',
          whereArgs: [whereArgs ?? newNote.id],
        );
      }
      return -1;
    } catch (exc, stack) {
      log('ExceptionCaughtWhile updatingNote  $exc \n $stack');
      return -1;
    }
  }

  // Delete a record
  Future<int> deleteNoteById(int id, {whereColumn, whereArgs}) async {
    try {
      await openDB();
      if (await doesNoteTableExist()) {
        return await _database!.delete(
          noteTableName,
          where: '${whereColumn ?? columnId} = ?',
          whereArgs: [whereArgs ?? id],
        );
      }
      return -1;
    } catch (exc, stack) {
      log('ExceptionCaughtWhile  $exc \n $stack');
      return -1;
    }
  }

  Future<bool> doesNoteTableExist() async {
    try {
      await openDB();
      const query =
          "SELECT name FROM sqlite_master WHERE type='table' AND name='$noteTableName'";
      List<Map<String, dynamic>> result = await _database!.rawQuery(query);
      return result.isNotEmpty;
    } catch (exc, stack) {
      log('ExceptionCaughtWhile doesNoteTableExist $exc \n $stack');
      return false;
    }
  }

  Future<int> deleteAllNotes() async {
    try {
      await openDB(); // Open the database
      if (await doesNoteTableExist()) {
        return await _database!.delete(noteTableName);
      }
      return -1;
    } catch (exc, stack) {
      log('ExceptionCaughtWhile deleteAllNotes $exc  \n $stack');
      return -1;
    }

    // Close the database
  }

  // Close the database
  Future<void> closeAppDB() async {
    try {
      if (_database != null) {
        await _database!.close();
      }
    } catch (exc, stack) {
      log('ExceptionCaughtWhile closeAppDB $exc \n $stack');
      return;
    }
  }
}
