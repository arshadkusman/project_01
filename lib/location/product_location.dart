import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail.dart';
import '../provider/products_provider.dart';

class ProductDetailLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/productDetail/:productId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final productIdString = state.pathParameters['productId'];
    final productId = int.tryParse(productIdString ?? '');

    print('Navigating to Product Detail with ID: $productIdString');

    if (productId == null) {
      return [
        BeamPage(
          key: const ValueKey('not-found'),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Invalid Product ID'),
            ),
            body: const Center(
              child: Text('Invalid Product ID provided.'),
            ),
          ),
        ),
      ];
    }

    final productProvider = context.read<ProductProvider>();

    if (!productProvider.didFetchProducts) {
      print('Products not yet fetched, waiting for fetch to complete...');
      return [
        BeamPage(
          key: const ValueKey('loading'),
          child: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        ),
      ];
    }

    final product = productProvider.findById(productId);

    if (product == null) {
      return [
        BeamPage(
          key: const ValueKey('product-not-found'),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Product Not Found'),
            ),
            body: const Center(
              child: Text('Product not found.'),
            ),
          ),
        ),
      ];
    }

    return [
      BeamPage(
        key: ValueKey('productDetail-$productId'),
        title: 'Product Details',
        child: ProductDetailScreen(productId: productId),
      ),
    ];
  }
}
