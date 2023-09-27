// To parse this JSON data, do
//
//     final showExamResultResModel = showExamResultResModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:staffapp/models/grade_response_model.dart';

ShowExamResultResModel showExamResultResModelFromJson(String str) => ShowExamResultResModel.fromJson(json.decode(str));

String showExamResultResModelToJson(ShowExamResultResModel data) => json.encode(data.toJson());

class ShowExamResultResModel {
  ShowExamResultResModel({
    this.message,
    this.result,
    this.data,
  });

  String? message;
  String? result;
  List<ExamResultData>? data;

  factory ShowExamResultResModel.fromJson(Map<String, dynamic> json) => ShowExamResultResModel(
    message: json["message"],
    result: json["result"],
    data: List<ExamResultData>.from(json["data"].map((x) => ExamResultData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ExamResultData {
  ExamResultData({
    this.recordId,
    this.student,
    this.rollNo,
    this.classSection,
    this.subjectName,
    this.classSubjectId,
    this.classSectionId,
    this.obtainedGrade,
    this.maxMarks,
    this.obtainedMarks,
    this.otainController,
    this.studemtData,
    this.studentPhoto,
    this.validationdata,
    this.admissionNo,
    this.gradeController,
    this.subjectTypeId
    //this. obtaingradeCon,
  });

  String? recordId;
  String? student;
  String? rollNo;
  String? studentPhoto;
  String? classSection;
  dynamic subjectName;
  String? classSubjectId;
  String? classSectionId;
  GradeData? obtainedGrade;
  String? maxMarks;
  String? obtainedMarks;
  TextEditingController? otainController;
  TextEditingController? gradeController;
  //TextEditingController? obtaingradeCon;
  String? validationdata;
  GradeData? studemtData;
  String? admissionNo;
  String? subjectTypeId;

  factory ExamResultData.fromJson(Map<String, dynamic> json) => ExamResultData(
    recordId: json["RecordID"],
    student: json["Student"],
    rollNo: json["RollNo"],
    classSection: json["ClassSection"],
    studentPhoto: json["StudentPhoto"],
    subjectName: json["SubjectName"],
    classSubjectId: json["ClassSubjectID"],
    classSectionId: json["ClassSectionID"],
    obtainedGrade: json["ObtainedGrade"] == null ? GradeData() : GradeData.fromJson(json["ObtainedGrade"]),
     // studemtData: ObtainedGrade.fromJson(json["ObtainedGrade"]),
    maxMarks: json["MaxMarks"],
    otainController: TextEditingController(text: json["ObtainedMarks"]),
    obtainedMarks: json["ObtainedMarks"] == null ? null : json["ObtainedMarks"],
    admissionNo: json["AdmissionNo"],
    gradeController: TextEditingController(text: json["ObtainedGrade"] == null ? null : GradeData.fromJson(json["ObtainedGrade"]).recordId),
    subjectTypeId: json["SubjectTypeID"],

  );

  Map<String, dynamic> toJson() => {
    "RecordID": recordId,
    "Student": student,
    "RollNo": rollNo,
    "ClassSection": classSection,
    "SubjectName": subjectName,
    "ClassSubjectID": classSubjectId,
    "ClassSectionID": classSectionId,
    "ObtainedGrade": obtainedGrade?.toJson(),
    "StudentPhoto": studentPhoto,
    "MaxMarks": maxMarks,
    "ObtainedMarks": obtainedMarks == null ? null : obtainedMarks,
    "AdmissionNo": admissionNo,
    "SubjectTypeID": subjectTypeId,
  };
}
class ObtainedGrade {
  ObtainedGrade({
    this.recordId,
    this.grade,
    this.from,
    this.to,
    this.gp,
    this.remark,
  });

  String? recordId;
  String? grade;
  String? from;
  String? to;
  String? gp;
  String? remark;

  factory ObtainedGrade.fromJson(Map<String, dynamic> json) => ObtainedGrade(
    recordId: json["RecordID"],
    grade: json["Grade"],
    from: json["From %"],
    to: json["To %"],
    gp: json["GP"],
    remark: json["Remark"],
  );

  Map<String, dynamic> toJson() => {
    "RecordID": recordId,
    "Grade": grade,
    "From %": from,
    "To %": to,
    "GP": gp,
    "Remark": remark,
  };
}

