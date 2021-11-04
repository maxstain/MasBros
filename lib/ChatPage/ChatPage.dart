import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController chatController = TextEditingController();
  List messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Chat")
            .orderBy("time")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return document["sender"] == user!.displayName
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("You"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Colors.pink,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 8.0),
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document["msg"].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.pink,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Sent on ${document["time"].toString()}",
                            style: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(document["sender"]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.pink,
                                ),
                              ),
                              Container(
                                color: Colors.pink[200],
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 8.0),
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      document["msg"].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Sent on ${document["time"].toString()}",
                            style: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    );
            }).toList(),
          );
        },
      ),
      persistentFooterButtons: [
        TextFormField(
          decoration: InputDecoration(
            hintText: "Type here....",
          ),
          textInputAction: TextInputAction.send,
          controller: chatController,
          onFieldSubmitted: (value) {
            setState(() {
              FirebaseFirestore.instance.collection("Chat").add({
                "msg": chatController.value.text,
                "time": TimeOfDay.now().format(context),
                "sender": user!.displayName.toString(),
              });
              print(messages);
              chatController.text = "";
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.send,
            color: Colors.pink,
          ),
          onPressed: () {
            print("Sent");
          },
        ),
      ],
    );
  }
}
