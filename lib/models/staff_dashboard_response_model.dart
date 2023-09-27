// To parse this JSON data, do
//
//     final staffDashboardResModel = staffDashboardResModelFromJson(jsonString);

import 'dart:convert';

StaffDashboardResModel staffDashboardResModelFromJson(String str) => StaffDashboardResModel.fromJson(json.decode(str));

String staffDashboardResModelToJson(StaffDashboardResModel data) => json.encode(data.toJson());

class StaffDashboardResModel {
  StaffDashboardResModel({
     this.message,
     this.result,
     this.data,
  });

  String? message;
  String? result;
  List<StaffData >? data;

  factory StaffDashboardResModel.fromJson(Map<String, dynamic> json) => StaffDashboardResModel(
    message: json["message"],
    result: json["result"],
    data: List<StaffData >.from(json["data"].map((x) => StaffData .fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StaffData  {
  StaffData ({
     this.schoolName,
     this.staffName,
     this.fatherName,
     this.spouseName,
     this.gender,
     this.phoneNumber,
     this.designation,
     this.staffType,
     this.photo,
     this.classIncharge,
     this.subjects,
     this.staffAttendance,
     this.quickAction,
     this.liveClassInfo,
     this.latestInfo,
  });

  String? schoolName;
  String? staffName;
  String? fatherName;
  String? spouseName;
  String? gender;
  String? phoneNumber;
  String? designation;
  String? staffType;
  String? photo;
  List<ClassIncharge>? classIncharge;
  List<SubjectIncharge >? subjects;
  List<StaffAttendance>? staffAttendance;
  List<QuickAction>? quickAction;
  List<LiveClassInfo>? liveClassInfo;
  List<LatestInfo>? latestInfo;

  factory StaffData .fromJson(Map<String, dynamic> json) => StaffData (
    schoolName: json["SchoolName"],
    staffName: json["StaffName"],
    fatherName: json["FatherName"],
    spouseName: json["SpouseName"],
    gender: json["Gender"],
    phoneNumber: json["PhoneNumber"],
    designation: json["Designation"],
    staffType: json["StaffType"],
    photo: json["Photo"],
    classIncharge: List<ClassIncharge>.from(json["ClassIncharge"].map((x) => ClassIncharge.fromJson(x))),
    subjects: List<SubjectIncharge >.from(json["Subjects"].map((x) => SubjectIncharge .fromJson(x))),
    staffAttendance: List<StaffAttendance>.from(json["StaffAttendance"].map((x) => StaffAttendance.fromJson(x))),
    quickAction: List<QuickAction>.from(json["QuickAction"].map((x) => QuickAction.fromJson(x))),
    liveClassInfo: List<LiveClassInfo>.from(json["LiveClassInfo"].map((x) => LiveClassInfo.fromJson(x))),
    latestInfo: List<LatestInfo>.from(json["LatestInfo"].map((x) => LatestInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SchoolName": schoolName,
    "StaffName": staffName,
    "FatherName": fatherName,
    "SpouseName": spouseName,
    "Gender": gender,
    "PhoneNumber": phoneNumber,
    "Designation": designation,
    "StaffType": staffType,
    "Photo": photo,
    "ClassIncharge": List<dynamic>.from(classIncharge!.map((x) => x.toJson())),
    "Subjects": List<dynamic>.from(subjects!.map((x) => x.toJson())),
    "StaffAttendance": List<dynamic>.from(staffAttendance!.map((x) => x.toJson())),
    "QuickAction": List<dynamic>.from(quickAction!.map((x) => x.toJson())),
    "LiveClassInfo": List<dynamic>.from(liveClassInfo!.map((x) => x.toJson())),
    "LatestInfo": List<dynamic>.from(latestInfo!.map((x) => x.toJson())),
  };
}

class ClassIncharge {
  ClassIncharge({
     this.classSection,
     this.type,
     this.classSectionId,
     this.classId,
     this.classInchargeStaffId,
     this.staffId,
     this.stdata,
  });

  String? classSection;
  String? type;
  String? classSectionId;
  String? classId;
  String? classInchargeStaffId;
  String? staffId;
  String? stdata;

  factory ClassIncharge.fromJson(Map<String, dynamic> json) => ClassIncharge(
    classSection: json["ClassSection"],
    type: json["Type"],
    classSectionId: json["ClassSectionID"],
    classId: json["ClassID"],
    classInchargeStaffId: json["ClassInchargeStaffID"],
    staffId: json["StaffID"],
    stdata: json["STDATA"],
  );

  Map<String, dynamic> toJson() => {
    "ClassSection": classSection,
    "Type": type,
    "ClassSectionID": classSectionId,
    "ClassID": classId,
    "ClassInchargeStaffID": classInchargeStaffId,
    "StaffID": staffId,
    "STDATA": stdata,
  };
}

class LatestInfo {
  LatestInfo({
     this.date,
     this.messageType,
     this.heading,
     this.description,
     this.navigate,
  });

  String? date;
  String? messageType;
  String? heading;
  String? description;
  String? navigate;

  factory LatestInfo.fromJson(Map<String, dynamic> json) => LatestInfo(
    date: json["Date"],
    messageType: json["MessageType"],
    heading: json["Heading"],
    description: json["Description"],
    navigate: json["Navigate"],
  );

  Map<String, dynamic> toJson() => {
    "Date": date,
    "MessageType": messageType,
    "Heading": heading,
    "Description": description,
    "Navigate": navigate,
  };
}

class LiveClassInfo {
  LiveClassInfo({
     this.classSection,
     this.classSubject,
     this.heading,
     this.startTime,
     this.duration,
     this.description,
     required this.link,
     this.button,
     this.navigate,
  });

  String? classSection;
  String? classSubject;
  String? heading;
  String? startTime;
  String? duration;
  String? description;
  String link;
  String? button;
  String? navigate;

  factory LiveClassInfo.fromJson(Map<String, dynamic> json) => LiveClassInfo(
    classSection: json["ClassSection"],
    classSubject: json["ClassSubject"],
    heading: json["Heading"],
    startTime: json["StartTime"],
    duration: json["Duration"],
    description: json["Description"],
    link: json["Link"],
    button: json["Button"],
    navigate: json["Navigate"],
  );

  Map<String, dynamic> toJson() => {
    "ClassSection": classSection,
    "ClassSubject": classSubject,
    "Heading": heading,
    "StartTime": startTime,
    "Duration": duration,
    "Description": description,
    "Link": link,
    "Button": button,
    "Navigate": navigate,
  };
}

class QuickAction {
  QuickAction({
     this.icon,
     this.name,
     this.link,
     this.navigate,
  });

  String? icon;
  String? name;
  String? link;
  String? navigate;

  factory QuickAction.fromJson(Map<String, dynamic> json) => QuickAction(
    icon: json["Icon"],
    name: json["Name"],
    link: json["Link"],
    navigate: json["Navigate"],
  );

  Map<String, dynamic> toJson() => {
    "Icon": icon,
    "Name": name,
    "Link": link,
    "Navigate": navigate,
  };
}

class StaffAttendance {
  StaffAttendance({
     this.totalDays,
     this.totalPresent,
     this.totalAbsent,
     this.totalLeaves,
  });

  String? totalDays;
  String? totalPresent;
  String? totalAbsent;
  String? totalLeaves;

  factory StaffAttendance.fromJson(Map<String, dynamic> json) => StaffAttendance(
    totalDays: json["TotalDays"].toString(),
    totalPresent: json["TotalPresent"].toString(),
    totalAbsent: json["TotalAbsent"].toString(),
    totalLeaves: json["TotalLeaves"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "TotalDays": totalDays,
    "TotalPresent": totalPresent,
    "TotalAbsent": totalAbsent,
    "TotalLeaves": totalLeaves,
  };
}

class SubjectIncharge  {
  SubjectIncharge ({
    this.classSection,
    this.subjectName,
    this.classId,
    this.type,
    this.classSubjectId,
    this.classSubjectStaffId,
    this.subjectId,
    this.classSectionId,
    this.stdata,
  });

  String? classSection;
  String? subjectName;
  String? type;
  String? classId;
  String? classSubjectId;
  String? classSubjectStaffId;
  String? subjectId;
  String? classSectionId;
  String? stdata;

  factory SubjectIncharge .fromJson(Map<String, dynamic> json) => SubjectIncharge (
    classSection: json["ClassSection"],
    type: json["Type"],
    subjectName: json["SubjectName"],
    classId: json["ClassID"],
    classSubjectId: json["ClassSubjectID"],
    classSubjectStaffId: json["ClassSubjectStaffID"],
    subjectId: json["SubjectID"],
    classSectionId: json["ClassSectionID"],
    stdata: json["STDATA"],
  );

  Map<String, dynamic> toJson() => {
    "ClassSection": classSection,
    "Type": type,
    "SubjectName": subjectName,
    "ClassID": classId,
    "ClassSubjectID": classSubjectId,
    "ClassSubjectStaffID": classSubjectStaffId,
    "SubjectID": subjectId,
    "ClassSectionID": classSectionId,
    "STDATA": stdata,
  };
}
