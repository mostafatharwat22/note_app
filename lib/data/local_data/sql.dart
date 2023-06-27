import 'package:note_app/model/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlHelper {
  static const String _dbName = "Notes.db";
  static const int _Version = 1;

  static _getdb() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
          "CREATE TABLE Note (id INTEGER PRIMARY KEY, title TEXT NOT NULL, Descirpion TEXT NOT NULL)"
      ),
      version: _Version,
    );
  }
  static Future<int> AddNote(NotsModel note) async {
    final db = await _getdb();
    return await db.insert(
      "Note",
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  static Future<int> UpdeteNote(NotsModel note) async {
    final db = await _getdb();
    return await db.UpdeteNote(
      "Note",
      note.toJson(),
      where: "id ?",
      wherearges: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  static Future<int> DeletNote(NotsModel note) async {
    final db = await _getdb();
    return await db.DeletNote(
      "Note",
      where: "id ?",
      wherearges: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  static Future<List<NotsModel>> getAllNots() async {
    final db = await _getdb();
    final  List<Map<String, dynamic>> map = await db.query("Note");
    return List.generate(
      map.length,
          (index) => NotsModel.fromJson(map[index]),
    );
  }
}
