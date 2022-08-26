import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  void addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_$a";
    } else {
      return "${a}_$b";
    }
  }
}

class Addchatroom {
  String username;
  String uid;
  String user;

  Addchatroom({required this.username, required this.uid, required this.user});

  Future addChatRoom() async {
    try {
      String name = FirebaseAuth.instance.currentUser!.uid;

      String users = "${name}_$username";
      String chatRoomId = DatabaseMethods().getChatRoomId(
          FirebaseAuth.instance.currentUser!.uid.toString(), uid);
      Map<String, dynamic> chatRoom = {
        name: 0,
        username: 0,
        "userIds": FieldValue.arrayUnion([name, username]),
        "userNames": FieldValue.arrayUnion(["AD SOYAD", user]),
        "users": users,
        "chatRoomId": chatRoomId,
        "group": false,
        // mfpapfjpefj_fjaepfjeaf|true.replaceall("true", "").replaceall.("|",""); kalan = mfpapfjpefj_fjaepfjeaf
      };
      DatabaseMethods().addChatRoom(chatRoom, chatRoomId);
      return "$chatRoomId|true";
    } catch (e) {
      return false;
    }
  }
}
