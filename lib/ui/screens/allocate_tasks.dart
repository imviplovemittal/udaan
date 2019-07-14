import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udaan_viplove/model/AllDataModel.dart';
import 'package:udaan_viplove/utils/utils.dart';
import 'package:udaan_viplove/utils/viewmodel.dart';

class AllocateTasks extends StatefulWidget {
  @override
  _AllocateTasksState createState() => _AllocateTasksState();
}

class _AllocateTasksState extends State<AllocateTasks> {
  var viewModel = ViewModel();
  AllDataModel response;
  List<DropdownMenuItem<String>> assetNames;
  List<DropdownMenuItem<String>> taskNames;
  List<DropdownMenuItem<String>> workerNames;
  var selectedAsset;
  var selectedTask;
  var selectedWorker;
  var selectedDate = DateTime.now().add(const Duration(days: 1));

  var dNames;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Tasks"),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: FutureBuilder<AllDataModel>(
          future: apiCall(),
          builder:
              (BuildContext context, AsyncSnapshot<AllDataModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Utils.errorWidget(() {
                  setState(() {});
                });
              } else {
                response = snapshot.data;
                var dNames = <String>[];
                for (var i in response.data.assets) {
                  dNames.add(i.name);
                }
                ;
                assetNames = dNames.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList();
                dNames = <String>[];
                for (var i in response.data.tasks) {
                  dNames.add(i.name);
                }
                ;
                taskNames = dNames.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList();
                dNames = <String>[];
                for (var i in response.data.workers) {
                  dNames.add(i.name);
                }
                ;
                workerNames = dNames.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          items: assetNames,
                          onChanged: (String newValueSelected) {
                            setState(() {
                              selectedAsset = newValueSelected;
                            });
                          },
                          value: selectedAsset,
                          hint: Text("Asset"),
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          items: taskNames,
                          onChanged: (String newValueSelected) {
                            setState(() {
                              selectedTask = newValueSelected;
                            });
                          },
                          value: selectedTask,
                          hint: Text("Task"),
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          items: workerNames,
                          onChanged: (String newValueSelected) {
                            setState(() {
                              selectedWorker = newValueSelected;
                            });
                          },
                          value: selectedWorker,
                          hint: Text("Worker"),
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Task Deadline",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              child: Text(
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                _selectDate(context);
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.indigo,
                          onPressed: () {
                            submit();
                          },
                        ),
                      )
                    ],
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

  Future<AllDataModel> apiCall() async {
    var response = await viewModel.getAllDataM();
    return response;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  submit() async {
    var taskId;
    var assetId;
    var workerId;
    for (var i in this.response.data.tasks) {
      if (selectedTask == i.name) {
        taskId = i.id;
        break;
      }
    }
    for (var i in this.response.data.assets) {
      if (selectedAsset == i.name) {
        assetId = i.id;
        break;
      }
    }
    for (var i in this.response.data.workers) {
      if (selectedWorker == i.name) {
        workerId = i.id;
        break;
      }
    }
    if (taskId == null || assetId == null || workerId == null) {
      Fluttertoast.showToast(msg: "Please select all the fields first");
    } else {
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
}
