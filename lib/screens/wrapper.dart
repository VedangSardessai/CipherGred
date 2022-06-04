import 'package:cipher_gred/models/userr.dart';
import 'package:cipher_gred/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr?>(context);

    //return either home or authenticate
    if (user == null) {
      return const SignIn();
    } else {
      return const Home();
    }
  }
}
