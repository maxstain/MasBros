import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masbros/Resources/db.dart';

class AppointmentsService with ChangeNotifier {
  final dbRef = FirebaseDatabase.instance.reference();
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List? appointments;

  Future AddAppointment(String date, String time) async {
    try {
      setLoading(true);
      await dbRef.child("appointments").push().set(
        {
          "Date": date,
          "Time": time,
        },
      );
      print("Appointment added");
      setLoading(false);
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

  getAppointment() {
    try {
      setLoading(true);
      appointments = dbRef.child("appointments").get().asStream() as List?;
      print("Appointment Loaded");
      setLoading(false);
      return appointments;
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
