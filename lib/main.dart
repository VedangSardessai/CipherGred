import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cipher_gred/models/userr.dart';
import 'package:cipher_gred/screens/authenticate/google_sign_in.dart';
import 'package:cipher_gred/screens/wrapper.dart';
import 'package:cipher_gred/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainClass());
}

class MainClass extends StatelessWidget {
const MainClass({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: StreamProvider<Userr?>.value(
        catchError: (_, __) => null,
        initialData: null,
        value: AuthService().userStream,
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      ),
    );
  }
}