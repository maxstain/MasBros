import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationService with ChangeNotifier {
  final dbRef = FirebaseDatabase.instance.reference();
  final firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future Register(String username, String email, String password) async {
    try {
      setLoading(true);
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      await user!.updateDisplayName(username);
      await user.updatePhotoURL("https://robohash.org/$username");
      await firestore.collection("Users").add(
        {
          "displayName": username,
          "email": email,
          "password": password,
          "createdAt": DateTime.now().toUtc().toString(),
        },
      );
      await dbRef.child("users").push().set(
        {
          "createdAt": DateTime.now().toUtc().toString(),
          "displayName": username,
          "email": email,
          "password": password,
        },
      );
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage("No Internet connection, please connect to the internet");
    } catch (e) {
      setLoading(false);
      print(e);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future Login(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage("No Internet connection, please connect to the internet");
    } catch (e) {
      setLoading(false);
      print(e);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future Logout() async {
    await firebaseAuth.signOut();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User?> get user =>
      firebaseAuth.authStateChanges().map((event) => event);
}
