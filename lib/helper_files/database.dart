import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolistsqllite/models/task.dart';

class TasksDatabase extends ChangeNotifier{

  TasksDatabase._();

  static final TasksDatabase _tasksDatabase=TasksDatabase._();


  static Database _database;

  factory TasksDatabase(){
    return _tasksDatabase;
  }

  get database async{
    if(_database!=null)
      return _database;
    else
      await initDB();
    return _database;
  }
  initDB()async{
    _database=await openDatabase(
      join(await getDatabasesPath(),'tasks.db'),
      version: 1,
      onCreate: (db,version)async{
        await  db.execute(
        '''
          CREATE TABLE tasks(
          id INTEGER PRIMARY KEY,
          title TEXT, 
          description TEXT,
          completed INTEGER
          )
        
        ''');
      }
    );
  }
  Future<List<Map<String,dynamic>>> get completedTasks async{
    final Database db=await database;

    List<Map<String,dynamic>> result=await db.rawQuery(
    '''
      SELECT * FROM tasks WHERE completed=1
    '''
    );
    
    return result;
  }
  get completedTasksLength async{
    var res=await completedTasks;
    return res.length;
  }

  Future<List<Map<String,dynamic>>> get totalTasks async{
    final Database db=await database;

    List<Map<String,dynamic>> result=await db.rawQuery('''
      SELECT * FROM tasks
    ''');
    return result;
  }
  get totalTasksLength async{
    var res=await totalTasks;
    return res.length;
  }
  addTask(Task task) async{
    final Database db=await database;
    await db.insert('tasks', task.toJson());
    notifyListeners();
  }

  updateTaskStatus(int id,int completed) async{
    final Database db=await database;
    await db.rawQuery('''
      UPDATE tasks
      SET completed=?
      WHERE id=?
    ''',[completed,id]);
    notifyListeners();
  }
  updateTask(String title,String description,int id) async{
    print(id);
    final Database db=await database;
    int x=await db.rawUpdate('''
    UPDATE tasks
    SET title=?,
    description=?
    WHERE id=?
    ''',[title,description,id]);
    print('changes made are $x');
    notifyListeners();
  }
  deleteTask(int id) async{
    final Database db=await database;
    await db.rawQuery('''
      DELETE FROM tasks
      WHERE id=?
    ''',[id]);
    notifyListeners();
  }
}