class CheckoutModel {
  Products? products;
  int? totalPrice;
  List<dynamic>? pickups;
  int? totalQty;
  List<dynamic>? gateways;
  int? shippingCost;
  int? digital;
  Curr? curr;
  List<Datum>? shippingData;
  List<Datum>? packageData;
  int? vendorShippingId;
  int? vendorPackingId;

  CheckoutModel({
    this.products,
    this.totalPrice,
    this.pickups,
    this.totalQty,
    this.gateways,
    this.shippingCost,
    this.digital,
    this.curr,
    this.shippingData,
    this.packageData,
    this.vendorShippingId,
    this.vendorPackingId,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
    products: Products.fromJson(json["products"]),
    totalPrice: json["totalPrice"],
    pickups: List<dynamic>.from(json["pickups"].map((x) => x)),
    totalQty: json["totalQty"],
    gateways: List<dynamic>.from(json["gateways"].map((x) => x)),
    shippingCost: json["shipping_cost"],
    digital: json["digital"],
    curr: Curr.fromJson(json["curr"]),
    shippingData: List<Datum>.from(json["shipping_data"].map((x) => Datum.fromJson(x))),
    packageData: List<Datum>.from(json["package_data"].map((x) => Datum.fromJson(x))),
    vendorShippingId: json["vendor_shipping_id"],
    vendorPackingId: json["vendor_packing_id"],
  );

  Map<String, dynamic> toJson() => {
    "products": products?.toJson(),
    "totalPrice": totalPrice,
    "pickups": List<dynamic>.from(pickups!.map((x) => x)),
    "totalQty": totalQty,
    "gateways": List<dynamic>.from(gateways!.map((x) => x)),
    "shipping_cost": shippingCost,
    "digital": digital,
    "curr": curr?.toJson(),
    "shipping_data": List<dynamic>.from(shippingData!.map((x) => x.toJson())),
    "package_data": List<dynamic>.from(packageData!.map((x) => x.toJson())),
    "vendor_shipping_id": vendorShippingId,
    "vendor_packing_id": vendorPackingId,
  };
}

class Curr {
  int id;
  String name;
  String sign;
  int value;
  int isDefault;

  Curr({
    required this.id,
    required this.name,
    required this.sign,
    required this.value,
    required this.isDefault,
  });

  factory Curr.fromJson(Map<String, dynamic> json) => Curr(
    id: json["id"],
    name: json["name"],
    sign: json["sign"],
    value: json["value"],
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sign": sign,
    "value": value,
    "is_default": isDefault,
  };
}

class Datum {
  int id;
  int userId;
  String title;
  String subtitle;
  int price;

  Datum({
    required this.id,
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    subtitle: json["subtitle"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "subtitle": subtitle,
    "price": price,
  };
}

class Products {
  The200 the200;

  Products({
    required this.the200,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    the200: The200.fromJson(json["200"]),
  );

  Map<String, dynamic> toJson() => {
    "200": the200.toJson(),
  };
}

class The200 {
  int qty;
  int sizeKey;
  String sizeQty;
  String sizePrice;
  String size;
  String color;
  int stock;
  int price;
  Item item;
  String license;
  String dp;
  String keys;
  String values;

  The200({
    required this.qty,
    required this.sizeKey,
    required this.sizeQty,
    required this.sizePrice,
    required this.size,
    required this.color,
    required this.stock,
    required this.price,
    required this.item,
    required this.license,
    required this.dp,
    required this.keys,
    required this.values,
  });

  factory The200.fromJson(Map<String, dynamic> json) => The200(
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
    "item": item.toJson(),
    "license": license,
    "dp": dp,
    "keys": keys,
    "values": values,
  };
}

class Item {
  int id;
  int userId;
  String slug;
  String name;
  String photo;
  String size;
  String sizeQty;
  String sizePrice;
  String color;
  int price;
  int stock;
  String type;
  dynamic file;
  dynamic link;
  String license;
  String licenseQty;
  dynamic measure;
  String wholeSellQty;
  String wholeSellDiscount;
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
