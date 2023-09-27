// To parse this JSON data, do
//
//     final gradeResponseModel = gradeResponseModelFromJson(jsonString);

import 'dart:convert';

GradeResponseModel gradeResponseModelFromJson(String str) => GradeResponseModel.fromJson(json.decode(str));

String gradeResponseModelToJson(GradeResponseModel data) => json.encode(data.toJson());

class GradeResponseModel {
  GradeResponseModel({
    this.message,
    this.result,
    this.data,
  });

  String? message;
  String? result;
  List<GradeData>? data;

  factory GradeResponseModel.fromJson(Map<String, dynamic> json) => GradeResponseModel(
    message: json["message"],
    result: json["result"],
    data: List<GradeData>.from(json["data"].map((x) => GradeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GradeData {
  GradeData({
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

  factory GradeData.fromJson(Map<String, dynamic> json) => GradeData(
    recordId: json["RecordID"],
    grade: json["Grade"],
    from: json["From %"],
    to: json["To %"],
    gp: json["GP"] == null ? null : json["GP"],
    remark: json["Remark"] == null ? null : json["Remark"],
  );

  Map<String, dynamic> toJson() => {
    "RecordID": recordId,
    "Grade": grade,
    "From %": from,
    "To %": to,
    "GP": gp == null ? null : gp,
    "Remark": remark == null ? null : remark,
  };
}
