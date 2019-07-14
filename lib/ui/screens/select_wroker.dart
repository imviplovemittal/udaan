import 'package:flutter/material.dart';
import 'package:udaan_viplove/utils/uidata.dart';
import 'package:udaan_viplove/utils/utils.dart';
import 'package:udaan_viplove/utils/viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectWorker extends StatefulWidget {
  @override
  _SelectWorkerState createState() => _SelectWorkerState();
}

class _SelectWorkerState extends State<SelectWorker> {
  var viewModel = ViewModel();
  dynamic response;
  int assetId;
  int taskId;
  DateTime selectedDate = DateTime.now();

  final colorArray = [
    Colors.indigoAccent,
    Colors.green,
    Colors.deepOrange,
    Colors.black,
    Colors.teal
  ];

  Future<Null> _selectDate(BuildContext context, int workerId) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      var response =
          await viewModel.allocateTask(taskId, assetId, workerId, selectedDate);
      if (response["status"] == "success") {
        Fluttertoast.showToast(msg: response["data"]);
        Navigator.popUntil(
            context, ModalRoute.withName(Navigator.defaultRouteName));
      } else {
        Fluttertoast.showToast(msg: response["data"]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, int> args = ModalRoute.of(context).settings.arguments;
    assetId = args["asset_id"];
    taskId = args["task_id"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Workers"),
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
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 50),
                  child: ListView.builder(
                    itemCount: response["data"]["workers"].length,
                    itemBuilder: (context, index) {
                      String name =
                          response["data"]["workers"][index]["name"].toString();
                      return ListTile(
                        title: Text(name),
                        leading: Container(
                          height: 40,
                          width: 40,
                          color: colorArray[index % 5],
                          child: Center(
                            child: Text(
                              response["data"]["workers"][index]["id"]
                                  .toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () {
                          _selectDate(context,
                              response["data"]["workers"][index]["id"].toInt());
                        },
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
      bottomSheet: Container(
        color: Colors.black,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "You also need to select the Task Deadline",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, UIData.addWorker);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> apiCall() async {
    var response = await viewModel.getAllData();
    return response;
  }
}
