class UserInformationModel {
  int? id;
  String? name;
  var photo;
  var zip;
  var city;
  var country;
  String? address;
  String? phone;
  var fax;
  String? email;
  String? apiToken;
  String? createdAt;
  String? updatedAt;
  int? isProvider;
  int? status;
  String? verificationLink;
  String? emailVerified;
  String? affilateCode;
  int? affilateIncome;
  var shopName;
  var ownerName;
  var shopNumber;
  var shopAddress;
  var regNumber;
  var shopMessage;
  var shopDetails;
  String? shopImage;
  var fUrl;
  var gUrl;
  var tUrl;
  var lUrl;
  int? isVendor;
  int? fCheck;
  int? gCheck;
  int? tCheck;
  int? lCheck;
  int? mailSent;
  int? shippingCost;
  int? currentBalance;
  Null date;
  int? ban;

  UserInformationModel(
      {this.id,
        this.name,
        this.photo,
        this.zip,
        this.city,
        this.country,
        this.address,
        this.phone,
        this.fax,
        this.email,
        this.apiToken,
        this.createdAt,
        this.updatedAt,
        this.isProvider,
        this.status,
        this.verificationLink,
        this.emailVerified,
        this.affilateCode,
        this.affilateIncome,
        this.shopName,
        this.ownerName,
        this.shopNumber,
        this.shopAddress,
        this.regNumber,
        this.shopMessage,
        this.shopDetails,
        this.shopImage,
        this.fUrl,
        this.gUrl,
        this.tUrl,
        this.lUrl,
        this.isVendor,
        this.fCheck,
        this.gCheck,
        this.tCheck,
        this.lCheck,
        this.mailSent,
        this.shippingCost,
        this.currentBalance,
        this.date,
        this.ban});

  UserInformationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    zip = json['zip'];
    city = json['city'];
    country = json['country'];
    address = json['address'];
    phone = json['phone'];
    fax = json['fax'];
    email = json['email'];
    apiToken = json['api_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isProvider = json['is_provider'];
    status = json['status'];
    verificationLink = json['verification_link'];
    emailVerified = json['email_verified'];
    affilateCode = json['affilate_code'];
    affilateIncome = json['affilate_income'];
    shopName = json['shop_name'];
    ownerName = json['owner_name'];
    shopNumber = json['shop_number'];
    shopAddress = json['shop_address'];
    regNumber = json['reg_number'];
    shopMessage = json['shop_message'];
    shopDetails = json['shop_details'];
    shopImage = json['shop_image'];
    fUrl = json['f_url'];
    gUrl = json['g_url'];
    tUrl = json['t_url'];
    lUrl = json['l_url'];
    isVendor = json['is_vendor'];
    fCheck = json['f_check'];
    gCheck = json['g_check'];
    tCheck = json['t_check'];
    lCheck = json['l_check'];
    mailSent = json['mail_sent'];
    shippingCost = json['shipping_cost'];
    currentBalance = json['current_balance'];
    date = json['date'];
    ban = json['ban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['zip'] = zip;
    data['city'] = city;
    data['country'] = country;
    data['address'] = address;
    data['phone'] = phone;
    data['fax'] = fax;
    data['email'] = email;
    data['api_token'] = apiToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_provider'] = isProvider;
    data['status'] = status;
    data['verification_link'] = verificationLink;
    data['email_verified'] = emailVerified;
    data['affilate_code'] = affilateCode;
    data['affilate_income'] = affilateIncome;
    data['shop_name'] = shopName;
    data['owner_name'] = ownerName;
    data['shop_number'] = shopNumber;
    data['shop_address'] = shopAddress;
    data['reg_number'] = regNumber;
    data['shop_message'] = shopMessage;
    data['shop_details'] = shopDetails;
    data['shop_image'] = shopImage;
    data['f_url'] = fUrl;
    data['g_url'] = gUrl;
    data['t_url'] = tUrl;
    data['l_url'] = lUrl;
    data['is_vendor'] = isVendor;
    data['f_check'] = fCheck;
    data['g_check'] = gCheck;
    data['t_check'] = tCheck;
    data['l_check'] = lCheck;
    data['mail_sent'] = mailSent;
    data['shipping_cost'] = shippingCost;
    data['current_balance'] = currentBalance;
    data['date'] = date;
    data['ban'] = ban;
    return data;
  }
}
