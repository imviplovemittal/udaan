import 'package:flutter/material.dart';
import 'package:udaan_viplove/utils/utils.dart';
import 'package:udaan_viplove/utils/viewmodel.dart';

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  var viewModel = ViewModel();
  dynamic response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Tasks"),
        backgroundColor: Colors.indigo,
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
                                    Text("Done by: ${details["worker_name"]}",
                                        style: TextStyle(fontSize: 18)),
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
    var response = await viewModel.getAllTasks();
    return response;
  }
}
