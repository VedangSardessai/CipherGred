import 'package:firebase_auth/firebase_auth.dart';
import 'package:cipher_gred/models/userr.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on User
  Userr? _userr(User user) {
    return user != null ? Userr(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<Userr> get userStream {
    return _auth.authStateChanges().map((User? user) => _userr(user!)!);
  }

  // Sign in anonymously
  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userr(user!);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // With Email/Password

  // Google

  // Sign out
  Future signOut() async{
    try{
    // print(_userr);
    return await _auth.signOut();
    }
    catch(e){
    // print(e.toString());
    return null;
    }
  }
}