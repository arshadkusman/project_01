import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);
    print('Fetching product details for ID: $productId');

    if (product == null) {
      print('Product not found for ID: $productId');
      return Scaffold(
        appBar: AppBar(
          title: const Text('Product Not Found'),
        ),
        body: const Center(
          child: Text('Product not found.'),
        ),
      );
    }

    print('Product found: ${product.title}');
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.network(
                  product.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                product.title,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                '\$${product.price}',
                style: const TextStyle(fontSize: 24.0, color: Colors.green),
              ),
              const SizedBox(height: 16.0),
              Text(
                product.description,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
