class AddToCartModel {
  int? i0;
  int? qty;
  int? sizeKey;
  String? sizeQty;
  String? sizePrice;
  String? size;
  String? color;
  int? stock;
  int? price;
  Item? item;
  String? license;
  String? dp;
  String? keys;
  String? values;
  String? cart;
  int? priceSum;
  int? productCountIncrement;

  AddToCartModel(
      {this.i0,
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
        this.cart,
      this.priceSum,
        this.productCountIncrement
      });

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    qty = json['qty'];
    sizeKey = json['size_key'];
    sizeQty = json['size_qty'];
    sizePrice = json['size_price'];
    size = json['size'];
    color = json['color'];
    stock = json['stock'];
    price = json['price'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    license = json['license'];
    dp = json['dp'];
    keys = json['keys'];
    values = json['values'];
    cart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.i0;
    data['qty'] = this.qty;
    data['size_key'] = this.sizeKey;
    data['size_qty'] = this.sizeQty;
    data['size_price'] = this.sizePrice;
    data['size'] = this.size;
    data['color'] = this.color;
    data['stock'] = this.stock;
    data['price'] = this.price;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    data['license'] = this.license;
    data['dp'] = this.dp;
    data['keys'] = this.keys;
    data['values'] = this.values;
    data['cart'] = this.cart;
    return data;
  }
}

class Item {
  int? id;
  int? userId;
  String? slug;
  String? name;
  String? photo;
  String? size;
  String? sizeQty;
  String? sizePrice;
  String? color;
  int? price;
  int? stock;
  String? type;
  Null? file;
  Null? link;
  String? license;
  String? licenseQty;
  Null? measure;
  String? wholeSellQty;
  String? wholeSellDiscount;
  Null? attributes;

  Item(
      {this.id,
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
        this.attributes});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    slug = json['slug'];
    name = json['name'];
    photo = json['photo'];
    size = json['size'];
    sizeQty = json['size_qty'];
    sizePrice = json['size_price'];
    color = json['color'];
    price = json['price'];
    stock = json['stock'];
    type = json['type'];
    file = json['file'];
    link = json['link'];
    license = json['license'];
    licenseQty = json['license_qty'];
    measure = json['measure'];
    wholeSellQty = json['whole_sell_qty'];
    wholeSellDiscount = json['whole_sell_discount'];
    attributes = json['attributes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['size'] = this.size;
    data['size_qty'] = this.sizeQty;
    data['size_price'] = this.sizePrice;
    data['color'] = this.color;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['type'] = this.type;
    data['file'] = this.file;
    data['link'] = this.link;
    data['license'] = this.license;
    data['license_qty'] = this.licenseQty;
    data['measure'] = this.measure;
    data['whole_sell_qty'] = this.wholeSellQty;
    data['whole_sell_discount'] = this.wholeSellDiscount;
    data['attributes'] = this.attributes;
    return data;
  }
}
