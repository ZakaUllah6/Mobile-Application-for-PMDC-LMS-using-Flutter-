import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class DatabaseStorageServices {
  FirebaseStorage _storage = FirebaseStorage.instance;

  uploadUserImage(File image, String uuid) async {
    // final imagePath = image.path;
    try {
      var reference = await _storage.ref().child("UserProfilesImages/$uuid");
      var uploadImage = reference.putFile(image);
      TaskSnapshot snapshot =
          await uploadImage.whenComplete(() => print('Image Uploaded'));

      final imageUrl = await snapshot.ref.getDownloadURL();
      String img = imageUrl;
      print("urlll: $img");
      return img;
    } catch (e) {
      print("Exception@uploadUserImage=> $e");
      return null;
    }
  }

  Future<String?> uploadFile({
    required File image,
    required String userId,
    required Function(double) callBack,
    // required String problemId
  }) async {
    try {
      var fileName = (image.path.split('/').last);
      print("$fileName");
      var reference =
          _storage.ref().child("posts/$userId/ProblemData/$fileName");

      var uploadImage = reference.putFile(image);
      print("image" + image.toString());
      uploadImage.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        callBack(progress);
      });
      TaskSnapshot snapshot = await uploadImage.whenComplete(
        () => print('Image Uploaded'),
      );

      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Exception@uploadProblemPic ==> $e");
      // return null;
      throw "image-upload-error";
    }
  }
}
