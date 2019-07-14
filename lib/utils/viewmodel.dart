import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:udaan_viplove/model/AllDataModel.dart';
import 'package:udaan_viplove/model/AssetModel.dart';

class ViewModel {
  final baseurl = "http://34.93.40.103/";

  Future<AssetModel> getAllAssets() async {
    final url = baseurl + "assets/all";
    var response = await http.get(url);
    var data = AssetModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<dynamic> getAllData() async {
    final url = baseurl + "get-data";
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }

  Future<AllDataModel> getAllDataM() async {
    final url = baseurl + "get-data";
    var response = await http.get(url);
    var data = AllDataModel.fromJson(jsonDecode(response.body));
    return data;
  }

  Future<dynamic> allocateTask(
      int taskId, int assetId, int workerId, DateTime performTime) async {
    final url = baseurl + "allocate-task";
    Map body = {
      "taskId": taskId,
      "assetId": assetId,
      "workerId": workerId,
      "timeOfAllocation": DateTime.now().millisecondsSinceEpoch.toString(),
      "taskToBePerformedBy": performTime.millisecondsSinceEpoch.toString()
    };
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    var convertDataToJson = jsonDecode(reply);
    return convertDataToJson;
  }

  Future<dynamic> addAsset(String name) async {
    final url = baseurl + "add-asset";
    var response = await http.post(url, body: {"name": name});
    var data = jsonDecode(response.body);
    return data;
  }

  Future<dynamic> addTask(String name) async {
    final url = baseurl + "add-task";
    var response = await http.post(url, body: {"name": name});
    var data = jsonDecode(response.body);
    return data;
  }

  Future<dynamic> addWorker(String name) async {
    final url = baseurl + "add-worker";
    var response = await http.post(url, body: {"name": name});
    var data = jsonDecode(response.body);
    return data;
  }

  Future<dynamic> getWorkerTasks(int workerId) async {
    final url = baseurl + "get-tasks-for-worker/" + workerId.toString();
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }
}
