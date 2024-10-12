class MyWalletModel {
  int? status;
  String? message;
  int? balance;
  List<WalletHistory>? walletHistory;

  MyWalletModel({this.status, this.message, this.balance, this.walletHistory});

  MyWalletModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    balance = json['balance'];
    if (json['wallet_history'] != null) {
      walletHistory = <WalletHistory>[];
      json['wallet_history'].forEach((v) {
        walletHistory!.add(new WalletHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['balance'] = this.balance;
    if (this.walletHistory != null) {
      data['wallet_history'] =
          this.walletHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletHistory {
  int? id;
  int? userId;
  int? orderId;
  int? productId;
  int? videoId;
  int? qty;
  int? pricePer;
  int? totalPrice;
  int? commissionPer;
  int? totalCommission;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? photo;
  String? productName;
  String? productThumbnail;

  WalletHistory(
      {this.id,
        this.userId,
        this.orderId,
        this.productId,
        this.videoId,
        this.qty,
        this.pricePer,
        this.totalPrice,
        this.commissionPer,
        this.totalCommission,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.photo,
        this.productName,
        this.productThumbnail});

  WalletHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    videoId = json['video_id'];
    qty = json['qty'];
    pricePer = json['price_per'];
    totalPrice = json['total_price'];
    commissionPer = json['commission_per'];
    totalCommission = json['total_commission'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    photo = json['photo'];
    productName = json['product_name'];
    productThumbnail = json['product_thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['video_id'] = this.videoId;
    data['qty'] = this.qty;
    data['price_per'] = this.pricePer;
    data['total_price'] = this.totalPrice;
    data['commission_per'] = this.commissionPer;
    data['total_commission'] = this.totalCommission;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['product_name'] = this.productName;
    data['product_thumbnail'] = this.productThumbnail;
    return data;
  }
}
