import 'package:flutter/material.dart';
import 'package:flutter_application_2/location/cart_location.dart';
import 'package:flutter_application_2/location/home_location.dart';
import 'package:flutter_application_2/location/login_location.dart';
import 'package:flutter_application_2/location/product_location.dart';
import 'package:flutter_application_2/location/registration_location.dart';
import 'package:flutter_application_2/provider/cart_provider.dart';
import 'package:flutter_application_2/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_application_2/provider/login_provider.dart';
import 'package:flutter_application_2/provider/products_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final cartProvider = CartProvider();
  await cartProvider.loadCart();
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
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: Consumer<LoginProvider>(builder: (context, state, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'E-commerce App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          routerDelegate: BeamerDelegate(
            initialPath: state.isLoggedIn ? '/home' : '/login',
            locationBuilder: BeamerLocationBuilder(
              beamLocations: [
                HomeLocation(),
                LoginLocation(prefs),
                ProductDetailLocation(),
                RegistrationLocation(),
                CartLocation(),
              ],
            ).call,
          ),
          routeInformationParser: BeamerParser(),
        );
      }),
    );
  }
}
