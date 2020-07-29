import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({this.id, this.title, this.quantity = 0, this.price});
}

class Cart with ChangeNotifier {
  // final String authToken;
  // Cart(this.authToken,this._items);

  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items["productId"].quantity > 1) {
      print("if called");
      _items.update(
          productId,
          (exisitingCartitem) => CartItem(
              id: exisitingCartitem.id,
              quantity: exisitingCartitem.quantity - 1,
              title: exisitingCartitem.title,
              price: exisitingCartitem.price));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  int get len => _items == null ? 0 : _items.length;
}
