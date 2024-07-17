import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;
  bool didFetchProducts = false;

  Future<void> fetchProducts(BuildContext context) async {
    if (didFetchProducts) return;
    try {
      final jsonString =
          await DefaultAssetBundle.of(context).loadString("products.json");
      final jsonData = jsonDecode(jsonString);
      final List<dynamic> productsList = jsonData['products'];
      _products = productsList.map((json) => Product.fromJson(json)).toList();

      print('Products fetched successfully: $_products');
      print('Product IDs: ${_products.map((product) => product.id).toList()}');

      didFetchProducts = true;
      Future.delayed(Duration.zero, notifyListeners);
    } catch (error) {
      print('Error loading products: $error');
      didFetchProducts = false;
      notifyListeners();
    }
  }

  Product? findById(int id) {
    if (_products.isEmpty) {
      print('Product list is empty, cannot find product with ID: $id');
      return null;
    }

    print(
        'Searching for product with ID: $id in products: ${_products.map((p) => p.id).toList()}');

    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      print('Product not found for ID: $id');
      return null;
    }
  }
}
