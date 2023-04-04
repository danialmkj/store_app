// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.sliders,
    required this.banners,
    required this.categories,
    required this.suggestionProducts,
    required this.nearShops,
  });

  List<Slider> sliders;
  List<Banner> banners;
  List<CategoryElement> categories;
  List<SuggestionProduct> suggestionProducts;
  List<NearShops>? nearShops;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sliders:
            List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
        banners:
            List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
        categories: List<CategoryElement>.from(
            json["categories"].map((x) => CategoryElement.fromJson(x))),
        suggestionProducts: List<SuggestionProduct>.from(
            json["suggestionProducts"]
                .map((x) => SuggestionProduct.fromJson(x))),
        nearShops: List<NearShops>.from(
            json["nearShops"].map((x) => NearShops.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "suggestionProducts":
            List<dynamic>.from(suggestionProducts.map((x) => x.toJson())),
        "nearShops": List<dynamic>.from(nearShops!.map((x) => x.toJson())),
      };
}

class Banner {
  Banner({
    required this.sizeClass,
    required this.location,
    required this.image,
    this.link,
    this.priority,
    required this.categoryId,
    required this.updatedAt,
  });

  String sizeClass;
  String location;
  String image;
  String? link;
  int? priority;
  int categoryId;
  int updatedAt;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        sizeClass: json["sizeClass"],
        location: json["location"],
        image: json["image"],
        link: json["link"],
        priority: json["priority"],
        categoryId: json["category_id"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "sizeClass": sizeClass,
        "location": location,
        "image": image,
        "link": link,
        "priority": priority,
        "category_id": categoryId,
        "updated_at": updatedAt,
      };
}

class CategoryElement {
  CategoryElement({
    required this.id,
    required this.title,
    required this.img,
    required this.icon,
    this.childs,
  });

  int id;
  String title;
  String img;
  String icon;
  List<CategoryElement>? childs;

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json["id"],
        title: json["title"],
        img: json["img"],
        icon: json["icon"],
        childs: json["childs"] == null
            ? []
            : List<CategoryElement>.from(
                json["childs"]!.map((x) => CategoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "img": img,
        "icon": icon,
        "childs": childs == null
            ? []
            : List<dynamic>.from(childs!.map((x) => x.toJson())),
      };
}

class Slider {
  Slider({
    required this.img,
    this.link,
    required this.updatedAt,
  });

  String img;
  dynamic link;
  int updatedAt;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        img: json["img"],
        link: json["link"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "link": link,
        "updated_at": updatedAt,
      };
}

class SuggestionProduct {
  SuggestionProduct({
    required this.title,
    required this.location,
    required this.items,
    this.priority,
    required this.updatedAt,
    required this.image,
  });

  String title;
  String location;
  List<Item> items;
  dynamic priority;
  int updatedAt;
  String image;

  factory SuggestionProduct.fromJson(Map<String, dynamic> json) =>
      SuggestionProduct(
        title: json["title"],
        location: json["location"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        priority: json["priority"],
        updatedAt: json["updated_at"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "location": location,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "priority": priority,
        "updated_at": updatedAt,
        "image": image,
      };
}

class Item {
  Item({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.priceBeforDiscount,
    required this.discount,
    required this.callStatus,
    required this.specialDiscount,
    required this.star,
    required this.category,
  });

  int id;
  String image;
  String name;
  String price;
  String priceBeforDiscount;
  int discount;
  int callStatus;
  int specialDiscount;
  int star;
  CategoryEnum category;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        priceBeforDiscount: json["priceBeforDiscount"],
        discount: json["discount"],
        callStatus: json["callStatus"],
        specialDiscount: json["specialDiscount"],
        star: json["star"],
        category: categoryEnumValues.map[json["category"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "priceBeforDiscount": priceBeforDiscount,
        "discount": discount,
        "callStatus": callStatus,
        "specialDiscount": specialDiscount,
        "star": star,
        "category": categoryEnumValues.reverse[category],
      };
}

enum CategoryEnum { EMPTY, CATEGORY }

final categoryEnumValues = EnumValues(
    {"سبزیجات": CategoryEnum.CATEGORY, "مرکبات": CategoryEnum.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

/// id : 1
/// name : "مدیر"
/// companyName : "نیاز شاپ"
/// avatar : "https://shopbs.besenior.ir/images/image-not-found.png"
/// lat : null
/// long : null
class NearShops {
  NearShops({
    this.id,
    this.name,
    this.companyName,
    this.avatar,
    this.lat,
    this.long,
  });

  NearShops.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    companyName = json['companyName'];
    avatar = json['avatar'];
    lat = json['lat'];
    long = json['long'];
  }
  int? id;
  String? name;
  String? companyName;
  String? avatar;
  dynamic lat;
  dynamic long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['companyName'] = companyName;
    map['avatar'] = avatar;
    map['lat'] = lat;
    map['long'] = long;
    return map;
  }
}
