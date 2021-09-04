import 'package:flutter/material.dart';

class Product {
  int? id, isFavourite = 0, isPopular = 0, colors = 0, rating = 0;
  String? title, description, image, date, type, category, barcode;
  double? price, priceBefore;

  Product({
    this.id,
    this.image,
    this.colors,
    this.barcode,
    this.date,
    this.priceBefore,
    this.type,
    this.category,
    this.rating,
    this.isFavourite = 0,
    this.isPopular = 0,
    this.title,
    this.price,
    this.description,
  });

  Product.a(dynamic obj) {
    id = obj['id'];
    title = obj['name'];
    priceBefore = obj['priceBefore'];
    price = obj['price'];
    date = obj['date'].toString();
    barcode = obj['barcode'];
    description = obj['description'];
    image == [] ? image = obj['image'][0] : image = '';
    type = obj['type'].toString();
    (category == []) ? category = obj['category'][0] : category = '';
    rating = obj['rating'];
    isPopular = obj['isPopular'];
  }

  Product.fromMap(Map<String, dynamic> obj) {
    id = obj['id'];
    title = obj['title'];
    priceBefore = obj['priceBefore'].toDouble();
    price = obj['price'].toDouble();
    date = obj['date'];
    barcode = obj['barcode'];
    description = obj['description'];
    image = obj['image'];
    type = obj['type'];
    category = obj['category'];
    rating = obj['rating'].toInt();
    isPopular = obj['isPopular'];
  }

  Map<String, dynamic> toMaps() => {
        if (id != null) 'id': id,
        'title': title,
        'price': price,
        'priceBefore': priceBefore,
        'date': date,
        'barcode': barcode,
        'description': description,
        'image': image,
        'type': type,
        'category': category,
        'rating': rating,
        'isPopular': isPopular,
      };
}

// Our demo Products

List<Product> demoProducts = [];
