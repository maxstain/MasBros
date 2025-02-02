// ignore_for_file: unnecessary_null_comparison
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masbros/Services/Authentication_Service.dart';
import 'package:masbros/main.dart';
import 'package:provider/provider.dart';

class UpdateInformations extends StatefulWidget {
  UpdateInformations({Key? key}) : super(key: key);

  @override
  _UpdateInformationsState createState() => _UpdateInformationsState();
}

class _UpdateInformationsState extends State<UpdateInformations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Info"),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Text errMsg = Text("");
  late File imageFile;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    final updateProvider = Provider.of<AuthenticationService>(context);
    final User? user = FirebaseAuth.instance.currentUser;
    return Container(
      child: Form(
        key: _formkey,
        child: ListView(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: user!.photoURL != null
                      ? NetworkImage(user.photoURL.toString())
                      : NetworkImage("https://picsum.photos/250?image=9"),
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () {
                      print("pressed");
                      _getFromGallery();
                    },
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300.0,
                  padding: EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: usernameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.account_box_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pink,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.check),
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    onPressed: () async {
                      await updateProvider.updateUsername(
                        usernameController.text.trim(),
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => AuthenticationWrapper()));
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300.0,
                  padding: EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: usernameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pink,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.check),
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    onPressed: () async {
                      await updateProvider.updateEmail(
                        emailController.text.trim(),
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => AuthenticationWrapper()));
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300.0,
                  padding: EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.vpn_key_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pink,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.check),
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    onPressed: () async {
                      await updateProvider.updatePassword(
                        passwordController.text.trim(),
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => AuthenticationWrapper()));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getFromGallery() async {
    User? user = FirebaseAuth.instance.currentUser;
    File pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    )) as File;

    setState(() {
      if (pickedFile != null) {
        imageFile = pickedFile;
        user!.updatePhotoURL(pickedFile.path);
      }
    });
  }
}
