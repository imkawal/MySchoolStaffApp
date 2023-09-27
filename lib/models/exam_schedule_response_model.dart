// To parse this JSON data, do
//
//     final examScheduleResModel = examScheduleResModelFromJson(jsonString);

import 'dart:convert';

ExamScheduleResModel examScheduleResModelFromJson(String str) => ExamScheduleResModel.fromJson(json.decode(str));

String examScheduleResModelToJson(ExamScheduleResModel data) => json.encode(data.toJson());

class ExamScheduleResModel {
  ExamScheduleResModel({
    this.message,
    this.result,
    this.data,
  });

  String? message;
  String? result;
  List<ExamScheduleData>? data;

  factory ExamScheduleResModel.fromJson(Map<String, dynamic> json) => ExamScheduleResModel(
    message: json["message"],
    result: json["result"],
    data: List<ExamScheduleData>.from(json["data"].map((x) => ExamScheduleData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ExamScheduleData  {
  ExamScheduleData ({
    this.recordId,
    this.exam,
    this.examinationTypeId,
    this.classId,
    this.classSection,
    this.subjectName,
    this.classSubjectId,
    this.classSectionId,
    this.inputType,
    this.maxGrade,
    this.maxMarks,
    this.isPublsih,
    this.subjectTypeId
  });

  String? recordId;
  String? exam;
  String? examinationTypeId;
  String? classId;
  String? classSection;
  String? subjectName;
  String? classSubjectId;
  String? classSectionId;
  String? inputType;
  String? maxGrade;
  String? maxMarks;
  String? isPublsih;
  String? subjectTypeId;

  factory ExamScheduleData.fromJson(Map<String, dynamic> json) => ExamScheduleData (
    recordId: json["RecordID"],
    exam: json["Exam"],
    examinationTypeId: json["ExaminationTypeID"],
    classId: json["ClassID"],
    classSection: json["ClassSection"],
    subjectName: json["SubjectName"],
    classSubjectId: json["ClassSubjectID"],
    classSectionId: json["ClassSectionID"],
    inputType: json["InputType"],
    maxGrade: json["MaxGrade"] == null ? null : json["MaxGrade"],
    maxMarks: json["MaxMarks"],
    isPublsih: json["IsPublsih"],
    subjectTypeId: json["SubjectTypeID"],
  );

  Map<String, dynamic> toJson() => {
    "RecordID": recordId,
    "Exam": exam,
    "ExaminationTypeID": examinationTypeId,
    "ClassID": classId,
    "ClassSection": classSection,
    "SubjectName": subjectName,
    "ClassSubjectID": classSubjectId,
    "ClassSectionID": classSectionId,
    "InputType": inputType,
    "MaxGrade": maxGrade == null ? null : maxGrade,
    "MaxMarks": maxMarks,
    "IsPublsih": isPublsih,
    "SubjectTypeID": subjectTypeId,
  };
}

enum ClassSection { I_A }

final classSectionValues = EnumValues({
  "I-A": ClassSection.I_A
});

enum InputType { MARKS, GRADE }

final inputTypeValues = EnumValues({
  "Grade": InputType.GRADE,
  "Marks": InputType.MARKS
});

enum MaxGrade { A1 }

final maxGradeValues = EnumValues({
  "A1": MaxGrade.A1
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
