// To parse this JSON data, do
//
//     final myVideosModel = myVideosModelFromJson(jsonString);

import 'dart:convert';

MyVideosModel myVideosModelFromJson(String str) => MyVideosModel.fromJson(json.decode(str));

String myVideosModelToJson(MyVideosModel data) => json.encode(data.toJson());

class MyVideosModel {
  int? status;
  String? message;
  List<Datum>? data;

  MyVideosModel({
    this.status,
    this.message,
    this.data,
  });

  factory MyVideosModel.fromJson(Map<String, dynamic> json) => MyVideosModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int userId;
  int productId;
  int categoryId;
  String videoUrl;
  String thumbnail;

  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.userId,
    required this.productId,
    required this.categoryId,
    required this.videoUrl,
    required this.thumbnail,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    categoryId: json["category_id"],
    videoUrl: json["video_url"],
    thumbnail: json["thumbnail"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "category_id": categoryId,
    "video_url": videoUrl,
    "thumbnail": thumbnail,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
