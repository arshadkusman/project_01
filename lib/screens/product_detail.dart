import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';
import '../provider/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final product = Provider.of<ProductProvider>(context, listen: false)
        .findById(widget.productId);

    return FutureBuilder<void>(
      future:
          Provider.of<ProductProvider>(context, listen: false).fetchProducts(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading...'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.error != null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: const Center(
              child: Text('An error occurred!'),
            ),
          );
        } else {
          if (product == null) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Product Not Found'),
              ),
              body: const Center(
                child: Text('Product not found.'),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
              backgroundColor: Colors.blue,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Beamer.of(context).beamToNamed('/home');
                },
              ),
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
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isAddedToCart = true;
                              });
                              cart.addItem(product.id, product.price as double,
                                  product.title, product.images);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Item Added to cart'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              cart.addItem(product.id, product.price as double,
                                  product.title, product.images);
                              Beamer.of(context).beamToNamed('/cart');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_isAddedToCart) const SizedBox(height: 24.0),
                    if (_isAddedToCart)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (cart.items.containsKey(product.id) &&
                                    cart.items[product.id]!.quantity > 1) {
                                  cart.updateItemQuantity(product.id,
                                      cart.items[product.id]!.quantity - 1);
                                } else {
                                  cart.removeItem(product.id);
                                  _isAddedToCart = false;
                                }
                              });
                            },
                          ),
                          Text(cart.items.containsKey(product.id)
                              ? '${cart.items[product.id]!.quantity}'
                              : '0'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                cart.addItem(
                                    product.id,
                                    product.price as double,
                                    product.title,
                                    product.images);
                              });
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
