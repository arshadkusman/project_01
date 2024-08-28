import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_2/dio_service.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;
  bool didFetchProducts = false;

  final DioService _dioService = DioService();

  Future<void> fetchProducts() async {
    try {
      Response response =
          await _dioService.get('/users'); // Update with your API endpoint
      final List<dynamic> productsList = response.data;

      _products = productsList.map((json) => Product.fromJson(json)).toList();
      didFetchProducts = true;
      notifyListeners();
    } catch (error) {
      print('Error loading products: $error');
      throw Exception('Failed to load products: $error');
    }
  }

  Product? findById(int id) {
    for (var product in _products) {
      if (product.id == id) {
        return product;
      }
    }
    print('Product not found for ID: $id');
    return null;
  }
}
