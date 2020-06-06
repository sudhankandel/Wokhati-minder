import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signup/services/authentication.dart';


class UserProfile extends StatefulWidget {
  UserProfile({this.auth});
  final BaseAuth auth;
  @override
  _UserProfileState createState() => _UserProfileState(auth:this.auth);
}

class _UserProfileState extends State<UserProfile> {
  _UserProfileState({this.auth});
  final BaseAuth auth;
 String username='..';
 String email='..';
 String profilepic="https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";
@override
void initState(){
  super.initState();
     findDisplayname();
}
Future<void> findDisplayname()async{
 FirebaseUser user=await widget.auth.getCurrentUser();
 setState(() {
   username=user.displayName;
   email=user.email;
  // profilepic=user.photoUrl;
 });
}


File _image;



 Future getImage() async {
   ImagePicker pick;
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
           _status = false;
      });
    }

Future uploadImage()async{
  
  var randomno=Random(25);
  StorageReference firebaseStorageRef = FirebaseStorage.instance
                        .ref()
                        .child('Profilepics/${randomno.nextInt(5000).toString()}.jpg');
  StorageUploadTask task=firebaseStorageRef.putFile(_image);
  var downUrl=await(await task.onComplete).ref.getDownloadURL();
  var url=downUrl.toString();
  widget.auth.uploadProfilePicture(url);


setState(() {
    _status = true;
    FocusScope.of(context).requestFocus(new FocusNode());
});
 Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
}

 



 bool _status = true;
  final FocusNode myFocusNode = FocusNode();






  @override
  Widget build(BuildContext context) {
final usernameController = TextEditingController(text: '$username');
final useremail = TextEditingController(text: '$email');
    return new Scaffold(
        body: new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 230.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 20.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                             
                              icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            onPressed: ()=>Navigator.maybePop(context)),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Color(0xff476cfb),
                      child: ClipOval(
                        child: new SizedBox(
                          width: 150.0,
                          height: 150.0,
                          child: (_image!=null)?Image.file(
                            _image,
                            fit: BoxFit.fill,
                          ):Image.network(
                            profilepic,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FloatingActionButton(
                                  backgroundColor: Colors.red[300],
                                child: CircleAvatar(
                                  backgroundColor: Colors.red[300],
                                  radius: 20.0,
                                  child: new Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: getImage,)
                              ],
                            )),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Parsonal Information',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? _getEditIcon() : new Container(),
                                ],
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                controller: usernameController,
                                  decoration: const InputDecoration(
                                    hintText: "Entername",
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,

                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Email ID',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 0.0),
                          child: new Row(
                            // mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: useremail,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Email ID"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'DOB',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  decoration: const InputDecoration(
                                      hintText: "DOB"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      !_status ? _getActionButtons() : new Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: uploadImage,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}