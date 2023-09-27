// To parse this JSON data, do
//
//     final classTestResModel = classTestResModelFromJson(jsonString);

import 'dart:convert';

ClassTestResModel classTestResModelFromJson(String str) => ClassTestResModel.fromJson(json.decode(str));

String classTestResModelToJson(ClassTestResModel data) => json.encode(data.toJson());

class ClassTestResModel {
  ClassTestResModel({
    this.message,
    this.result,
    this.data,
  });

  String? message;
  String? result;
  List<ClassTestData>? data;

  factory ClassTestResModel.fromJson(Map<String, dynamic> json) => ClassTestResModel(
    message: json["message"],
    result: json["result"],
    data: List<ClassTestData>.from(json["data"].map((x) => ClassTestData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ClassTestData {
  ClassTestData({
    this.recordId,
    this.name,
    this.classSection,
    this.subjectName,
    this.classSubjectId,
    this.classSectionId,
    this.date,
    this.maxMarks,
    this.isPublish,
  });

  String? recordId;
  String? name;
  String? classSection;
  String? subjectName;
  String? classSubjectId;
  String? classSectionId;
  String? date;
  String? maxMarks;
  String? isPublish;

  factory ClassTestData.fromJson(Map<String, dynamic> json) => ClassTestData(
    recordId: json["RecordID"],
    name: json["Name"],
    classSection: json["ClassSection"],
    subjectName: json["SubjectName"],
    classSubjectId: json["ClassSubjectID"],
    classSectionId: json["ClassSectionID"],
    date: json["Date"],
    maxMarks: json["MaxMarks"],
      isPublish: json["IsPublish"]
  );

  Map<String, dynamic> toJson() => {
    "RecordID": recordId,
    "Name": name,
    "ClassSection": classSection,
    "SubjectName": subjectName,
    "ClassSubjectID": classSubjectId,
    "ClassSectionID": classSectionId,
    "Date": date,
    "MaxMarks": maxMarks,
    "IsPublish": isPublish,
  };
}
