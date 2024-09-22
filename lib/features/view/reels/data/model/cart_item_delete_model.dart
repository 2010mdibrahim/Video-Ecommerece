class CartItemDeleteModel {
  String? s0;
  int? i1;
  String? s3;
  String? cart;

  CartItemDeleteModel({this.s0, this.i1, this.s3, this.cart});

  CartItemDeleteModel.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    i1 = json['1'];
    s3 = json['3'];
    cart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.i1;
    data['3'] = this.s3;
    data['cart'] = this.cart;
    return data;
  }
}
