import 'package:flutter/material.dart';
import 'package:udaan_viplove/utils/uidata.dart';
import 'package:udaan_viplove/utils/utils.dart';
import 'package:udaan_viplove/utils/viewmodel.dart';

class WorkerTasks extends StatefulWidget {
  @override
  _WorkerTasksState createState() => _WorkerTasksState();
}

class _WorkerTasksState extends State<WorkerTasks> {
  var viewModel = ViewModel();
  dynamic response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Tasks : ID 1"),
        backgroundColor: Colors.indigo,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              curve: ElasticOutCurve(),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.indigo,
                    Colors.indigoAccent,
                    Colors.indigo[400]
                  ])),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.deepOrangeAccent,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Worker Id: 1",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Your Tasks",
                style: TextStyle(fontSize: 16),
              ),
              selected: true,
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                "Log Out",
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pushReplacementNamed(context, UIData.loginRoute);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder<dynamic>(
          future: apiCall(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Utils.errorWidget(() {
                  setState(() {});
                });
              } else {
                response = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: response["data"].length,
                    itemBuilder: (context, index) {
                      var details = response["data"][index];
                      var deadline = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(details["performed_time"]));
                      var assigned = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(details["allocated_time"]));
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.work),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      details["task_name"],
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Text(details["asset_name"],
                                        style: TextStyle(fontSize: 20)),
                                    Row(
                                      children: <Widget>[
                                        Text("Deadline: ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.indigo)),
                                        Text(
                                          "${deadline.day}/${deadline.month}/${deadline.year}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                  "Allocated:\n${assigned.day}/${assigned.month}/${assigned.year}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> apiCall() async {
    var response = await viewModel.getWorkerTasks(1);
    return response;
  }
}
