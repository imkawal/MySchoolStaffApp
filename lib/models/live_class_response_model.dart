// To parse this JSON data, do
//
//     final liveClassResModel = liveClassResModelFromJson(jsonString);

import 'dart:convert';

LiveClassResModel liveClassResModelFromJson(String str) => LiveClassResModel.fromJson(json.decode(str));

String liveClassResModelToJson(LiveClassResModel data) => json.encode(data.toJson());

class LiveClassResModel {
  LiveClassResModel({
     this.message,
     this.result,
     this.currentClasses,
     this.upcomingClasses,
     this.doneClasses,
  });

  String? message;
  String? result;
  List<Class>? currentClasses;
  List<Class>? upcomingClasses;
  List<Class>? doneClasses;

  factory LiveClassResModel.fromJson(Map<String, dynamic> json) => LiveClassResModel(
    message: json["message"],
    result: json["result"],
    currentClasses: List<Class>.from(json["CurrentClasses"].map((x) => Class.fromJson(x))),
    upcomingClasses: List<Class>.from(json["UpcomingClasses"].map((x) => Class.fromJson(x))),
    doneClasses: List<Class>.from(json["DoneClasses"].map((x) => Class.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "CurrentClasses": List<dynamic>.from(currentClasses!.map((x) => x.toJson())),
    "UpcomingClasses": List<dynamic>.from(upcomingClasses!.map((x) => x.toJson())),
    "DoneClasses": List<dynamic>.from(doneClasses!.map((x) => x.toJson())),
  };
}

class Class {
  Class({
     this.recordId,
     this.heading,
     this.classSection,
     this.subjectName,
     this.duration,
     this.startTime,
     this.link,
     this.navigate,
  });

  String? recordId;
  String? heading;
  String? classSection;
  String? subjectName;
  String? duration;
  String? startTime;
  String? link;
  int? navigate;

  factory Class.fromJson(Map<String, dynamic> json) => Class(
    recordId: json["RecordID"],
    heading: json["Heading"],
    classSection: json["ClassSection"],
    subjectName: json["SubjectName"],
    duration: json["Duration"],
    startTime: json["StartTime"],
    link: json["Link"],
    navigate: json["Navigate"],
  );

  Map<String, dynamic> toJson() => {
    "RecordID": recordId,
    "Heading": heading,
    "ClassSection": classSection,
    "SubjectName": subjectName,
    "Duration": duration,
    "StartTime": startTime,
    "Link": link,
    "Navigate": navigate,
  };
}
