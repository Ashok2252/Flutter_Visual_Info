import 'dart:convert';

GetUserModel getUserModelFromJson(String str) =>
    GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
  GetUserModel({
    this.isSuccess,
    this.message,
    this.data,
  });

  bool isSuccess;
  String message;
  List<Datum> data;

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.srno,
    this.name,
    this.address,
    this.dob,
    this.mobile,
    this.email,
    this.createddate,
  });

  int srno;
  String name;
  String address;
  DateTime dob;
  String mobile;
  String email;
  DateTime createddate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        srno: json["srno"],
        name: json["name"],
        address: json["address"],
        dob: DateTime.parse(json["dob"]),
        mobile: json["mobile"],
        email: json["email"],
        createddate: DateTime.parse(json["createddate"]),
      );

  Map<String, dynamic> toJson() => {
        "srno": srno,
        "name": name,
        "address": address,
        "dob": dob.toIso8601String(),
        "mobile": mobile,
        "email": email,
        "createddate": createddate.toIso8601String(),
      };
}
