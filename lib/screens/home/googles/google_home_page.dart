import 'package:flutter/material.dart';
import 'package:cipher_gred/screens/authenticate/sign_in.dart';
import 'package:cipher_gred/screens/home/googles/google_logged_in.dart';

class GoogleHomePage extends StatelessWidget {
  const GoogleHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const GoogleLoggedIn();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          } else {
            return const SignIn();
          }
        }),
      );
}
