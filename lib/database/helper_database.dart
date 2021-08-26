import 'package:plan_tasks/classes/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HelperDB {
  static final _dataBaseName = "PlanTasks.db";
  static final _dataBaseVersion = 1;

  static final table = "Tasks";
  static final columnId = "id";
  static final columnTitle = "title";
  static final columnDescription = "description";
  static final columnStatus = "status";

  static final HelperDB _helperBd = HelperDB.internal();
  factory HelperDB() {
    return _helperBd;
  }
  HelperDB.internal();

  var _db;

  Future<Database>? get db async {
    //Apenas inicializa o banco de dados quando não tiver uma instância configurada
    if (_db != null) {
      return _db;
    } else {
      _db = await _recoverDB();
      return _db;
    }
  }

  //Recupera o banco de dados
  Future<Database> _recoverDB() async {
    final pathdb = await getDatabasesPath();
    final localDB = join(pathdb, _dataBaseName);

    return await openDatabase(localDB,
        version: _dataBaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnStatus INTEGER NOT NULL
      )
    ''');
  }

  //Salvar tarefa no banco de dados
  Future<Task?> saveTask(Task task) async {
    try {
      var aux = await db;

      if (aux != null) {
        task.id = await aux.insert(table, task.toMap());
        return task;
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  //Listar tarefas do banco de dados
  Future<List<Task>?> listTasks(bool taskChecked) async {
    try {
      Database? db = await _helperBd.db;
      int status = taskChecked ? 1 : 0;
      String sql = "SELECT * FROM $table WHERE status = $status";
      var tasks = await db?.rawQuery(sql);

      List<Task> tasksList = [];

      if (tasks != null) {
        Map<String, dynamic> map;
        for (map in tasks) {
          tasksList.add(Task.fromMap(map));
        }
      }

      return tasksList;
    } catch (erro) {
      print(erro);
      return null;
    }
  }

  //Excluir tarefa do banco de dados
  Future<int?> removeTask(int id) async {
    try {
      Database? db = await _helperBd.db;
      return await db?.delete(table, where: '$columnId = ?', whereArgs: [id]);
    } catch (erro) {
      print(erro);
      return null;
    }
  }

  //Editar tarefa do banco de dados
  Future<int?> editTask(Task task) async {
    try {
      Database? db = await _helperBd.db;

      return await db?.update(table, task.toMapWithId(),
          where: "$columnId = ?", whereArgs: [task.id]);
    } catch (erro) {
      print(erro);
      return null;
    }
  }

  Future close() async {
    Database? db = await _helperBd.db;
    db?.close();
  }
}
