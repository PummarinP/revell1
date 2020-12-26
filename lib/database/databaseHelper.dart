import 'dart:async';
import 'dart:io' as io;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:revell/models/scanner_data.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE scanner_data(id INTEGER PRIMARY KEY AUTOINCREMENT, scanType TEXT, data TEXT, name TEXT, createdDate TEXT)");
  }

  //insertion
  Future<int> saveData(ScannerData scannerData) async {
    var dbClient = await db;
    int res;
    if (scannerData.id == null) {
      res = await dbClient.insert("scanner_data", scannerData.toMap());
    } else {
      res = await dbClient.update('scanner_data', {'name': scannerData.name, 'scanType': scannerData.scanType}, where: 'id = ?', whereArgs: [scannerData.id]);
    }
    return res;
  }


  //insertion
  Future<int> updateData(int id, String name, String scanType) async {
    var dbClient = await db;
    int res = await dbClient.update('scanner_data', {'name': name, 'scanType': scanType}, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<List> getAllData() async {
    List<ScannerData> scannerDatas = List();

    var dbClient = await db;
    List<Map> maps = await dbClient.query("scanner_data",
        columns: ['id', 'scanType', 'data', 'name', 'createdDate'],
        orderBy: "createdDate DESC"
    );
    if (maps.length > 0) {
      maps.forEach((f) {
        scannerDatas.add(ScannerData.map(f));
      });
    }
    return scannerDatas;
  }

  Future<List> getTodayData() async {
    List<ScannerData> scannerDatas = List();

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    var dbClient = await db;
    List<Map> maps = await dbClient.query("scanner_data",
        columns: ['id', 'scanType', 'data', 'name', 'createdDate'],
        where: 'createdDate LIKE ?', whereArgs: [formattedDate+'%'],
        orderBy: "createdDate DESC"
    );
    if (maps.length > 0) {
      maps.forEach((f) {
        scannerDatas.add(ScannerData.map(f));
      });
    }
    return scannerDatas;
  }

  Future<int> deleteData(int id) async {
    var dbClient = await db;
    return await dbClient.delete("scanner_data", where: 'id = ?', whereArgs: [id]);
  }

  deleteDropDatabase() async {
    var dbClient = await db;

    try {
      await dbClient.rawQuery("DROP table scanner_data");
    } catch (e) {
      print('error');
      print(e);
    }
    await dbClient.execute("CREATE TABLE scanner_data(id INTEGER PRIMARY KEY AUTOINCREMENT, scanType TEXT, data TEXT, name TEXT, createdDate TEXT)");
  }

  reInitBd() async {
    var dbClient = await db;
    try {
      await dbClient.execute("CREATE TABLE scanner_data(id INTEGER PRIMARY KEY AUTOINCREMENT, scanType TEXT, data TEXT, name TEXT, createdDate TEXT)");
    } catch (e) {
      print('error');
      print(e);
    }
  }
}