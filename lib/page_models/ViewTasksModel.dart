import 'package:flutter/cupertino.dart';
import 'package:todolistsqllite/helper_files/database.dart';
import 'package:todolistsqllite/models/task.dart';

class ViewTasksModel extends ChangeNotifier{

  
  final TasksDatabase _db=TasksDatabase();
  
  int index;
  List<Task> tasks=[];
  get getTasksInListViewFormat async{
    List<Map<String,dynamic>> result=await _db.totalTasks;

    if(result==null)//no tasks added yet
      return null;
    tasks=[];
    for (var task in result) {
      tasks.add(fromJson(task));
    }    
    return tasks;

  }
  Task get selectedTask {
    return tasks[index];
  }
  fromJson(json){
    return Task(id:json['id'],title: json['title'],description: json['description'],completed: json['completed']);  
  }

  switchTaskStatus(int id,int initialStatus) async{
    if(initialStatus==1)
      await _db.updateTaskStatus(id, 0);
    else
      await _db.updateTaskStatus(id, 1);
    await getTasksInListViewFormat;
    notifyListeners();
  }
  updateTask(String title,String description) async{
    await _db.updateTask(title, description, selectedTask.id);
    notifyListeners();
  }
  deleteTask(int id)async{
    await _db.deleteTask(id);
    await getTasksInListViewFormat;
    notifyListeners();
  }


}