// To parse this JSON data, do
//
//     final studentAttendanceResModel = studentAttendanceResModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

StudentAttendanceResModel studentAttendanceResModelFromJson(String str) => StudentAttendanceResModel.fromJson(json.decode(str));

String studentAttendanceResModelToJson(StudentAttendanceResModel data) => json.encode(data.toJson());

class StudentAttendanceResModel {
  StudentAttendanceResModel({
     this.message,
     this.result,
     this.totalStudent,
     this.totalPresent,
     this.totalAbsent,
     this.totalLeave,
     this.classSectionId,
     this.data,
  });

  String? message;
  String? result;
  String? totalStudent;
  String? totalPresent;
  String? totalAbsent;
  String? totalLeave;
  String? classSectionId;
  List<StudentAttendanceData>? data;

  factory StudentAttendanceResModel.fromJson(Map<String, dynamic> json) => StudentAttendanceResModel(
    message: json["message"],
    result: json["result"],
    totalStudent: json["TotalStudent"],
    totalPresent: json["TotalPresent"],
    totalAbsent: json["TotalAbsent"],
    totalLeave: json["TotalLeave"],
    classSectionId: json["ClassSectionID"],
    data: List<StudentAttendanceData>.from(json["data"].map((x) => StudentAttendanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "TotalStudent": totalStudent,
    "TotalPresent": totalPresent,
    "TotalAbsent": totalAbsent,
    "TotalLeave": totalLeave,
    "ClassSectionID": classSectionId,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StudentAttendanceData {
  StudentAttendanceData({
     this.recordId,
     this.photo,
     this.studentName,
     this.rollNo,
     this.phoneNo,
     this.attendence,
     this.studentId,
     this.p,
     this.att,
     this.image,
     this.admissionNo,
  });

  String? recordId;
  String? photo;
  String? studentName;
  String? rollNo;
  String? phoneNo;
  String? attendence;
  String? p = "P";
  String? att;
  String? studentId;
  File? image;
  String? admissionNo;


  factory StudentAttendanceData.fromJson(Map<String, dynamic> json) => StudentAttendanceData(
    recordId: json["RecordID"],
    photo: json["Photo"],
    studentName: json["StudentName"],
    rollNo: json["Roll No"],
    phoneNo: json["Phone No"],
    attendence: json["Attendence"],
    studentId: json["StudentID"],
    admissionNo: json["AdmissionNo"],
  );

  Map<String, dynamic> toJson() => {
    "RecordID": recordId,
    "Photo": photo,
    "StudentName": studentName,
    "Roll No": rollNo,
    "Phone No": phoneNo,
    "Attendence": attendence,
    "StudentID": studentId,
    "AdmissionNo": admissionNo,
  };
}
