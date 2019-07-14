import 'package:flutter/material.dart';
import 'package:udaan_viplove/ui/screens/allocate_tasks.dart';
import 'package:udaan_viplove/ui/screens/home.dart';
import 'package:udaan_viplove/ui/screens/select_task.dart';
import 'package:udaan_viplove/ui/screens/select_wroker.dart';

import 'utils/uidata.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Udaan',
      routes: <String, WidgetBuilder>{
        UIData.home: (BuildContext context) => HomePage(),
        UIData.selectTask: (BuildContext context) => SelectTask(),
        UIData.selectWorker: (BuildContext context) => SelectWorker(),
        UIData.allocateTask: (BuildContext context) => AllocateTasks(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}