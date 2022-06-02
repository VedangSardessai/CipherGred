import 'package:flutter/material.dart';
import 'package:cipher_gred/screens/authenticate/sign_in.dart';
import 'package:cipher_gred/screens/home/googles/google_logged_in.dart';

class GoogleHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (snapshot.hasData)
            return GoogleLoggedIn();
          else if (snapshot.hasError)
            return Center(
              child: Text('Something went wrong!'),
            );
          else
            return SignIn();
        }),
      );
}
