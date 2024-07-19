import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../screens/product_detail.dart';

class ProductDetailLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/productDetail/:productId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final productIdString = state.pathParameters['productId'];
    final productId = int.tryParse(productIdString ?? '');
    print('productid $productId');

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

    return [
      BeamPage(
        key: ValueKey('productDetail-$productId'),
        title: 'Product Details',
        child: ProductDetailScreen(productId: productId),
      ),
    ];
  }
}
