import 'dart:io';
import 'package:myparrot/models/recipient_mod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "parrot.db";
  static const _databaseVersion = 1;

  static const recipientTable = 'recipient';
  static const columnId = 'recipient_id';
  static const columnName = 'recipient_name';
  static const columnNumber = 'recipient_number';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $recipientTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnNumber TEXT NOT NULL
          )
          ''');

    //for device info
    await db.execute('''
          CREATE TABLE $deviceInfoTable (
            $deviceNo INTEGER PRIMARY KEY AUTOINCREMENT,
            $serialNumber TEXT NOT NULL
          )
          ''');
  }

  Future<int> insertRecipient(RecipientModel recipient) async {
    Database db = await instance.database;
    return await db.insert(recipientTable, recipient.toMap());
  }

  Future<int> updateRecipient(RecipientModel recipient) async {
    Database db = await instance.database;
    int id = recipient.id!;
    return await db.update(recipientTable, recipient.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteRecipient(int id) async {
    Database db = await instance.database;
    return await db
        .delete(recipientTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<RecipientModel>> getRecipients() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(recipientTable);
    return List.generate(maps.length, (i) {
      return RecipientModel(
        id: maps[i][columnId],
        name: maps[i][columnName],
        number: maps[i][columnNumber],
      );
    });
  }

  //for device info
  static const deviceInfoTable = 'device_info_table';
  static const serialNumber = 'serial_number';
  static const deviceNo = 'device_no';

  Future<int> insertSerialNumber(String serial) async {
    Database db = await instance.database;
    return await db.insert(deviceInfoTable, {serialNumber: serial});
  }

  Future<String> fetchSerialNumber() async {
    Database db = await instance.database;
    final value = await db.query(deviceInfoTable, where: '$deviceNo = 1');
    return value[0][serialNumber].toString();
  }
}
