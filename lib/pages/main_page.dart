import 'package:flutter/material.dart';
import 'package:todolistsqllite/page_models/MainPageModel.dart';
import 'package:todolistsqllite/pages/add_task_page.dart';
import 'package:todolistsqllite/pages/view_tasks.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final MainPageModel model = MainPageModel();
    return Scaffold(
      backgroundColor: Color(0xFF444444),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Todo App",
          style: TextStyle(color: Color(0xFFff9900)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF444444),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Tasks",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  FutureBuilder(
                    future: model.totalTasks,
                    builder: (context, data) {
                      if (data.connectionState == ConnectionState.done) {
                        return Text(
                          "${data.data}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        );
                      } else
                        return CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFff9900)),
                        );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Remaining Tasks",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  FutureBuilder(
                    future: model.remainingTasks,
                    builder: (context, data) {
                      if (data.connectionState == ConnectionState.done) {
                        return Text(
                          "${data.data}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        );
                      } else
                        return CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFff9900)),
                        );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: model.associatedText,
                builder: (context,data){
                  if(data.connectionState==ConnectionState.done)
                    return Text(data.data,style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),);
                  else return Center(child: CircularProgressIndicator());
                }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: model.percentageTasksDone,
                    builder: (context, data) {
                      if (data.connectionState == ConnectionState.done) {
                        return LinearProgressIndicator(
                          value: data.data,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFff9900)),
                          backgroundColor: Colors.black,
                        );
                      } else
                        return CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFff9900)),
                        );
                    }),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
              ),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTask()));
                  setState(() {});
                },
                child: Text("Add Task"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFff9900)),
                  minimumSize: MaterialStateProperty.all(Size(100, 50)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: ()async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewTasks()));
                  setState(() {
                    
                  });
                },
                child: Text("View Tasks"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFff9900)),
                  minimumSize: MaterialStateProperty.all(Size(100, 50)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
