// To parse this JSON data, do
//
//     final monthlyStudentAttResModel = monthlyStudentAttResModelFromJson(jsonString);

import 'dart:convert';

MonthlyStudentAttResModel monthlyStudentAttResModelFromJson(String str) => MonthlyStudentAttResModel.fromJson(json.decode(str));

String monthlyStudentAttResModelToJson(MonthlyStudentAttResModel data) => json.encode(data.toJson());

class MonthlyStudentAttResModel {
  MonthlyStudentAttResModel({
     this.message,
     this.result,
     this.totalPresent,
     this.totalAbsent,
     this.totalLeave,
     this.totalHalfDay,
     this.data,
     this.graphData,
  });

  String? message;
  String? result;
  String? totalPresent;
  String? totalAbsent;
  String? totalLeave;
  String? totalHalfDay;
  MonthlyAttendanceData? data;
  GraphData? graphData;

  factory MonthlyStudentAttResModel.fromJson(Map<String, dynamic> json) => MonthlyStudentAttResModel(
    message: json["message"],
    result: json["result"],
    totalPresent: json["TotalPresent"],
    totalAbsent: json["TotalAbsent"],
    totalLeave: json["TotalLeave"],
    totalHalfDay: json["TotalHalfDay"],
    data: MonthlyAttendanceData.fromJson(json["data"]),
    graphData: GraphData.fromJson(json["GraphData"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result,
    "TotalPresent": totalPresent,
    "TotalAbsent": totalAbsent,
    "TotalLeave": totalLeave,
    "TotalHalfDay": totalHalfDay,
    "data": data?.toJson(),
    "GraphData": graphData?.toJson(),
  };
}

class MonthlyAttendanceData {
  MonthlyAttendanceData({
     this.months,
     this.years,
     this.monthYear,
     this.p,
     this.a,
     this.l,
     this.h,
  });

  String? months;
  String? years;
  String? monthYear;
  List<int>? p;
  List<int>? a;
  List<int>? l;
  List<dynamic>? h;

  factory MonthlyAttendanceData.fromJson(Map<String, dynamic> json) => MonthlyAttendanceData(
    months: json["Months"],
    years: json["Years"],
    monthYear: json["MonthYear"],
    p: List<int>.from(json["P"].map((x) => x)),
    a: List<int>.from(json["A"].map((x) => x)),
    l: List<int>.from(json["L"].map((x) => x)),
    h: List<dynamic>.from(json["H"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Months": months,
    "Years": years,
    "MonthYear": monthYear,
    "P": List<dynamic>.from(p!.map((x) => x)),
    "A": List<dynamic>.from(a!.map((x) => x)),
    "L": List<dynamic>.from(l!.map((x) => x)),
    "H": List<dynamic>.from(h!.map((x) => x)),
  };
}

class GraphData {
  GraphData({
     this.presents,
     this.absent,
     this.leaved,
     this.halfDays,
  });

  String? presents;
  String? absent;
  String? leaved;
  String? halfDays;

  factory GraphData.fromJson(Map<String, dynamic> json) => GraphData(
    presents: json["Presents%"],
    absent: json["Absent%"],
    leaved: json["Leaved%"],
    halfDays: json["HalfDays%"],
  );

  Map<String, dynamic> toJson() => {
    "Presents%": presents,
    "Absent%": absent,
    "Leaved%": leaved,
    "HalfDays%": halfDays,
  };
}
