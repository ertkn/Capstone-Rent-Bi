import 'package:capstone_rent_bi/models/user.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../utilities/snackbar.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _personCollectionPath = 'Users';

/*  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    */
  /*final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final User? user = userCredential.user;
    return user;*/
  /*

    final User? user =
        (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user;
  }*/

  Future<User?> signInWithEmailAndPassword(String email, String password,BuildContext context) async{
    try {
      // print('IN:signInWithEmailAndPassword');
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // print('OUT:signInWithEmailAndPassword');
      final User? user = userCredential.user;
      // _isSuccess =true;
      SnackBarMessage.showSnackBar(context,
          // text: 'welcome back ${UserPreferences.myUser.firstName}',
          text:'welcome back ${user?.uid ?? '---'}\n${user?.email ?? '---'}\n${user?.displayName ?? '---'}');
      return user;
      // Navigator.pushReplacementNamed(context, '/$_home');
    } on FirebaseAuthException catch (e) {
      // _isSuccess = false;
      if (e.code == 'invalid-email') {
        SnackBarMessage.showSnackBar(
          context,
          text: 'user id or password is wrong! ${e.message}',
        );
      }
      else if (e.code == 'user-not-found') {
        SnackBarMessage.showSnackBar(
          context,
          text: 'user id or password is wrong! ${e.message}',
        );
      }else if (e.code == 'wrong-password') {
        SnackBarMessage.showSnackBar(
          context,
          text: 'user id or password is wrong! ${e.message}',
        );
      }else if (e.code == 'user-disabled') {
        SnackBarMessage.showSnackBar(
          context,
          text: 'user id or password is wrong! ${e.message}',
        );
      }
    } catch (e) {
      // _isSuccess = false;
      SnackBarMessage.showSnackBar(
        context,
        text: 'ouch an error catched!! ${e.toString()}',
      );
      // debugPrint(e.toString());
    }
    print('signInWithEmailAndPassword --> failed');
    return null;
  }


  /*Future<User?> registerWithUserCredential(
    String firstName,
    String lastName,
    String email,
    String password,
    String image,
    String about,
    String address,
    Address addressInList,
    int phoneNumber,
    Birthdate birthdate,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      await _firebaseFirestore.collection(_personCollectionPath).doc(user?.uid ?? "").set({
        'userId': user?.uid ?? "",
        'firstName': firstName,
        'lastname': lastName,
        'email': email,
        'about': about,
        'phoneNumber': phoneNumber,
        'address': address,
        'image': image,
        // 'birthDate': '$day/$month/$year',
        'birthDate': birthdate,
      });

      return user;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }*/
// String tempPass,
  Future<User?> registerWithUserCredential(BuildContext context,UserModel userToRegister,String password) async {
    try {
      // print('tempPass: $tempPass');
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userToRegister.email,
        password: password,
      );

      User? user = userCredential.user;


        await _firebaseFirestore.collection(_personCollectionPath).doc(user?.uid ?? "").set({
          'userId': user?.uid ?? "",
          'firstName': userToRegister.firstName,
          'lastname': userToRegister.lastName,
          'email': userToRegister.email,
          'about': userToRegister.about,
          'phoneNumber': userToRegister.phoneNumber,
          // 'address': userToRegister.addressInGeneral,
          'image': userToRegister.imagePath,
          // 'birthDate': '$day/$month/$year',
          'birthDate': userToRegister.birthdate?.toJson(),
          'timestamp':DateTime.now(),
          'address': userToRegister.addressInList?.toJson(),
        });

      return user;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        SnackBarMessage.showSnackBar(
          context,
          text: 'invalid email! ${e.message}',
        );
      }
      else if (e.code == 'email-already-in-use') {
        SnackBarMessage.showSnackBar(
          context,
          text: 'email-already-in-use! ${e.message}',
        );
      }else if (e.code == 'operation-not-allowed') {
        SnackBarMessage.showSnackBar(
          context,
          text: 'operation-not-allowed! ${e.message}',
        );
      }else if (e.code == 'weak-password') {
        SnackBarMessage.showSnackBar(
          context,
          text: 'weak-password! ${e.message}',
        );
    }
    } catch (e) {
      print(e);
    }
    signOutUser();
    print('signOuterUser --> signOutUser()');
    return null;
  }


  Future signOutUser() async {
    print('signOutUser --> done');
    return await _firebaseAuth.signOut();
  }

  Future signInAnonymously(BuildContext context) async {
    try{
      await _firebaseAuth.signInAnonymously();
    }
    on FirebaseException catch(exception){
      if (exception.code == 'operation-not-allowed') {
        SnackBarMessage.showSnackBar(
          context,
          text: 'operation-not-allowed! ${exception.message}',
        );
      }
    }
    catch(error){
        SnackBarMessage.showSnackBar(
          context,
          text: 'CANNOT ANONYMOUS! ${error.toString()}',
        );

      signOutUser();
    }
  }

  User? isUserNull() {
    return _firebaseAuth.currentUser;
  }

}



/*Future<User?> registerWithUserCredential(
    String firstName,
    String lastName,
    String email,
    String password,
    String image,
    String about,
    Map address,
    String addressDistrict,
    String addressCity,
    String addressCountry,
    int phoneNumber,
    int day,
    int month,
    int year,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      await _firebaseFirestore.collection(_personCollectionPath).doc(user?.uid ?? "").set({
        'userId': user?.uid ?? "",
        'firstName': firstName,
        'lastname': lastName,
        'email': email,
        'about': about,
        'phoneNumber': phoneNumber,
        'address': address,
        'image': image,
        'birthDate': '$day/$month/$year',
      });

      return user;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }*/