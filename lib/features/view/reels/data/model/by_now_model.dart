// To parse this JSON data, do
//
//     final buyNowModel = buyNowModelFromJson(jsonString);

import 'dart:convert';

BuyNowModel buyNowModelFromJson(String str) => BuyNowModel.fromJson(json.decode(str));

String buyNowModelToJson(BuyNowModel data) => json.encode(data.toJson());

class BuyNowModel {
  int? qty;
  var sizeKey;
  String? sizeQty;
  var sizePrice;
  String? size;
  String? color;
  dynamic stock;
  int? price;
  Item? item;
  String? license;
  String? dp;
  String? keys;
  String? values;
  String? videoId;
  String? buyCart;

  BuyNowModel({
    this.qty,
    this.sizeKey,
    this.sizeQty,
    this.sizePrice,
    this.size,
    this.color,
    this.stock,
    this.price,
    this.item,
    this.license,
    this.dp,
    this.keys,
    this.values,
    this.videoId,
    this.buyCart,
  });

  factory BuyNowModel.fromJson(Map<String, dynamic> json) => BuyNowModel(
    qty: json["qty"],
    sizeKey: json["size_key"],
    sizeQty: json["size_qty"],
    sizePrice: json["size_price"],
    size: json["size"],
    color: json["color"],
    stock: json["stock"],
    price: json["price"],
    item: Item.fromJson(json["item"]),
    license: json["license"],
    dp: json["dp"],
    keys: json["keys"],
    values: json["values"],
    videoId: json["video_id"],
    buyCart: json["buyCart"],
  );

  Map<String, dynamic> toJson() => {
    "qty": qty,
    "size_key": sizeKey,
    "size_qty": sizeQty,
    "size_price": sizePrice,
    "size": size,
    "color": color,
    "stock": stock,
    "price": price,
    "item": item?.toJson(),
    "license": license,
    "dp": dp,
    "keys": keys,
    "values": values,
    "video_id": videoId,
    "buyCart": buyCart,
  };
}

class Item {
  int id;
  int userId;
  String slug;
  String name;
  String photo;
  dynamic size;
  dynamic sizeQty;
  dynamic sizePrice;
  dynamic color;
  int price;
  dynamic stock;
  String type;
  dynamic file;
  dynamic link;
  String license;
  String licenseQty;
  dynamic measure;
  dynamic wholeSellQty;
  dynamic wholeSellDiscount;
  dynamic attributes;

  Item({
    required this.id,
    required this.userId,
    required this.slug,
    required this.name,
    required this.photo,
    required this.size,
    required this.sizeQty,
    required this.sizePrice,
    required this.color,
    required this.price,
    required this.stock,
    required this.type,
    required this.file,
    required this.link,
    required this.license,
    required this.licenseQty,
    required this.measure,
    required this.wholeSellQty,
    required this.wholeSellDiscount,
    required this.attributes,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    userId: json["user_id"],
    slug: json["slug"],
    name: json["name"],
    photo: json["photo"],
    size: json["size"].toString().isEmpty ?  json["size"] : List<String>.from(json["size"].map((x) => x)),
    sizeQty: json["size_qty"].toString().isEmpty ? json["size_qty"] : List<String>.from(json["size_qty"].map((x) => x)),
    sizePrice: json["size_price"].toString().isEmpty? json["size_price"] : List<String>.from(json["size_price"].map((x) => x)),
    color: json["color"].toString().isEmpty ? json["color"] : List<String>.from(json["color"].map((x) => x)),
    price: json["price"],
    stock: json["stock"],
    type: json["type"],
    file: json["file"],
    link: json["link"],
    license: json["license"],
    licenseQty: json["license_qty"],
    measure: json["measure"],
    wholeSellQty: json["whole_sell_qty"].toString().isEmpty ? json["whole_sell_qty"] : List<String>.from(json["whole_sell_qty"].map((x) => x)),
    wholeSellDiscount: json["whole_sell_discount"].toString().isEmpty ? json["whole_sell_discount"] : List<String>.from(json["whole_sell_discount"].map((x) => x)),
    attributes: json["attributes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "slug": slug,
    "name": name,
    "photo": photo,
    "size": List<dynamic>.from(size.map((x) => x)),
    "size_qty": List<dynamic>.from(sizeQty.map((x) => x)),
    "size_price": List<dynamic>.from(sizePrice.map((x) => x)),
    "color": List<dynamic>.from(color.map((x) => x)),
    "price": price,
    "stock": stock,
    "type": type,
    "file": file,
    "link": link,
    "license": license,
    "license_qty": licenseQty,
    "measure": measure,
    "whole_sell_qty": List<dynamic>.from(wholeSellQty.map((x) => x)),
    "whole_sell_discount": List<dynamic>.from(wholeSellDiscount.map((x) => x)),
    "attributes": attributes,
  };
}
