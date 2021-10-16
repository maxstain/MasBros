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
            Container(
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
              padding: EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
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
              padding: EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.vpn_key),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 20.0,
              ),
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.pink),
                ),
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  if ((emailController.text.isEmpty) ||
                      (passwordController.text.isEmpty) ||
                      (usernameController.text.isEmpty)) {
                    setState(() {
                      errMsg = Text("Wrong Credentials");
                    });
                  } else {
                    await updateProvider.Update(
                      usernameController.text.trim(),
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => AuthenticationWrapper()));
                  }
                },
              ),
            ),
            if (updateProvider.errorMessage != null)
              Container(
                color: Colors.amberAccent,
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(updateProvider.errorMessage.toString()),
                  leading: Icon(Icons.error),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => updateProvider.setMessage(null),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _getFromGallery() async {
    File pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    )) as File;

    setState(() {
      if (pickedFile != null) {
        imageFile = pickedFile;
      }
    });
  }
}
