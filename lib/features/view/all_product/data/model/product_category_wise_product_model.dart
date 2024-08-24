class ProductCategoryWiseProductModel {
  Products? products;
  var nextPage;
  int? currentPage;

  ProductCategoryWiseProductModel(
      {this.products, this.nextPage, this.currentPage});

  ProductCategoryWiseProductModel.fromJson(Map<String, dynamic> json) {
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
    nextPage = json['nextPage'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    data['nextPage'] = this.nextPage;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class Products {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Products(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Products.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? name;
  String? slug;
  String? features;
  String? colors;
  String? thumbnail;
  int? price;
  int? previousPrice;
  String? attributes;
  String? size;
  String? sizePrice;
  Null? discountDate;

  Data(
      {this.id,
        this.userId,
        this.name,
        this.slug,
        this.features,
        this.colors,
        this.thumbnail,
        this.price,
        this.previousPrice,
        this.attributes,
        this.size,
        this.sizePrice,
        this.discountDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    slug = json['slug'];
    features = json['features'];
    colors = json['colors'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    previousPrice = json['previous_price'];
    attributes = json['attributes'];
    size = json['size'];
    sizePrice = json['size_price'];
    discountDate = json['discount_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['features'] = this.features;
    data['colors'] = this.colors;
    data['thumbnail'] = this.thumbnail;
    data['price'] = this.price;
    data['previous_price'] = this.previousPrice;
    data['attributes'] = this.attributes;
    data['size'] = this.size;
    data['size_price'] = this.sizePrice;
    data['discount_date'] = this.discountDate;
    return data;
  }
}
