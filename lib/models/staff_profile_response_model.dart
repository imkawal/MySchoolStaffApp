// To parse this JSON data, do
//
//     final staffProfileResModel = staffProfileResModelFromJson(jsonString);

import 'dart:convert';

StaffProfileResModel staffProfileResModelFromJson(String str) => StaffProfileResModel.fromJson(json.decode(str));

String staffProfileResModelToJson(StaffProfileResModel data) => json.encode(data.toJson());

class StaffProfileResModel {
  StaffProfileResModel({
    this.message,
    this.result,
    this.data,
  });

  String? message;
  String? result;
  List<StaffProfileData>? data;

  factory StaffProfileResModel.fromJson(Map<String, dynamic> json) => StaffProfileResModel(
    message: json["message"],
    result: json["result"],
    data: List<StaffProfileData>.from(json["data"].map((x) => StaffProfileData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StaffProfileData {
  StaffProfileData({
    this.name,
    this.fatherName,
    this.spouseName,
    this.staffType,
    this.gender,
    this.phoneNumber,
    this.photo,
    this.staffPosition,
  });

  String? name;
  String? fatherName;
  String? spouseName;
  String? staffType;
  String? gender;
  String? phoneNumber;
  String? photo;
  dynamic staffPosition;

  factory StaffProfileData.fromJson(Map<String, dynamic> json) => StaffProfileData(
    name: json["Name"],
    fatherName: json["FatherName"],
    spouseName: json["SpouseName"],
    staffType: json["StaffType"],
    gender: json["Gender"],
    phoneNumber: json["PhoneNumber"],
    photo: json["Photo"],
    staffPosition: json["StaffPosition"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "FatherName": fatherName,
    "SpouseName": spouseName,
    "StaffType": staffType,
    "Gender": gender,
    "PhoneNumber": phoneNumber,
    "Photo": photo,
    "StaffPosition": staffPosition,
  };
}
