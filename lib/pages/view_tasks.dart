import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistsqllite/page_models/ViewTasksModel.dart';
import 'package:todolistsqllite/pages/view_task.dart';

class ViewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF444444),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Total Tasks",
          style: TextStyle(color: Color(0xFFff9900)),
        ),
        backgroundColor: Color(0xFF444444),
      ),
      body: Container(
        child: SafeArea(
          child: FutureBuilder(
            future:
                Provider.of<ViewTasksModel>(context).getTasksInListViewFormat,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.length == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.done,
                        size: 100,
                        color: Color(0xFFff9900),
                      ),
                      Text(
                        "No tasks here.\n You're all set",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ],
                  );
                } else
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, val) => Container(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<ViewTasksModel>(context,listen: false).index=val;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewTask(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data[val].title,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 120),
                                  child: Text(
                                    snapshot.data[val].description,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Consumer<ViewTasksModel>(
                                  builder: (_, __, ___) => ElevatedButton(
                                    onPressed: () async {
                                      await Provider.of<ViewTasksModel>(context,
                                              listen: false)
                                          .switchTaskStatus(
                                              snapshot.data[val].id,
                                              snapshot.data[val].completed);
                                    },
                                    child: Text(
                                      snapshot.data[val].completed == 0
                                          ? "Press if completed"
                                          : "Completed!",
                                      style: TextStyle(
                                          color:
                                              snapshot.data[val].completed == 0
                                                  ? Colors.green
                                                  : Colors.white),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              snapshot.data[val].completed == 0
                                                  ? Colors.white
                                                  : Colors.green),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    Provider.of<ViewTasksModel>(context,
                                            listen: false)
                                        .deleteTask(snapshot.data[val].id);
                                  },
                                  child: Text("Delete"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFff9900)),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
