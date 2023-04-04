// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    required this.message,
    required this.status,
    required this.data,
  });

  final String message;
  final String status;
  final List<Data> data;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        message: json["message"],
        status: json["status"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.img,
    required this.icon,
    this.childs,
  });

  final int id;
  final String title;
  final String img;
  final String icon;
  final List<Data>? childs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        img: json["img"],
        icon: json["icon"],
        childs: json["childs"] == null
            ? []
            : List<Data>.from(json["childs"]!.map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "img": img,
        "icon": icon,
        "childs": childs == null
            ? []
            : List<dynamic>.from(childs!.map((x) => x.toJson())),
      };
}
