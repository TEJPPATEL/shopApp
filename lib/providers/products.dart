import 'dart:convert';

import 'package:ShopApp/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Products with ChangeNotifier {
  // final String authToken;
  // Products(this.authToken , this._items);

  List<Product> _items = [
    Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'),
    Product(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        imageUrl:
            'https://cdn2.propercloth.com/pic_products_tc/4df14c550e48f66fed7cd1642f3eeba0_page_extra.jpg'),
    Product(
        id: 'p3',
        title: 'Yellow Scarf',
        description: 'warm and cozy - exactly what you need in Winter!',
        price: 19.99,
        imageUrl:
            'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'),
    Product(
        id: 'p4',
        title: 'A pan',
        description: 'Prepare any meal you want.',
        price: 49.99,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/1/14/Cast-Iron-Pan.jpg'),
  ];

  bool isShowFavourite = false;

  List<Product> get items => [..._items];

  Product findById(String id) => _items.firstWhere((item) => item.id == id);

  List<Product> get favouriteItems {
    return _items.where((productitem) => productitem.isFavourite).toList();
  }

  // showOnlyFavourite() {
  //   isShowFavourite  = true;
  //   notifyListeners();
  // }
  // showAll() {
  //   isShowFavourite = false;
  //   notifyListeners();
  // }

  // List<Product> get items {
  //   if(isShowFavourite)
  //     return _items.where((element) => element.isFavourite).toList();

  //   else
  //    return  [..._items];
  // }

  Future<void> addProduct(Product product) {
    const url = "https://flutter-firebase-94975.firebaseio.com/products.json";

    // http.post("https://flutter-firebase-94975.firebaseio.com/products.json",body: json.encode({"name": 'tej' , 'sname' : "patel"})).then((value) => print(value.toString()));
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);
    return http
        .post(
      url,
      body: json.encode({
        "id": newProduct.id,
        "title": newProduct.title,
        "price": newProduct.price,
        "description": newProduct.description,
        "imageUrl": newProduct.imageUrl,
        "isFavourite": newProduct.isFavourite,
      }),
    )
        .then((response) {
      _items.insert(0, newProduct);
      print(_items);
      print(newProduct);
      notifyListeners();
    }).catchError((error) => throw error);

    // _items.add(newProduct);
    // _items.insert(0, newProduct);
    // print(_items);

    // print(newProduct);
    // notifyListeners();
  }

  void updateProduct(String id, Product product) {
    var index = _items.indexWhere((element) => element.id == id);
    _items[index] = product;
    notifyListeners();
  }

  Future<void> fetchandSetProduct() async {
    final response = await http
        .get("https://flutter-firebase-94975.firebaseio.com/products.json");
    Map<String, dynamic> extractedData = json.decode(response.body);
    List<Product> loadedProduct = [];
    // extractedData.forEach((prodId, productData) {
    //   loadedProduct.add(Product(
    //       id: prodId.toString(),
    //       title: productData["title"],
    //       price: productData["price"],
    //       imageUrl: productData["imageUrl"],
    //       description: productData["description"],
    //       isFavourite: productData["isFavourite"]));
    // });
    extractedData.forEach((prodId, prodData) {
      loadedProduct.add(Product(
          id: prodData["id"],
          title: prodData["title"],
          description: prodData["description"],
          price: prodData["price"],
          imageUrl: prodData["imageUrl"]));
    });
  }
}
