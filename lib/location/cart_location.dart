import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../screens/cart_page.dart';

class CartLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/cart'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('cart'),
        title: 'Cart',
        child: CartPage(),
      ),
    ];
  }
}
