import 'package:todolistsqllite/helper_files/database.dart';

class MainPageModel{

  TasksDatabase _database=TasksDatabase();

  get totalTasks async{
    return await _database.totalTasksLength;
  }

  get remainingTasks async{
    return  (await totalTasks - await _database.completedTasksLength);
  }

  Future<double> get percentageTasksDone async{
    if(await totalTasks==0)
      return 0;
    return ((await totalTasks)-(await remainingTasks)/(await totalTasks));  
  }

  get associatedText async{
    double percentage=await percentageTasksDone;

    if(await totalTasks==0)
      return 'No Tasks added!';
    else if(percentage==0)
      return 'No Task done! Better hop to it';
    else if (percentage<40)
      return "You're making progress!";
    else if (percentage<50)
      return "Almost halfway through!";
    else if (percentage<70)
      return "You've almost got it!";
    else if (percentage<80)
      return "Almost thereeeee!";
    else if (percentage<100)
      return "Just a few moreee!";
    else 
      return "You're all done!";
  }

}