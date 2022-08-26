import 'package:capstone_rent_bi/services/chatdb.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chatwidget.dart';
import 'talkpage.dart';

class ChatPageView extends StatefulWidget {
  const ChatPageView({Key? key}) : super(key: key);

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  bool searchcontrol = false;
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.green,
        toolbarHeight: 75,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: searchcontrol
            ? TextFormField(
                autofocus: true,
                onChanged: (val) {
                  setState(() {
                    query = val;
                  });
                })
            : const Text("Mesajlarım"),
      ),
      body: searchcontrol ? search() : home(),
    );
  }

  Widget search() {
    setState(() {});
    CollectionReference firestore =
        FirebaseFirestore.instance.collection("user");
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CustomCircularIndicator(),
          );
        } else {
          if (query.isEmpty) {
            return Center(
              child: Text(
                "Arama Yap",
                style: TextStyle(color: Colors.green),
              ),
            );
          } else {
            return ListView(
              children: [
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['adSoyad']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .map((QueryDocumentSnapshot<Object?> data) {
                  final String username = data.get('adSoyad');
                  final String uid = data.get('uid');
                  final String avatar = data.get('avatarUrl');
                  return GestureDetector(
                      onTap: () {
                        Addchatroom(username: uid, uid: uid, user: username)
                            .addChatRoom()
                            .then((value) {
                          String chatroomid = value
                              .toString()
                              .replaceAll("true", "")
                              .replaceAll("|", "");
                          if (value.toString().contains("true") &&
                              uid != FirebaseAuth.instance.currentUser!.uid) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TalkPage(
                                          chatRoomId: chatroomid,
                                          uid: uid,
                                        )));
                            setState(() {
                              searchcontrol = !searchcontrol;
                              query = "";
                            });
                          } else {}
                        });
                      },
                      child: FirebaseAuth.instance.currentUser!.uid != uid
                          ? listElement(username, avatar)
                          : const SizedBox());
                })
              ],
            );
          }
        }
      },
    );
  }

  Widget listElement(String ad, String avatar) {
    return ListTile(
      trailing: CircleAvatar(
        //backgroundImage: AssetImage('assets/backgrounds/logo.png'),
        foregroundImage: NetworkImage(avatar),
      ),
      title: Text(
        ad,
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
