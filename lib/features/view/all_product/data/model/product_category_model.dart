class ProductCategoryModel {
  int? id;
  String? name;
  String? slug;
  int? status;
  String? photo;
  int? isFeatured;
  String? image;
  List<Subs>? subs;

  ProductCategoryModel(
      {this.id,
        this.name,
        this.slug,
        this.status,
        this.photo,
        this.isFeatured,
        this.image,
        this.subs});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    status = json['status'];
    photo = json['photo'];
    isFeatured = json['is_featured'];
    image = json['image'];
    if (json['subs'] != null) {
      subs = <Subs>[];
      json['subs'].forEach((v) {
        subs!.add(new Subs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['is_featured'] = this.isFeatured;
    data['image'] = this.image;
    if (this.subs != null) {
      data['subs'] = this.subs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subs {
  int? id;
  int? categoryId;
  String? name;
  String? slug;
  int? status;
  List<Childs>? childs;

  Subs(
      {this.id,
        this.categoryId,
        this.name,
        this.slug,
        this.status,
        this.childs});

  Subs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    slug = json['slug'];
    status = json['status'];
    if (json['childs'] != null) {
      childs = <Childs>[];
      json['childs'].forEach((v) {
        childs!.add(new Childs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['status'] = this.status;
    if (this.childs != null) {
      data['childs'] = this.childs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Childs {
  int? id;
  int? subcategoryId;
  String? name;
  String? slug;
  int? status;

  Childs({this.id, this.subcategoryId, this.name, this.slug, this.status});

  Childs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcategoryId = json['subcategory_id'];
    name = json['name'];
    slug = json['slug'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subcategory_id'] = this.subcategoryId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['status'] = this.status;
    return data;
  }
}
