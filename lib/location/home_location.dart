import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';
import '../screens/home.dart';

class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/home'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('home'),
        title: 'Home',
        child: ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: HomeScreen(),
        ),
      ),
    ];
  }
}
