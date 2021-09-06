import 'package:flutter/material.dart';
import 'package:masbros/HomePage/HomePage.dart';
import 'package:masbros/Services/Authentication_Service.dart';
import 'package:masbros/SignIn/SigninPage.dart';
import 'package:masbros/main.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Text errMsg = Text("");

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthenticationService>(context);
    return Container(
      child: Form(
        key: _formkey,
        child: ListView(
          children: [
            Center(
              heightFactor: 4.0,
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0, left: 8.0, right: 8.0),
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
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
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
                child: loginProvider.isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                onPressed: () async {
                  if ((emailController.text.isEmpty) ||
                      (passwordController.text.isEmpty)) {
                    setState(() {
                      errMsg = Text("Wrong Credentials");
                    });
                  } else {
                    await loginProvider.Login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => AuthenticationWrapper()));
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // ignore: unnecessary_null_comparison
            if (loginProvider.errorMessage != null)
              Container(
                color: Colors.amberAccent,
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(loginProvider.errorMessage.toString()),
                  leading: Icon(Icons.error),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => loginProvider.setMessage(null),
                  ),
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Text("Don't have an account yet ?"),
                  TextButton(
                    child: Text("Sign In"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SigninPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
