import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ChatInputField extends StatefulWidget {
  TextEditingController controller;
  String chatRoomId;
  String uid;
  int messageType;
  ChatInputField(
      {Key? key,
      required this.controller,
      required this.chatRoomId,
      required this.uid,
      required this.messageType})
      : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  // Message Types
  File? image;

  String imageName = "";

  @override
  Widget build(BuildContext context) {
    const kDefaultPadding = 20.0;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 32,
                color: Colors.white.withOpacity(.01),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageName != ""
                    ? Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: MediaQuery.of(context).size.height * .15,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: FileImage(image!),
                            )),
                      )
                    : SizedBox(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: kDefaultPadding / 4),
                            Expanded(
                              child: TextField(
                                controller: widget.controller,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  hintText: "Mesaj",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        sendmesage();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void sendmesage() async {
    if (widget.controller.text.isNotEmpty) {
      print('message sent');
      FirebaseFirestore.instance
          .collection('user')
          .where("uid", isEqualTo: widget.uid)
          .get()
          .then((value) async {
        await FirebaseFirestore.instance
            .collection("chatRoom")
            .doc(widget.chatRoomId)
            .update({
          FirebaseAuth.instance.currentUser!.uid: FieldValue.increment(1),
          'lastMessage': FieldValue.serverTimestamp(),
        });
        Map<String, dynamic> messages = {
          "sendby": FirebaseAuth.instance.currentUser!.uid,
          "message": widget.controller.text,
          "time": FieldValue.serverTimestamp(),
          "type": 1
        };
        widget.controller.clear();
        await FirebaseFirestore.instance
            .collection('chatRoom')
            .doc(widget.chatRoomId)
            .collection("chats")
            .add(messages);
      });
    }
  }

  updateLastMessage({required String message, required FieldValue date}) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(widget.chatRoomId)
        .update({'lastMessage': message, 'lastMessageDate': date});
  }
}
