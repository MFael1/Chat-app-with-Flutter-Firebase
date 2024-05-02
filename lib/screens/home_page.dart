import 'package:chatapp/components/chat_buble.dart';
import 'package:chatapp/components/send_text_field.dart';
import 'package:chatapp/constant.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String? mail;

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  static const id = 'HomePage';

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollectionMessages);

  TextEditingController controller = TextEditingController();

  final _controller1 = ScrollController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; ++i) {
            messageList.add(Message.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            // backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: kPrimiaryColor,
              automaticallyImplyLeading: false,
              title: const Text('Say hello'),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller1,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id != email
                          ? ChatBuble(
                              message: messageList[index],
                            )
                          : ChatBubleFriend(message: messageList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SendTextField(
                    controller: controller,
                    func: (value) {
                      messages.add({
                        'message': value,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      _controller1.animateTo(0,
                          duration: Duration(microseconds: 500),
                          curve: Curves.linear);
                    },
                  ),
                )
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text('Loading...'),
            ),
          );
        }
      },
    );
  }
}
