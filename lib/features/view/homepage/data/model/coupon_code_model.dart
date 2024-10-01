class CouponCodeModel {
  double? totalPrice;
  String? existCode;
  double? couponDiscount;
  int? couponId;
  String? couponPercentage;
  int? status;

  CouponCodeModel(
      {this.totalPrice,
        this.existCode,
        this.couponDiscount,
        this.couponId,
        this.couponPercentage,
        this.status});

  CouponCodeModel.fromJson(Map<String, dynamic> json) {
    totalPrice = json['totalPrice'];
    existCode = json['exist_code'];
    couponDiscount = json['coupon_discount'];
    couponId = json['coupon_id'];
    couponPercentage = json['coupon_percentage'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPrice'] = this.totalPrice;
    data['exist_code'] = this.existCode;
    data['coupon_discount'] = this.couponDiscount;
    data['coupon_id'] = this.couponId;
    data['coupon_percentage'] = this.couponPercentage;
    data['status'] = this.status;
    return data;
  }
}
