import 'package:flutter/material.dart';
import 'package:udaan_viplove/model/AssetModel.dart';
import 'package:udaan_viplove/utils/uidata.dart';
import 'package:udaan_viplove/utils/utils.dart';
import 'package:udaan_viplove/utils/viewmodel.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var viewModel = ViewModel();
  AssetModel response;
  final colorArray = [
    Colors.indigoAccent,
    Colors.green,
    Colors.deepOrange,
    Colors.black,
    Colors.teal
  ];

  var assetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Housekeeping: All Assets"),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              })
        ],
      ),
      body: Center(
        child: FutureBuilder<AssetModel>(
          future: apiCall(),
          builder: (BuildContext context, AsyncSnapshot<AssetModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Utils.errorWidget(() {
                  setState(() {});
                });
              } else {
                response = snapshot.data;
                return FabCircularMenu(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: response.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        String name = response.data[index].assetName;
                        return FlatButton(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 80,
                                width: 100,
                                color: colorArray[index % 5],
                                child: Center(
                                  child: Text(
                                    name[0],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 40),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                name,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, UIData.selectTask,
                                arguments: response.data[index].id.toInt());
                          },
                        );
                      },
                    ),
                  ),
                  options: <Widget>[
                    FlatButton(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.add_circle_outline),
                          Text(
                            "Assets",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Alert(
                            context: context,
                            title: "Add Asset",
                            content: TextField(
                              controller: assetController,
                              decoration: InputDecoration(
                                labelText: "Asset Name",
                              ),
                            ),
                            buttons: [
                              DialogButton(
                                onPressed: () async {
                                  if (assetController.text.trim().length == 0) {
                                    Fluttertoast.showToast(
                                        msg: "Asset name can't be empty");
                                  } else {
                                    var response = await viewModel
                                        .addAsset(assetController.text);
                                    Fluttertoast.showToast(
                                        msg: response["data"]);
                                    if (response["status"] == "success")
                                      setState(() {});
                                    assetController.text = "";
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ]).show();
                      },
                    ),
                    FlatButton(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.add_circle_outline),
                          Text(
                            "Tasks",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, UIData.addTask);
                      },
                    ),
                    FlatButton(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.add_circle_outline),
                          Text(
                            "Workers",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, UIData.addWorker);
                      },
                    ),
                    FlatButton(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.add_circle_outline),
                          Text(
                            "Assign Tasks",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, UIData.allocateTask);
                      },
                    ),
                  ],
                  ringColor: Colors.indigoAccent.withAlpha(30),
                  fabOpenIcon: Icon(Icons.add),
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

  Future<AssetModel> apiCall() async {
    var response = await viewModel.getAllAssets();
    return response;
  }
}
