import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:masbros/ChatPage/components/Body.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messages = [
    {
      "msg": "This is a sent message ",
      "time": "00:03",
      "sender": "Ryzerrector",
    },
    {
      "msg": "This is a recieved message",
      "time": "00:04",
      "sender": "Sender",
    },
    {
      "msg": "This is a recieved message",
      "time": "00:04",
      "sender": "Sender",
    },
    {
      "msg": "This is a recieved message",
      "time": "00:04",
      "sender": "Sender",
    },
    {
      "msg": "This is a sent message ",
      "time": "00:03",
      "sender": "Ryzerrector",
    },
  ];
  final TextEditingController chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Body(msgs: messages),
      persistentFooterButtons: [
        TextFormField(
          decoration: InputDecoration(
            hintText: "Type here....",
          ),
          textInputAction: TextInputAction.send,
          controller: chatController,
          onFieldSubmitted: (value) {
            setState(() {
              messages.add({
                "msg": chatController.value.text,
                "time": TimeOfDay.now().format(context),
                "sender": "Ryzerrector",
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
