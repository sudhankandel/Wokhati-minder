import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:signup/models/user.dart';


class OurDatabase {
  final Firestore _firestore = Firestore();
 String retVal = "error";
  Future<String> createUser(OurUser user) async {
   

    try {
      await _firestore.collection("users").document(user.uid).setData({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
        'imageurl':'',
        'dob':'',
        'sex':'',
        'uid':user.uid
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}