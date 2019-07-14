import 'package:flutter/material.dart';
import 'package:udaan_viplove/utils/uidata.dart';
import 'package:udaan_viplove/utils/utils.dart';
import 'package:udaan_viplove/utils/viewmodel.dart';

class SelectTask extends StatefulWidget {
  @override
  _SelectTaskState createState() => _SelectTaskState();
}

class _SelectTaskState extends State<SelectTask> {
  var viewModel = ViewModel();
  dynamic response;
  int assetId;

  @override
  Widget build(BuildContext context) {
    assetId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Tasks"),
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
                    itemCount: response["data"]["tasks"].length,
                    itemBuilder: (context, index) {
                      String name =
                          response["data"]["tasks"][index]["name"].toString();
                      return ListTile(
                        title: Text(name),
                        leading: Icon(Icons.work),
                        onTap: () {
                          Map<String, int> body = {
                            "asset_id": assetId,
                            "task_id":
                                response["data"]["tasks"][index]["id"].toInt()
                          };
                          Navigator.pushNamed(context, UIData.selectWorker,
                              arguments: body);
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
    );
  }

  Future<dynamic> apiCall() async {
    var response = await viewModel.getAllData();
    return response;
  }
}
