import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'talkpage.dart';

StatefulBuilder home() {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("chatRoom");
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return StreamBuilder<QuerySnapshot>(
        stream: reference
            .orderBy('lastMessage', descending: true)
            .snapshots()
            .asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Sohbet boş"),
            );
          } else {
            if (snapshot.data!.size != 0) {
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['userIds'] //element['chatRoomId']
                              .toString()
                              .toLowerCase()
                              .contains(FirebaseAuth.instance.currentUser!.uid
                                  .toString()
                                  .toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String chatroomid = data.id;
                    if (data.get('group')) {
                      final String roomName = data.get('roomName');
                    }
                    var uid = chatroomid
                        .replaceAll(FirebaseAuth.instance.currentUser!.uid, "")
                        .replaceAll("_", "");

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TalkPage(
                                      chatRoomId: chatroomid,
                                      uid: uid,
                                    )));
                      },
                      child: showChat(context, uid, data.get(uid)),
                    );
                  })
                ],
              );
            } else {
              return const Center(
                child: Text("Sohbet boş"),
              );
            }
          }
        },
      );
    },
  );
}

Widget showChat(BuildContext context, var uid, var index) {
  var size = MediaQuery.of(context).size;
  CollectionReference reference = FirebaseFirestore.instance.collection("user");
  return Container(
    width: size.width,
    height: 74,
    color: Colors.transparent,
    child: StreamBuilder<QuerySnapshot>(
      stream: reference.snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          return Column(
            children: [
              ...snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) => element.id
                      .toString()
                      .toLowerCase()
                      .contains(uid.toLowerCase()))
                  .map((QueryDocumentSnapshot<Object?> data) {
                final String name = data.get('first_name');
                final String photo = ""; //data.get('avatarUrl');
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: photo.isEmpty
                            ? const CircleAvatar(
                                radius: 12,
                                backgroundImage:
                                    AssetImage("assets/anato_finnstark.jpg"),
                              )
                            : CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(photo),
                                backgroundColor: Colors.transparent,
                              ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 12)),
                    Text(
                      name,
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:
                                index == 0 ? Colors.transparent : Colors.green),
                        child: index == 0
                            ? const SizedBox()
                            : Center(
                                child: Text(
                                  "$index",
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              })
            ],
          );
        }
      },
    ),
  );
}

Widget showGroupChat(BuildContext context, var uid, String roomName,
    String avatarUrl, int index) {
  var size = MediaQuery.of(context).size;
  CollectionReference reference = FirebaseFirestore.instance.collection("user");
  return Container(
    width: size.width,
    height: 74,
    color: Colors.transparent,
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, left: 10),
          child: SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                radius: 12,
                foregroundImage: NetworkImage(avatarUrl),
                backgroundImage: AssetImage("assets/backgrounds/logo.png"),
              )),
        ),
        const Padding(padding: EdgeInsets.only(left: 12)),
        Expanded(
          child: Text(
            roomName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index == 0 ? Colors.transparent : Color(0xff29c174)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                index == 0
                    ? const Text("")
                    : Text(
                        "$index",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
