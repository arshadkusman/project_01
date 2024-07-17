import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/login_provider.dart';


class LoginLocation extends BeamLocation<BeamState> {
  final SharedPreferences prefs;

  LoginLocation(this.prefs);

  @override
  List<String> get pathPatterns => ['/login'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('login'),
        title: 'Login',
        child: ChangeNotifierProvider(
          create: (context) => LoginProvider(prefs: prefs),
          child: LoginPage(),
        ),
      ),
    ];
  }
}
