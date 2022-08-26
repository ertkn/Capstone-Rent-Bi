import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadMedia(File file) async {
    try {
      print('file: $file');
      UploadTask uploadTask = _storage
          .ref('/product')
          .child("${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}")
          .putFile(file);

      print('uploadTask: ${uploadTask.snapshot}');

      // uploadTask.snapshotEvents.listen((event) {print('event: ${event}');});
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress =
                100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            print('error: ${TaskState.error}');
            break;
          case TaskState.success:
          // Handle successful uploads on complete
          // ...
          print('susscess');
            break;
        }
      });
      var storageRef = await uploadTask;

      print('storageRef: ${storageRef}');
      return await storageRef.ref.getDownloadURL();
    } catch (e) {
      print('error: $e');
      return e.toString();
    }
  }
}
