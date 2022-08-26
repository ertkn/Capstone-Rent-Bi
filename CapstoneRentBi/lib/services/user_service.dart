import 'package:capstone_rent_bi/models/user.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_rent_bi/services/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final String _productCollectionPath = "Product";
  final String _personCollectionPath = "Users";
  final String _favouriteCollectionPath = "Favourites";

  var userCredential = AuthService().isUserNull();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserCredential() {
    var ref = _firestore.collection(_personCollectionPath).doc(userCredential?.uid);
    var docRef = ref.snapshots();
    UserModel? userModel;
    var obj;
    Map<String, dynamic>? userCredentialMap;
/*    print(docRef.then((value) async {
      print('1: ${docRef}');
      print('2: ${value}');
      print('3: ${value.data()}');
      print('4: ${value.data()?.values}');
      obj = value.data();
      userModel = userModelFromJson(obj);
      print('5: ${userModel?.toJson()}');
      userCredentialMap = userModel?.toJson();
      print('6: ${userCredentialMap}');

      // value.data()?.values;
    },));*/

    return docRef;
  }

  isUserLogIn(){

  }

  Future<void> updateUserCredentialField(String fieldName, UserModel userCredentialInfo) async {
    var ref = _firestore.collection(_personCollectionPath).doc(userCredential?.uid);
    ref.update({'${fieldName}': userCredentialInfo});
  }

  Future<void> updateUserCredential(UserModel userCredentialInfo) async {
    var ref = _firestore.collection(_personCollectionPath).doc(userCredential?.uid);
    ref.set({
      "${userCredential?.uid}": {
        "uuid": userCredentialInfo.uuid,
        "first_name": userCredentialInfo.firstName,
        "last_name": userCredentialInfo.lastName,
        "email": userCredentialInfo.email,
        "image": userCredentialInfo.imagePath,
        "phone_number": userCredentialInfo.phoneNumber,
        "about": userCredentialInfo.about,
        "birth_date": userCredentialInfo.birthdate?.toJson(),
        "address": userCredentialInfo.addressInList?.toJson(),
        "timestamp": FieldValue.serverTimestamp(),
      }
    }, SetOptions(merge: true));
    // ref.update({'${fieldName}': userCredentialInfo});
  }
}
