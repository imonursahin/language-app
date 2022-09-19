import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const String dbName = "database.db";

  static Future<Database> dbInstance() async {
    String dbPath = join(await getDatabasesPath(), dbName);

    if (await databaseExists(dbPath)) {
      print("db is exist");
    } else {
      ByteData data = await rootBundle.load("assets/database/$dbName");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);
    }
    return openDatabase(dbPath);
  }
}
