// class HomeModel {
//   bool? status;
//   HomeDataModel? data;
//   HomeModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = HomeDataModel.fromJson(json['data']);
//   }
// }
//
// class HomeDataModel {
//   List<BannerModel> banners = [];
//   List<ProductModel> products = [];
//   HomeDataModel.fromJson(Map<String, dynamic> json) {
//     json['banners'].forEach((element) {
//       banners.add(element);
//     });
//     json['products'].forEach((element) {
//       products.add(element);
//     });
//   }
// }
//
// class BannerModel {
//   int? id;
//   String? image;
//   BannerModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//   }
// }
//
// class ProductModel {
//   int? id;
//   dynamic price;
//   dynamic old_price;
//   dynamic discount;
//   String? image;
//   String? name;
//   bool? in_favorites;
//   bool? in_cart;
//   ProductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     old_price = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     in_favorites = json['in_favorites'];
//     in_cart = json['in_cart'];
//   }
// }
class HomeModel {
  bool? status;

  HomeDataModel? data;

  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data =
        json['data'] != null ? new HomeDataModel.fromJson(json['data']) : null;
  }
}

class HomeDataModel {
  List<Banners>? banners;
  List<Products>? products;
  String? ad;

  HomeDataModel({this.banners, this.products, this.ad});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    ad = json['ad'];
  }
}

class Banners {
  int? id;
  String? image;

  Banners({this.id, this.image});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Products(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description,
      this.images,
      this.inFavorites,
      this.inCart});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
