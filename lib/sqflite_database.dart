import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
class DatabaseHelper {

  static final _databaseName = "quiz_app";
  static final _databaseVersion = 1;

  static final table = 'my_table';

  static final columnId = '_id';
  static final columnQuestion = 'Question';
  static final columnA = 'A';
  static final columnB = 'B';
  static final columnC = 'C';
  static final columnD = 'D';
  static final columnAns = 'Answer';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnQuestion TEXT NOT NULL,
            $columnA TEXT NOT NULL,
            $columnB TEXT NOT NULL,
            $columnC TEXT NOT NULL,
            $columnD TEXT NOT NULL,
            $columnAns TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db=await instance.database;
    return await db.insert(table, row);
  }
  Future<List<Map<String, dynamic>>> queryall() async {
    Database db=await instance.database;
    return await db.query(table);
  }
  Future<List<Map<String, dynamic>>> queryspecific(int id) async {
    Database db=await instance.database;
    var data=await db.query(table, where: "_id = ?", whereArgs: [id]);
    return data;
  }
  Future<int> deletdata(int id) async {
    Database db=await instance.database;
    var res=await db.delete(table, where: "_id = ?", whereArgs: [id]);
    return res;
  }
  Future<int> updatedata(int id) async {
    Database db=await instance.database;
    var res=await db.update(table, {"name" : "halo how are you", "age" : 100}, where: "_id = ?", whereArgs: [id]);
    return res;
  }
}