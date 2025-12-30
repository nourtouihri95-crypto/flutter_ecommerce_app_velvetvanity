import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  CartProvider() {
    _loadCart();
  }

  void addToCart(Product product) {
    final index =
        _items.indexWhere((item) => item.product.name == product.name);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }

    _saveCart();
    notifyListeners();
  }
  
  void increaseQuantity(CartItem item) {
    item.quantity++;
    _saveCart();
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    _saveCart();
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    _saveCart();
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _items.map((e) => e.toJson()).toList();
    prefs.setString('cart', jsonEncode(data));
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('cart');

    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      _items.clear();
      _items.addAll(
        decoded.map((e) => CartItem.fromJson(e)),
      );
      notifyListeners();
    }
  }
}

