import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udaan_viplove/utils/viewmodel.dart';

class AddWorkers extends StatefulWidget {
  @override
  _AddWorkersState createState() => _AddWorkersState();
}

class _AddWorkersState extends State<AddWorkers> {
  var _controller = TextEditingController();
  var viewModel = ViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Workers"),
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
                  labelText: "Worker Name",
                  hintText: "Eg: Rajesh",
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
      Fluttertoast.showToast(msg: "Worker name can't be empty");
    } else {
      var response = await viewModel.addWorker(_controller.text);
      Fluttertoast.showToast(msg: response["data"]);
      if (response["status"] == "success") {
        Navigator.pop(context);
      }
    }
  }
}
