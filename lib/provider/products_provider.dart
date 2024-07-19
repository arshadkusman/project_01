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
    for (var product in _products) {
      print('Checking product with ID: ${product.id}');
      if (product.id == id) {
        print('Product found: $product');
        return product;
      }
    }
    print('Product not found for Id: $id');
    return null;
  }
}
