import 'package:flutter/material.dart';

import 'Login.dart';

main() {

  runApp(MaterialApp(
    home: Login(),
    theme: ThemeData(
      primaryColor: Color(0xff075E54),
      accentColor: Color(0xff25D366)
    ),
  ));
}
