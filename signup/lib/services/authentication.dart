import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup/models/user.dart';
import 'package:signup/services/database.dart';

abstract class BaseAuth {

  
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password,String name);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();
  uploadProfilePicture(picurl);

 

  

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password,String name) async {
    OurUser _user=OurUser();

    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(

        email: email, password: password);
        FirebaseUser user = result.user;
        UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = name;
        user.updateProfile(userUpdateInfo);
        await user.reload();
        _user.uid=user.uid;
        _user.fullName=name;
        _user.email=email;
        OurDatabase().createUser(_user);

        
       
    return user.uid;
  }
  

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }


  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

uploadProfilePicture(picurl) async{
  var userInfo=new UserUpdateInfo();
  userInfo.photoUrl=picurl;
  FirebaseUser user = await _firebaseAuth.currentUser();
  user.updateProfile(userInfo).then((value) {
    Firestore.instance.collection('users').where('uid',isEqualTo:user.uid)
    .getDocuments()
    .then((docs) {
      Firestore.instance
      .document('/users/${docs.documents[0].documentID}')
      .updateData({'imageurl':picurl});
      
    });

  })
  .catchError((e){
    print(e);
  });




  // await user.reload();
}

}
