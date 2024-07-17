import 'package:flutter/material.dart';
import 'package:flutter_application_2/location/home_location.dart';
import 'package:flutter_application_2/location/login_location.dart';
import 'package:flutter_application_2/location/product_location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_application_2/provider/login_provider.dart';
import 'package:flutter_application_2/provider/products_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  setPathUrlStrategy();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider(prefs: prefs)),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: Consumer<LoginProvider>(builder: (context, state, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'E-commerce App',
          routerDelegate: BeamerDelegate(
            initialPath: state.isLoggedIn ? '/home' : '/login',
            locationBuilder: BeamerLocationBuilder(
              beamLocations: [
                HomeLocation(),
                LoginLocation(prefs),
                ProductDetailLocation(),
              ],
            ).call,
          ),
          routeInformationParser: BeamerParser(),
        );
      }),
    );
  }
}
