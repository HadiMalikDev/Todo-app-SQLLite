import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistsqllite/helper_files/database.dart';
import 'package:todolistsqllite/page_models/ViewTasksModel.dart';
import 'package:todolistsqllite/pages/main_page.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TasksDatabase(),
          ),
          ChangeNotifierProvider(
            create: (context) => ViewTasksModel(),
          ),
        ],
        child: MaterialApp(
          home: MainPage(),
        ),
      ),
    );
