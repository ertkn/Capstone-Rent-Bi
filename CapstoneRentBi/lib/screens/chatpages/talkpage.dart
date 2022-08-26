import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chatinputwidget.dart';

class TalkPage extends StatefulWidget {
  TalkPage({
    required this.chatRoomId,
    required this.uid,
  });
  final String chatRoomId;
  final String uid;

  @override
  State<TalkPage> createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {
  String username = "";
  final DateFormat formatter = DateFormat('hh:mm');
  TextEditingController controller = TextEditingController();
  final TextEditingController _message = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference reference = FirebaseFirestore.instance.collection("user");
  Color backgroundColor = Color(0xff171717);
  Color myMessageColor = Color(0xff29c174);

  reading() async {
    try {
      await FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(widget.chatRoomId)
          .update({
        widget.uid: 0,
      });
    } catch (e) {}
  }

  @override
  void initState() {
    print(widget.uid);
    reading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: backgroundColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              // height: size.height / 1.25,
              height: MediaQuery.of(context).size.height * .77, //62
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('chatRoom')
                    .doc(widget.chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        if (snapshot.data!.docs[index]['type'] == 2) {
                          return pictureBuble(
                              snapshot.data!.docs[index]['url']);
                        }
                        return message(size, map);
                      },
                    );
                  } else {
                    return Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CustomCircularIndicator(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            // Message Types
            //  text = 1
            //  photo = 2
            //  document = 3
            ChatInputField(
                controller: _message,
                chatRoomId: widget.chatRoomId,
                uid: widget.uid,
                messageType: 1),
          ],
        ),
      ),
    );
  }

  Widget pictureBuble(String url) {
    return Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .3,
            right: 10,
            top: 1,
            bottom: 1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            url,
          ),
        ));
  }

  Widget documentBuble(String url) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * .3,
          right: 10,
          top: 1,
          bottom: 1),
      height: MediaQuery.of(context).size.height * .15,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(
            Icons.download,
            color: Colors.white,
            size: MediaQuery.of(context).size.width * .1,
          ),
          Column(
            children: [],
          )
        ],
      ),
    );
  }

  Widget messageBubble(Map<String, dynamic> map) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(
              left: size.width * .3, right: 10, top: 1, bottom: 1),
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                map['message'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Theme.of(context).textTheme.subtitle1!.fontSize,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            map['time'] != null
                ? formatter.format(map['time'].toDate()).toString()
                : formatter.format(DateTime.now()).toString(),
            style: TextStyle(color: Colors.black.withOpacity(.5)),
          ),
        ),
      ],
    );
  }

  Widget messageBubbleRecieved(Map<String, dynamic> map) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              right: size.width * .3, left: 10, top: 1, bottom: 1),
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                map['message'],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Theme.of(context).textTheme.subtitle1!.fontSize,
                    fontFamily: 'Roboto'),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.5),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            map['time'] != null
                ? formatter.format(map['time'].toDate()).toString()
                : formatter.format(DateTime.now()).toString(),
            style: TextStyle(color: Colors.black.withOpacity(.5)),
          ),
        ),
      ],
    );
  }

  Widget message(Size size, Map<String, dynamic> map) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
            width: size.width,
            child: map['sendby'] == FirebaseAuth.instance.currentUser?.uid
                ? messageBubble(map)
                : messageBubbleRecieved(map)),
      ],
    );
  }

  Widget message2(Size size, Map<String, dynamic> map) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
            width: size.width,
            child: map['sendby'] == FirebaseAuth.instance.currentUser?.uid
                ? messageBubble(map)
                : messageBubbleRecieved(map)),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      shadowColor: Colors.black,
      foregroundColor: Colors.green,
      toolbarHeight: 75,
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: StreamBuilder<QuerySnapshot>(
        stream: reference.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return GestureDetector(
              onTap: () {
                print("${widget.uid}");
              },
              child: Row(
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) => element
                          .id
                          .toString()
                          .toLowerCase()
                          .contains(widget.uid.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    //username = data.get('adSoyad');
                    final String name =
                        "${data.get('first_name')} ${data.get('last_name')}";
                    // final String status = data.get('status');
                    final String photo = ""; //data.get('avatarUrl');
                    return Row(
                      children: [
                        //const BackButton(),
                        photo.isEmpty
                            ? const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/anato_finnstark.jpg"))
                            : CircleAvatar(
                                backgroundImage: NetworkImage(photo),
                              ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    );
                  })
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void sendmesage() async {
    Map<String, dynamic>? userMap;
    if (controller.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('user')
          .where("uid", isEqualTo: widget.uid)
          .get()
          .then((value) async {
        userMap = value.docs[0].data();
        if (userMap!['status'].toString() == "Çevirim dışı") {
          await FirebaseFirestore.instance
              .collection("chatRoom")
              .doc(widget.chatRoomId)
              .update({
            FirebaseAuth.instance.currentUser!.displayName.toString():
                FieldValue.increment(1),
            'lastMessage': FieldValue.serverTimestamp(),
          });
          Map<String, dynamic> messages = {
            "sendby": FirebaseAuth.instance.currentUser!.displayName,
            "message": controller.text,
            "time": FieldValue.serverTimestamp(),
          };
          controller.clear();
          await FirebaseFirestore.instance
              .collection('chatRoom')
              .doc(widget.chatRoomId)
              .collection("chats")
              .add(messages);
        } else {
          Map<String, dynamic> messages = {
            "sendby": FirebaseAuth.instance.currentUser!.displayName,
            "message": controller.text,
            "time": FieldValue.serverTimestamp(),
          };
          controller.clear();
          await FirebaseFirestore.instance
              .collection('chatRoom')
              .doc(widget.chatRoomId)
              .collection("chats")
              .add(messages);
        }
      });
    } else {
      print(
          "boş mesaj gönderemezsiniz uyarı koymak için : lib/screens/chatpages/talkpage.dart 396. satır");
    }
  }
}
