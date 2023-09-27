// To parse this JSON data, do
//
//     final classTestResultResModel = classTestResultResModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

ClassTestResultResModel classTestResultResModelFromJson(String str) => ClassTestResultResModel.fromJson(json.decode(str));

String classTestResultResModelToJson(ClassTestResultResModel data) => json.encode(data.toJson());

class ClassTestResultResModel {
  ClassTestResultResModel({
    this.message,
    this.result,
    this.studentCount,
    this.data,
  });

  String? message;
  String? result;
  int? studentCount;
  List<ClassTestResultData>? data;

  factory ClassTestResultResModel.fromJson(Map<String, dynamic> json) => ClassTestResultResModel(
    message: json["message"],
    result: json["result"],
    studentCount: json["StudentCount"],
    data: List<ClassTestResultData>.from(json["data"].map((x) => ClassTestResultData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "StudentCount": studentCount,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ClassTestResultData {
  ClassTestResultData({
    this.recordId,
    this.classSection,
    this.subject,
    this.name,
    this.rollNo,
    this.studentPhoto,
    this.maxMarks,
    this.obtainedMarks,
    this.otainController,
    this.validationdata,
    this.admissionNo
  });

  String? recordId;
  String? classSection;
  String? subject;
  String? studentPhoto;
  String? name;
  String? rollNo;
  String? maxMarks;
  String? obtainedMarks;
  TextEditingController? otainController;
  String? validationdata;
  String? admissionNo;

  factory ClassTestResultData.fromJson(Map<String, dynamic> json) => ClassTestResultData(
    recordId: json["RecordID"],
    classSection: json["ClassSection"],
    subject: json["Subject"],
    studentPhoto: json["StudentPhoto"],
    name: json["Name"],
    rollNo: json["RollNo"],
    maxMarks: json["MaxMarks"],
    otainController: TextEditingController(text: json["ObtainedMarks"]),
    obtainedMarks: json["ObtainedMarks"] == null ? "0" : json["ObtainedMarks"],
    admissionNo: json["AdmissionNo"],
    // otainController: TextEditingController(text: json["ObtainedMarks"]),
    // obtainedMarks: json["ObtainedMarks"],
  );

  Map<String, dynamic> toJson() => {
    "RecordID": recordId,
    "ClassSection": classSection,
    "Subject": subject,
    "StudentPhoto": studentPhoto,
    "Name": name,
    "RollNo": rollNo,
    "MaxMarks": maxMarks,
    "ObtainedMarks": obtainedMarks == null ? null : obtainedMarks,
    "AdmissionNo": admissionNo,
    //"ObtainedMarks": obtainedMarks == null ? null : obtainedMarks,
  };
}
