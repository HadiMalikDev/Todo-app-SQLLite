import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistsqllite/helper_files/database.dart';
import 'package:todolistsqllite/models/task.dart';
import 'package:todolistsqllite/page_models/ViewTasksModel.dart';

class ViewTask extends StatelessWidget {
  
  static GlobalKey<FormState> fkey=GlobalKey<FormState>();
    
  void dispose() { 
    fkey=null;
  }
  @override
  Widget build(BuildContext context) {
    
    String title=Provider.of<ViewTasksModel>(context,listen: false).selectedTask.title;
    String description=Provider.of<ViewTasksModel>(context,listen: false).selectedTask.description;
    return Scaffold(
      backgroundColor: Color(0xFF444444),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Form(
            key: fkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 TextFormField(
                   initialValue: title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFff9900),width: 1)
                    ),
                    labelText: 'Enter title',
                    labelStyle: TextStyle(
                      color: Color(0xFFff9900),
                    ),
                  ),
                  cursorColor: Color(0xFFff9900),
                  maxLines: 2,
                  validator: (String str){
                    title=str;
                    return title==null?'Please enter a title':null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFff9900),width: 1)
                    ),
                    labelText: 'Enter description',
                    labelStyle: TextStyle(
                      color: Color(0xFFff9900),
                    ),
                  ),
                  cursorColor: Color(0xFFff9900),
                  maxLines: 10,
                  validator: (String str){
                    description=str;
                    return description==null?'Please enter a description':null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async{
                    if(fkey.currentState.validate())
                    {
                      await Provider.of<ViewTasksModel>(context,listen: false).updateTask(
                        title,description
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Press to modify Task"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFff9900)),
                    minimumSize: MaterialStateProperty.all(Size(100, 50)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}