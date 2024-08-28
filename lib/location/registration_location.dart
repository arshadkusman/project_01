import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/provider/user_provider.dart';
import 'package:flutter_application_2/screens/registraion_page.dart';
import 'package:provider/provider.dart';

class RegistrationLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/register'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('register'),
        title: 'register',
        child: ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: RegistrationPage(),
        ),
      ),
    ];
  }
}
