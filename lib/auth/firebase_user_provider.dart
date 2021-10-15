import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MywalletFirebaseUser {
  MywalletFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

MywalletFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MywalletFirebaseUser> mywalletFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<MywalletFirebaseUser>(
            (user) => currentUser = MywalletFirebaseUser(user));
