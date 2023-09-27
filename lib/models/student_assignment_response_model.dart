// To parse this JSON data, do
//
//     final studentAssignmentResModel = studentAssignmentResModelFromJson(jsonString);

import 'dart:convert';

StudentAssignmentResModel studentAssignmentResModelFromJson(String str) => StudentAssignmentResModel.fromJson(json.decode(str));

String studentAssignmentResModelToJson(StudentAssignmentResModel data) => json.encode(data.toJson());

class StudentAssignmentResModel {
  StudentAssignmentResModel({
    this.message,
    this.result,
    this.data,
  });

  String? message;
  String? result;
  List<StudentAssignmentData>? data;

  factory StudentAssignmentResModel.fromJson(Map<String, dynamic> json) => StudentAssignmentResModel(
    message: json["message"],
    result: json["result"],
    data: List<StudentAssignmentData>.from(json["data"].map((x) => StudentAssignmentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StudentAssignmentData {
  StudentAssignmentData({
    this.recordId,
    this.name,
    this.classSection,
    this.subjectName,
    this.date,
    this.lastSubmitDate,
    this.description,
    this.showUploadButton,
    this.isSubmitted,
    this.isTeacherCheck,
    this.remarks,
    this.image,
    this.pdf,
    this.audio,
    this.video,
  });

  String? recordId;
  String? name;
  String? classSection;
  String? subjectName;
  String? date;
  String? lastSubmitDate;
  String? description;
  int? showUploadButton;
  int? isSubmitted;
  int? isTeacherCheck;
  String? remarks;
  String? image;
  String? pdf;
  String? audio;
  String? video;

  factory StudentAssignmentData.fromJson(Map<String, dynamic> json) => StudentAssignmentData(
    recordId: json["RecordID"],
    name: json["Name"],
    classSection: json["ClassSection"],
    subjectName: json["SubjectName"],
    date: json["Date"],
    lastSubmitDate: json["LastSubmitDate"],
    description: json["Description"],
    showUploadButton: json["ShowUploadButton"],
    isSubmitted: json["IsSubmitted"],
    isTeacherCheck: json["IsTeacherCheck"],
    remarks: json["Remarks"],
    image: json["Image"],
    pdf: json["PDF"],
    audio: json["Audio"],
    video: json["Video"],
  );

  Map<String, dynamic> toJson() => {
    "RecordID": recordId,
    "Name": name,
    "ClassSection": classSection,
    "SubjectName": subjectName,
    "Date": date,
    "LastSubmitDate": lastSubmitDate,
    "Description": description,
    "ShowUploadButton": showUploadButton,
    "IsSubmitted": isSubmitted,
    "IsTeacherCheck": isTeacherCheck,
    "Remarks": remarks,
    "Image": image,
    "PDF": pdf,
    "Audio": audio,
    "Video": video,
  };
}
