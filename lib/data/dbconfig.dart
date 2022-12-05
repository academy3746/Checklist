import 'package:checklist/data/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "todo.db";
  static const _databaseVersion = 1;
  static const todoTable = "todo";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $todoTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INTEGER DEFAULT 0,
      title String,
      memo String,
      color INTEGER,
      category String
    ) 
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  // Data INSERT + UPDATE + SELECT

  Future<int> insertTodo(Todo todo) async {
    Database db = await instance.database;

    if (todo.id == null) {
      Map<String, dynamic> row = {
        "title": todo.title,
        "date": todo.date,
        "memo": todo.memo,
        "color": todo.color,
        "category": todo.category
      };

      return await db.insert(todoTable, row);
    } else {
      Map<String, dynamic> row = {
        "title": todo.title,
        "date": todo.date,
        "memo": todo.memo,
        "color": todo.color,
        "category": todo.category
      };

      return await db.update(
          todoTable, row, where: "id = ?", whereArgs: [todo.id]);
    }
  }

  Future<List<Todo>> getAllTodo() async {
    Database db = await instance.database;
    List<Todo> todos = [];

    var queries = await db.query(todoTable);

    for (var query in queries) {
      todos.add(
          Todo(
            id: query["id"],
            title: query["title"],
            date: query["date"],
            memo: query["memo"],
            color: query["color"],
            category: query["category"],
          )
      );
    }
    return todos;
  }

  Future<List<Todo>> getTodoByDate(int date) async {
    Database db = await instance.database;
    List<Todo> todos = [];

    var queries = await db.query(todoTable, where: "date = ?", whereArgs: [date]);

    for (var query in queries) {
      todos.add(
          Todo(
            id: query["id"],
            title: query["title"],
            date: query["date"],
            memo: query["memo"],
            color: query["color"],
            category: query["category"],
          )
      );
    }
    return todos;
  }
}