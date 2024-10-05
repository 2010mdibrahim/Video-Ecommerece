class ProductCategoryWiseProductModel {
  Products? products;
  var nextPage;
  int? currentPage;

  ProductCategoryWiseProductModel(
      {this.products, this.nextPage, this.currentPage});

  ProductCategoryWiseProductModel.fromJson(Map<String, dynamic> json) {
    products = json['products'] != null
        ? Products.fromJson(json['products'])
        : null;
    nextPage = json['nextPage'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.toJson();
    }
    data['nextPage'] = nextPage;
    data['currentPage'] = currentPage;
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
  var nextPageUrl;
  String? path;
  int? perPage;
  var prevPageUrl;
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
        data!.add(Data.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? name;
  String? slug;
  String? features;
  dynamic colors;
  String? thumbnail;
  int? price;
  int? previousPrice;
  String? attributes;
  dynamic size;
  dynamic sizePrice;
  var discountDate;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['slug'] = slug;
    data['features'] = features;
    data['colors'] = colors;
    data['thumbnail'] = thumbnail;
    data['price'] = price;
    data['previous_price'] = previousPrice;
    data['attributes'] = attributes;
    data['size'] = size;
    data['size_price'] = sizePrice;
    data['discount_date'] = discountDate;
    return data;
  }
}
