class CashonDeliveryModel {
  int? status;
  String? message;
  Null? cart;
  Order? order;

  CashonDeliveryModel({this.status, this.message, this.cart, this.order});

  CashonDeliveryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cart = json['cart'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['cart'] = this.cart;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Order {
  int? userId;
  String? cart;
  String? totalQty;
  int? payAmount;
  String? method;
  String? shipping;
  String? pickupLocation;
  String? customerEmail;
  String? customerName;
  String? shippingCost;
  String? packingCost;
  String? tax;
  String? customerPhone;
  String? orderNumber;
  String? customerAddress;
  String? customerCountry;
  String? customerCity;
  String? customerZip;
  String? shippingEmail;
  String? shippingName;
  String? shippingPhone;
  String? shippingAddress;
  String? shippingCountry;
  String? shippingCity;
  String? shippingZip;
  String? orderNote;
  String? couponCode;
  String? couponDiscount;
  String? dp;
  String? paymentStatus;
  String? currencySign;
  int? currencyValue;
  String? vendorShippingId;
  String? vendorPackingId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Order(
      {this.userId,
        this.cart,
        this.totalQty,
        this.payAmount,
        this.method,
        this.shipping,
        this.pickupLocation,
        this.customerEmail,
        this.customerName,
        this.shippingCost,
        this.packingCost,
        this.tax,
        this.customerPhone,
        this.orderNumber,
        this.customerAddress,
        this.customerCountry,
        this.customerCity,
        this.customerZip,
        this.shippingEmail,
        this.shippingName,
        this.shippingPhone,
        this.shippingAddress,
        this.shippingCountry,
        this.shippingCity,
        this.shippingZip,
        this.orderNote,
        this.couponCode,
        this.couponDiscount,
        this.dp,
        this.paymentStatus,
        this.currencySign,
        this.currencyValue,
        this.vendorShippingId,
        this.vendorPackingId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Order.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    cart = json['cart'];
    totalQty = json['totalQty'];
    payAmount = json['pay_amount'];
    method = json['method'];
    shipping = json['shipping'];
    pickupLocation = json['pickup_location'];
    customerEmail = json['customer_email'];
    customerName = json['customer_name'];
    shippingCost = json['shipping_cost'];
    packingCost = json['packing_cost'];
    tax = json['tax'];
    customerPhone = json['customer_phone'];
    orderNumber = json['order_number'];
    customerAddress = json['customer_address'];
    customerCountry = json['customer_country'];
    customerCity = json['customer_city'];
    customerZip = json['customer_zip'];
    shippingEmail = json['shipping_email'];
    shippingName = json['shipping_name'];
    shippingPhone = json['shipping_phone'];
    shippingAddress = json['shipping_address'];
    shippingCountry = json['shipping_country'];
    shippingCity = json['shipping_city'];
    shippingZip = json['shipping_zip'];
    orderNote = json['order_note'];
    couponCode = json['coupon_code'];
    couponDiscount = json['coupon_discount'];
    dp = json['dp'];
    paymentStatus = json['payment_status'];
    currencySign = json['currency_sign'];
    currencyValue = json['currency_value'];
    vendorShippingId = json['vendor_shipping_id'];
    vendorPackingId = json['vendor_packing_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['cart'] = this.cart;
    data['totalQty'] = this.totalQty;
    data['pay_amount'] = this.payAmount;
    data['method'] = this.method;
    data['shipping'] = this.shipping;
    data['pickup_location'] = this.pickupLocation;
    data['customer_email'] = this.customerEmail;
    data['customer_name'] = this.customerName;
    data['shipping_cost'] = this.shippingCost;
    data['packing_cost'] = this.packingCost;
    data['tax'] = this.tax;
    data['customer_phone'] = this.customerPhone;
    data['order_number'] = this.orderNumber;
    data['customer_address'] = this.customerAddress;
    data['customer_country'] = this.customerCountry;
    data['customer_city'] = this.customerCity;
    data['customer_zip'] = this.customerZip;
    data['shipping_email'] = this.shippingEmail;
    data['shipping_name'] = this.shippingName;
    data['shipping_phone'] = this.shippingPhone;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_country'] = this.shippingCountry;
    data['shipping_city'] = this.shippingCity;
    data['shipping_zip'] = this.shippingZip;
    data['order_note'] = this.orderNote;
    data['coupon_code'] = this.couponCode;
    data['coupon_discount'] = this.couponDiscount;
    data['dp'] = this.dp;
    data['payment_status'] = this.paymentStatus;
    data['currency_sign'] = this.currencySign;
    data['currency_value'] = this.currencyValue;
    data['vendor_shipping_id'] = this.vendorShippingId;
    data['vendor_packing_id'] = this.vendorPackingId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
