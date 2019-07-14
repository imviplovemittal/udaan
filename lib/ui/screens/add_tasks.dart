import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udaan_viplove/utils/viewmodel.dart';

class AddTasks extends StatefulWidget {
  @override
  _AddTasksState createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  var _controller = TextEditingController();
  var viewModel = ViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Task Name",
                  hintText: "Eg. Mopping",
                ),
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
      ),
    );
  }

  Future submit() async {
    if (_controller.text.trim().length == 0) {
      Fluttertoast.showToast(msg: "Task name can't be empty");
    } else {
      var response = await viewModel.addTask(_controller.text);
      Fluttertoast.showToast(msg: response["data"]);
      if (response["status"] == "success") {
        Navigator.pop(context);
      }
    }
  }
}
