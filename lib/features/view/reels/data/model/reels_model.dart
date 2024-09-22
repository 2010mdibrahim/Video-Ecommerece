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
  int? views;
  int? likes;
  int? shares;
  String? thumbnail;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? creatorName;
  String? creatorPhoto;
  String? creatorPhone;
  String? creatorEmail;
  Null? creatorCountry;
  String? creatorAddress;
  Null? creatorShopName;
  Null? creatorShopAddress;
  String? slug;
  String? productName;
  String? productPhoto;
  String? productThumbnail;
  Null? size;
  Null? sizeQty;
  Null? sizePrice;
  Null? color;
  int? price;
  int? previousPrice;
  String? details;
  int? stock;
  String? catName;
  String? catPhoto;
  int? likeStatus;

  Data(
      {this.id,
        this.userId,
        this.productId,
        this.categoryId,
        this.videoUrl,
        this.views,
        this.likes,
        this.shares,
        this.thumbnail,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.creatorName,
        this.creatorPhoto,
        this.creatorPhone,
        this.creatorEmail,
        this.creatorCountry,
        this.creatorAddress,
        this.creatorShopName,
        this.creatorShopAddress,
        this.slug,
        this.productName,
        this.productPhoto,
        this.productThumbnail,
        this.size,
        this.sizeQty,
        this.sizePrice,
        this.color,
        this.price,
        this.previousPrice,
        this.details,
        this.stock,
        this.catName,
        this.catPhoto,
        this.likeStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    categoryId = json['category_id'];
    videoUrl = json['video_url'];
    views = json['views'];
    likes = json['likes'];
    shares = json['shares'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    creatorName = json['creator_name'];
    creatorPhoto = json['creator_photo'];
    creatorPhone = json['creator_phone'];
    creatorEmail = json['creator_email'];
    creatorCountry = json['creator_country'];
    creatorAddress = json['creator_address'];
    creatorShopName = json['creator_shop_name'];
    creatorShopAddress = json['creator_shop_address'];
    slug = json['slug'];
    productName = json['product_name'];
    productPhoto = json['product_photo'];
    productThumbnail = json['product_thumbnail'];
    size = json['size'];
    sizeQty = json['size_qty'];
    sizePrice = json['size_price'];
    color = json['color'];
    price = json['price'];
    previousPrice = json['previous_price'];
    details = json['details'];
    stock = json['stock'];
    catName = json['cat_name'];
    catPhoto = json['cat_photo'];
    likeStatus = json['like_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['category_id'] = this.categoryId;
    data['video_url'] = this.videoUrl;
    data['views'] = this.views;
    data['likes'] = this.likes;
    data['shares'] = this.shares;
    data['thumbnail'] = this.thumbnail;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['creator_name'] = this.creatorName;
    data['creator_photo'] = this.creatorPhoto;
    data['creator_phone'] = this.creatorPhone;
    data['creator_email'] = this.creatorEmail;
    data['creator_country'] = this.creatorCountry;
    data['creator_address'] = this.creatorAddress;
    data['creator_shop_name'] = this.creatorShopName;
    data['creator_shop_address'] = this.creatorShopAddress;
    data['slug'] = this.slug;
    data['product_name'] = this.productName;
    data['product_photo'] = this.productPhoto;
    data['product_thumbnail'] = this.productThumbnail;
    data['size'] = this.size;
    data['size_qty'] = this.sizeQty;
    data['size_price'] = this.sizePrice;
    data['color'] = this.color;
    data['price'] = this.price;
    data['previous_price'] = this.previousPrice;
    data['details'] = this.details;
    data['stock'] = this.stock;
    data['cat_name'] = this.catName;
    data['cat_photo'] = this.catPhoto;
    data['like_status'] = this.likeStatus;
    return data;
  }
}
