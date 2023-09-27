// To parse this JSON data, do
//
//     final studentTimeTableResModel = studentTimeTableResModelFromJson(jsonString);

import 'dart:convert';

StudentTimeTableResModel studentTimeTableResModelFromJson(String str) => StudentTimeTableResModel.fromJson(json.decode(str));

String studentTimeTableResModelToJson(StudentTimeTableResModel data) => json.encode(data.toJson());

class StudentTimeTableResModel {
  StudentTimeTableResModel({
    this.message,
    this.result,
    this.next,
    this.data,
  });

  String? message;
  String? result;
  bool? next;
  List<TimeTableData>? data;

  factory StudentTimeTableResModel.fromJson(Map<String, dynamic> json) => StudentTimeTableResModel(
    message: json["message"],
    result: json["result"],
    next: json["next"],
    data: List<TimeTableData>.from(json["data"].map((x) => TimeTableData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "next": next,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TimeTableData {
  TimeTableData({
    this.date,
    this.message,
    this.classSectionId,
    this.messageType,
    this.type,
    this.fileImage,
    this.images,
  });

  String? date;
  String? message;
  String? classSectionId;
  String? messageType;
  String? type;
  String? fileImage;
  List<String>? images;

  factory TimeTableData.fromJson(Map<String, dynamic> json) => TimeTableData(
    date: json["Date"],
    message: json["Message"],
    classSectionId: json["ClassSectionID"],
    messageType: json["MessageType"],
    type: json["Type"],
    fileImage: json["FileImage"],
    images: List<String>.from(json["Images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Date": date,
    "Message": message,
    "ClassSectionID": classSectionId,
    "MessageType": messageType,
    "Type": type,
    "FileImage": fileImage,
    "Images": List<dynamic>.from(images!.map((x) => x)),
  };
}
