class HomeAddToCartModel {
  int? totalPrice;
  int? mainTotal;
  int? tx;
  bool? isClickedIncrementDecrementButton;
  Map<String, ProductItem>? products;

  HomeAddToCartModel({
    this.totalPrice,
    this.mainTotal,
    this.tx,
    this.products,
    this.isClickedIncrementDecrementButton
  });

  factory HomeAddToCartModel.fromJson(Map<String, dynamic> json) => HomeAddToCartModel(
    totalPrice: json["totalPrice"],
    mainTotal: json["mainTotal"],
    tx: json["tx"],
    products: (json["products"] as Map<String, dynamic>?)?.map((key, value) =>
        MapEntry(key, ProductItem.fromJson(value))),
  );

  Map<String, dynamic> toJson() => {
    "totalPrice": totalPrice,
    "mainTotal": mainTotal,
    "tx": tx,
    "products": products?.map((key, value) => MapEntry(key, value.toJson())),
  };
}

class ProductItem {
  int? qty;
  int? sizeKey;
  dynamic sizeQty;
  dynamic sizePrice;
  dynamic size;
  dynamic color;
  int? stock;
  int? price;
  Item? item;
  dynamic license;
  String? dp;
  dynamic keys;
  dynamic values;
  String? videoId;
  int? priceSum;
  int? productCountIncrement;

  ProductItem({
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
    this.productCountIncrement,
    this.priceSum,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
    qty: json["qty"],
    sizeKey: json["size_key"],
    sizeQty: json["size_qty"],
    sizePrice: json["size_price"],
    size: json["size"],
    color: json["color"],
    stock: json["stock"],
    price: json["price"],
    item: json["item"] != null ? Item.fromJson(json["item"]) : null,
    license: json["license"],
    dp: json["dp"],
    keys: json["keys"],
    values: json["values"],
    videoId: json["video_id"],
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
  };
}

class Item {
  int? id;
  int? userId;
  String? slug;
  String? name;
  String? photo;
  dynamic size;
  dynamic sizeQty;
  dynamic sizePrice;
  dynamic color;
  int? price;
  int? stock;
  String? type;
  dynamic file;
  dynamic link;
  dynamic license;
  dynamic licenseQty;
  dynamic measure;
  dynamic wholeSellQty;
  dynamic wholeSellDiscount;
  dynamic attributes;

  Item({
    this.id,
    this.userId,
    this.slug,
    this.name,
    this.photo,
    this.size,
    this.sizeQty,
    this.sizePrice,
    this.color,
    this.price,
    this.stock,
    this.type,
    this.file,
    this.link,
    this.license,
    this.licenseQty,
    this.measure,
    this.wholeSellQty,
    this.wholeSellDiscount,
    this.attributes,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    userId: json["user_id"],
    slug: json["slug"],
    name: json["name"],
    photo: json["photo"],
    size: json["size"],
    sizeQty: json["size_qty"],
    sizePrice: json["size_price"],
    color: json["color"],
    price: json["price"],
    stock: json["stock"],
    type: json["type"],
    file: json["file"],
    link: json["link"],
    license: json["license"],
    licenseQty: json["license_qty"],
    measure: json["measure"],
    wholeSellQty: json["whole_sell_qty"],
    wholeSellDiscount: json["whole_sell_discount"],
    attributes: json["attributes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "slug": slug,
    "name": name,
    "photo": photo,
    "size": size,
    "size_qty": sizeQty,
    "size_price": sizePrice,
    "color": color,
    "price": price,
    "stock": stock,
    "type": type,
    "file": file,
    "link": link,
    "license": license,
    "license_qty": licenseQty,
    "measure": measure,
    "whole_sell_qty": wholeSellQty,
    "whole_sell_discount": wholeSellDiscount,
    "attributes": attributes,
  };
}
