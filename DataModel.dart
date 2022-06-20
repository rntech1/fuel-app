// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';
// this is the model. it's where i declared the variables tsa APi hahaha, ha ke sure haeba ke hlakile
DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.action,
    required this.userCell,
    required this.firebaseId,
    required this.deviceId,
    required this.password,
  });

  String action;
  String userCell;
  int firebaseId;
  int deviceId;
  int password;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    action: json["action"],
    userCell: json["userCell"],
    firebaseId: json["firebaseId"],
    deviceId: json["deviceID"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "action": action,
    "userCell": userCell,
    "firebaseId": firebaseId,
    "deviceID": deviceId,
    "password": password,
  };
}
