import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<int, CartItem> _items = {};

  CartProvider() {
    loadCart();
  }

  Map<int, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  Future<void> addItem(
      int productId, double price, String title, List<String> images) async {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
          images: existingCartItem.images,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          quantity: 1,
          price: price,
          images: images,
        ),
      );
    }
    await _saveCart();
    notifyListeners();
  }

  Future<void> updateItemQuantity(int productId, int newQuantity) async {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: newQuantity,
          price: existingCartItem.price,
          images: existingCartItem.images,
        ),
      );
      await _saveCart();
      notifyListeners();
    }
  }

  Future<void> removeItem(int productId) async {
    _items.remove(productId);
    await _saveCart();
    notifyListeners();
  }

  Future<void> clear() async {
    _items = {};
    await _saveCart();
    notifyListeners();
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData =
        _items.map((key, value) => MapEntry(key.toString(), value.toJson()));
    prefs.setString('cartItems', json.encode(cartData));
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('cartItems')) {
      final cartData =
          json.decode(prefs.getString('cartItems')!) as Map<String, dynamic>;
      _items = cartData.map((key, value) => MapEntry(
            int.parse(key),
            CartItem.fromJson(value),
          ));
      notifyListeners();
    }
  }
}
