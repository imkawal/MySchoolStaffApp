// To parse this JSON data, do
//
//     final classSubjectResModel = classSubjectResModelFromJson(jsonString);

import 'dart:convert';

ClassSubjectResModel classSubjectResModelFromJson(String str) => ClassSubjectResModel.fromJson(json.decode(str));

String classSubjectResModelToJson(ClassSubjectResModel data) => json.encode(data.toJson());

class ClassSubjectResModel {
  ClassSubjectResModel({
    this.message,
    this.result,
    this.data,
  });

  String? message;
  String? result;
  List<ClassSubjectData>? data;

  factory ClassSubjectResModel.fromJson(Map<String, dynamic> json) => ClassSubjectResModel(
    message: json["message"],
    result: json["result"],
    data: List<ClassSubjectData>.from(json["data"].map((x) => ClassSubjectData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ClassSubjectData {
  ClassSubjectData({
    this.classSubjectId,
    this.subject,
    this.classId,
    this.subjectType,
    this.subjectTypeId,
  });

  String? classSubjectId;
  String? subject;
  String? classId;
  SubjectType? subjectType;
  String? subjectTypeId;

  factory ClassSubjectData.fromJson(Map<String, dynamic> json) => ClassSubjectData(
    classSubjectId: json["ClassSubjectID"],
    subject: json["Subject"],
    classId: json["ClassID"],
    subjectType: subjectTypeValues.map[json["SubjectType"]],
    subjectTypeId: json["SubjectTypeID"],
  );

  Map<String, dynamic> toJson() => {
    "ClassSubjectID": classSubjectId,
    "Subject": subject,
    "ClassID": classId,
    "SubjectType": subjectTypeValues.reverse[subjectType],
    "SubjectTypeID": subjectTypeId,
  };
}

enum SubjectType { CO_CURRICULAR, CURRICULAR }

final subjectTypeValues = EnumValues({
  "Co-Curricular": SubjectType.CO_CURRICULAR,
  "Curricular": SubjectType.CURRICULAR
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
