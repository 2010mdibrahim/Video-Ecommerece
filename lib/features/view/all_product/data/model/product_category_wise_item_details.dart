class ProductCategoryWiseItemDetails {
  ItemDetail? itemDetail;
  Curr? curr;
  List<Vendors>? vendors;

  ProductCategoryWiseItemDetails({this.itemDetail, this.curr, this.vendors});

  ProductCategoryWiseItemDetails.fromJson(Map<String, dynamic> json) {
    itemDetail = json['item_detail'] != null
        ? new ItemDetail.fromJson(json['item_detail'])
        : null;
    curr = json['curr'] != null ? new Curr.fromJson(json['curr']) : null;
    if (json['vendors'] != null) {
      vendors = <Vendors>[];
      json['vendors'].forEach((v) {
        vendors!.add(new Vendors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemDetail != null) {
      data['item_detail'] = this.itemDetail!.toJson();
    }
    if (this.curr != null) {
      data['curr'] = this.curr!.toJson();
    }
    if (this.vendors != null) {
      data['vendors'] = this.vendors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemDetail {
  var id;
  var sku;
  var productType;
  var affiliateLink;
  var userId;
  var categoryId;
  var subcategoryId;
  var childcategoryId;
  var attributes;
  var name;
  var slug;
  var photo;
  var thumbnail;
  var file;
  var size;
  dynamic sizeQty;
  dynamic sizePrice;
  dynamic color;
  dynamic price;
  var previousPrice;
  var details;
  var stock;
  var policy;
  var status;
  var views;
  var tags;
  var features;
  var colors;
  var productCondition;
  var ship;
  var isMeta;
  var metaTag;
  var metaDescription;
  var youtube;
  var type;
  var license;
  var licenseQty;
  var link;
  var platform;
  var region;
  var licenceType;
  var measure;
  var featured;
  var best;
  var top;
  var hot;
  var latest;
  var big;
  var trending;
  var sale;
  var createdAt;
  var updatedAt;
  var isDiscount;
  var discountDate;
  var wholeSellQty;
  var wholeSellDiscount;
  var isCatalog;
  var catalogId;

  ItemDetail(
      {this.id,
        this.sku,
        this.productType,
        this.affiliateLink,
        this.userId,
        this.categoryId,
        this.subcategoryId,
        this.childcategoryId,
        this.attributes,
        this.name,
        this.slug,
        this.photo,
        this.thumbnail,
        this.file,
        this.size,
        this.sizeQty,
        this.sizePrice,
        this.color,
        this.price,
        this.previousPrice,
        this.details,
        this.stock,
        this.policy,
        this.status,
        this.views,
        this.tags,
        this.features,
        this.colors,
        this.productCondition,
        this.ship,
        this.isMeta,
        this.metaTag,
        this.metaDescription,
        this.youtube,
        this.type,
        this.license,
        this.licenseQty,
        this.link,
        this.platform,
        this.region,
        this.licenceType,
        this.measure,
        this.featured,
        this.best,
        this.top,
        this.hot,
        this.latest,
        this.big,
        this.trending,
        this.sale,
        this.createdAt,
        this.updatedAt,
        this.isDiscount,
        this.discountDate,
        this.wholeSellQty,
        this.wholeSellDiscount,
        this.isCatalog,
        this.catalogId});

  ItemDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    productType = json['product_type'];
    affiliateLink = json['affiliate_link'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    childcategoryId = json['childcategory_id'];
    attributes = json['attributes'];
    name = json['name'];
    slug = json['slug'];
    photo = json['photo'];
    thumbnail = json['thumbnail'];
    file = json['file'];
    size = json['size'];
    sizeQty = json['size_qty'];
    sizePrice = json['size_price'];
    color = json['color'];
    price = json['price'];
    previousPrice = json['previous_price'];
    details = json['details'];
    stock = json['stock'];
    policy = json['policy'];
    status = json['status'];
    views = json['views'];
    tags = json['tags'];
    features = json['features'];
    colors = json['colors'];
    productCondition = json['product_condition'];
    ship = json['ship'];
    isMeta = json['is_meta'];
    metaTag = json['meta_tag'];
    metaDescription = json['meta_description'];
    youtube = json['youtube'];
    type = json['type'];
    license = json['license'];
    licenseQty = json['license_qty'];
    link = json['link'];
    platform = json['platform'];
    region = json['region'];
    licenceType = json['licence_type'];
    measure = json['measure'];
    featured = json['featured'];
    best = json['best'];
    top = json['top'];
    hot = json['hot'];
    latest = json['latest'];
    big = json['big'];
    trending = json['trending'];
    sale = json['sale'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDiscount = json['is_discount'];
    discountDate = json['discount_date'];
    wholeSellQty = json['whole_sell_qty'];
    wholeSellDiscount = json['whole_sell_discount'];
    isCatalog = json['is_catalog'];
    catalogId = json['catalog_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['product_type'] = this.productType;
    data['affiliate_link'] = this.affiliateLink;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['childcategory_id'] = this.childcategoryId;
    data['attributes'] = this.attributes;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['photo'] = this.photo;
    data['thumbnail'] = this.thumbnail;
    data['file'] = this.file;
    data['size'] = this.size;
    data['size_qty'] = this.sizeQty;
    data['size_price'] = this.sizePrice;
    data['color'] = this.color;
    data['price'] = this.price;
    data['previous_price'] = this.previousPrice;
    data['details'] = this.details;
    data['stock'] = this.stock;
    data['policy'] = this.policy;
    data['status'] = this.status;
    data['views'] = this.views;
    data['tags'] = this.tags;
    data['features'] = this.features;
    data['colors'] = this.colors;
    data['product_condition'] = this.productCondition;
    data['ship'] = this.ship;
    data['is_meta'] = this.isMeta;
    data['meta_tag'] = this.metaTag;
    data['meta_description'] = this.metaDescription;
    data['youtube'] = this.youtube;
    data['type'] = this.type;
    data['license'] = this.license;
    data['license_qty'] = this.licenseQty;
    data['link'] = this.link;
    data['platform'] = this.platform;
    data['region'] = this.region;
    data['licence_type'] = this.licenceType;
    data['measure'] = this.measure;
    data['featured'] = this.featured;
    data['best'] = this.best;
    data['top'] = this.top;
    data['hot'] = this.hot;
    data['latest'] = this.latest;
    data['big'] = this.big;
    data['trending'] = this.trending;
    data['sale'] = this.sale;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_discount'] = this.isDiscount;
    data['discount_date'] = this.discountDate;
    data['whole_sell_qty'] = this.wholeSellQty;
    data['whole_sell_discount'] = this.wholeSellDiscount;
    data['is_catalog'] = this.isCatalog;
    data['catalog_id'] = this.catalogId;
    return data;
  }
}

class Curr {
  var id;
  var name;
  var sign;
  var value;
  var isDefault;

  Curr({this.id, this.name, this.sign, this.value, this.isDefault});

  Curr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sign = json['sign'];
    value = json['value'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sign'] = this.sign;
    data['value'] = this.value;
    data['is_default'] = this.isDefault;
    return data;
  }
}

class Vendors {
  var id;
  var sku;
  var productType;
  var affiliateLink;
  var userId;
  var categoryId;
  var subcategoryId;
  var childcategoryId;
  var attributes;
  var name;
  var slug;
  var photo;
  var thumbnail;
  var file;
  var size;
  var sizeQty;
  var sizePrice;
  var color;
  var price;
  var previousPrice;
  var details;
  var stock;
  var policy;
  var status;
  var views;
  var tags;
  var features;
  var colors;
  var productCondition;
  var ship;
  var isMeta;
  var metaTag;
  var metaDescription;
  var youtube;
  var type;
  var license;
  var licenseQty;
  var link;
  var platform;
  var region;
  var licenceType;
  var measure;
  var featured;
  var best;
  var top;
  var hot;
  var latest;
  var big;
  var trending;
  var sale;
  var createdAt;
  var updatedAt;
  var isDiscount;
  var discountDate;
  var wholeSellQty;
  var wholeSellDiscount;
  var isCatalog;
  var catalogId;

  Vendors(
      {this.id,
        this.sku,
        this.productType,
        this.affiliateLink,
        this.userId,
        this.categoryId,
        this.subcategoryId,
        this.childcategoryId,
        this.attributes,
        this.name,
        this.slug,
        this.photo,
        this.thumbnail,
        this.file,
        this.size,
        this.sizeQty,
        this.sizePrice,
        this.color,
        this.price,
        this.previousPrice,
        this.details,
        this.stock,
        this.policy,
        this.status,
        this.views,
        this.tags,
        this.features,
        this.colors,
        this.productCondition,
        this.ship,
        this.isMeta,
        this.metaTag,
        this.metaDescription,
        this.youtube,
        this.type,
        this.license,
        this.licenseQty,
        this.link,
        this.platform,
        this.region,
        this.licenceType,
        this.measure,
        this.featured,
        this.best,
        this.top,
        this.hot,
        this.latest,
        this.big,
        this.trending,
        this.sale,
        this.createdAt,
        this.updatedAt,
        this.isDiscount,
        this.discountDate,
        this.wholeSellQty,
        this.wholeSellDiscount,
        this.isCatalog,
        this.catalogId});

  Vendors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    productType = json['product_type'];
    affiliateLink = json['affiliate_link'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    childcategoryId = json['childcategory_id'];
    attributes = json['attributes'];
    name = json['name'];
    slug = json['slug'];
    photo = json['photo'];
    thumbnail = json['thumbnail'];
    file = json['file'];
    size = json['size'];
    sizeQty = json['size_qty'];
    sizePrice = json['size_price'];
    color = json['color'];
    price = json['price'];
    previousPrice = json['previous_price'];
    details = json['details'];
    stock = json['stock'];
    policy = json['policy'];
    status = json['status'];
    views = json['views'];
    tags = json['tags'];
    features = json['features'];
    colors = json['colors'];
    productCondition = json['product_condition'];
    ship = json['ship'];
    isMeta = json['is_meta'];
    metaTag = json['meta_tag'];
    metaDescription = json['meta_description'];
    youtube = json['youtube'];
    type = json['type'];
    license = json['license'];
    licenseQty = json['license_qty'];
    link = json['link'];
    platform = json['platform'];
    region = json['region'];
    licenceType = json['licence_type'];
    measure = json['measure'];
    featured = json['featured'];
    best = json['best'];
    top = json['top'];
    hot = json['hot'];
    latest = json['latest'];
    big = json['big'];
    trending = json['trending'];
    sale = json['sale'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDiscount = json['is_discount'];
    discountDate = json['discount_date'];
    wholeSellQty = json['whole_sell_qty'];
    wholeSellDiscount = json['whole_sell_discount'];
    isCatalog = json['is_catalog'];
    catalogId = json['catalog_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['product_type'] = this.productType;
    data['affiliate_link'] = this.affiliateLink;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['childcategory_id'] = this.childcategoryId;
    data['attributes'] = this.attributes;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['photo'] = this.photo;
    data['thumbnail'] = this.thumbnail;
    data['file'] = this.file;
    data['size'] = this.size;
    data['size_qty'] = this.sizeQty;
    data['size_price'] = this.sizePrice;
    data['color'] = this.color;
    data['price'] = this.price;
    data['previous_price'] = this.previousPrice;
    data['details'] = this.details;
    data['stock'] = this.stock;
    data['policy'] = this.policy;
    data['status'] = this.status;
    data['views'] = this.views;
    data['tags'] = this.tags;
    data['features'] = this.features;
    data['colors'] = this.colors;
    data['product_condition'] = this.productCondition;
    data['ship'] = this.ship;
    data['is_meta'] = this.isMeta;
    data['meta_tag'] = this.metaTag;
    data['meta_description'] = this.metaDescription;
    data['youtube'] = this.youtube;
    data['type'] = this.type;
    data['license'] = this.license;
    data['license_qty'] = this.licenseQty;
    data['link'] = this.link;
    data['platform'] = this.platform;
    data['region'] = this.region;
    data['licence_type'] = this.licenceType;
    data['measure'] = this.measure;
    data['featured'] = this.featured;
    data['best'] = this.best;
    data['top'] = this.top;
    data['hot'] = this.hot;
    data['latest'] = this.latest;
    data['big'] = this.big;
    data['trending'] = this.trending;
    data['sale'] = this.sale;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_discount'] = this.isDiscount;
    data['discount_date'] = this.discountDate;
    data['whole_sell_qty'] = this.wholeSellQty;
    data['whole_sell_discount'] = this.wholeSellDiscount;
    data['is_catalog'] = this.isCatalog;
    data['catalog_id'] = this.catalogId;
    return data;
  }
}
