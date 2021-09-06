import 'package:flutter/material.dart';
import 'package:masbros/Login/LoginPage.dart';
import 'package:masbros/Services/Authentication_Service.dart';
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
  final TextEditingController usernameController = TextEditingController();
  Text errMsg = Text("");
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthenticationService>(context);
    return Container(
      child: ListView(
        children: [
          Center(
            heightFactor: 4.0,
            child: Text(
              "Sign In",
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
                labelText: "Password",
                prefixIcon: Icon(Icons.vpn_key),
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
                      "Sign In",
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
                  await loginProvider.Register(
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
                Text("Already have an account ?"),
                TextButton(
                  child: Text("Log In"),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
