class AllReelsModel {
  int? status;
  String? message;
  List<Data>? data;

  AllReelsModel({this.status, this.message, this.data});

  AllReelsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? productId;
  int? categoryId;
  String? videoUrl;
  String? thumbnail;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.productId,
        this.categoryId,
        this.videoUrl,
        this.thumbnail,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    categoryId = json['category_id'];
    videoUrl = json['video_url'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['category_id'] = this.categoryId;
    data['video_url'] = this.videoUrl;
    data['thumbnail'] = this.thumbnail;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
