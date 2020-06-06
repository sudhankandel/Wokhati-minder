
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signup/pages/profile/user_profile.dart';
import 'package:signup/services/authentication.dart';

class Profilepage extends StatefulWidget {
 
   Profilepage({Key key, this.auth, this.logoutCallback,this.userid})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userid;

  @override
  _ProfilepageState createState() => _ProfilepageState(this.auth);
}
class _ProfilepageState extends State<Profilepage> { 
  _ProfilepageState(this.auth);
final BaseAuth auth;
String username='..';

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
  //  profilepic=user.photoUrl;
  
 

 });
}
 signOut() async {
    try {
      
      print("this function is call");
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
      title:Text("SETTING",
      style:TextStyle()),
      bottomOpacity:10.4
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Card(
              elevation: 0.5,
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                 
                  ListTile(
                    
                    trailing: Icon(FontAwesomeIcons.edit),
                    leading: CircleAvatar(
                        radius: 20,

                        child: ClipOval(
                        child: new SizedBox(
                          width: 150.0,
                          height: 150.0,
                          child: Image.network(
                            profilepic,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    
                    title: Text('$username'),
                     onTap: ()=>showModalBottomSheet(
                      context:context,
                      backgroundColor:Colors.black,
                       builder:(context)=>UserProfile(auth :auth),
                       isScrollControlled: true,
                       ),
                  ),
                  _buildDivider(),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0,),
              child: Column(
                children: <Widget>[
                 ListTile(
                    leading: Icon(FontAwesomeIcons.bookMedical),
                    title: Text("Diary"),
                    onTap: () {},
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.userMd),
                    title: Text("Doctor"),
                    onTap: () {},
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.chartLine),
                    title: Text("Report"),
                    onTap: () {},
                  ),
                  
                ],
              ),
            ),
             Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0,),
              child: Column(children:<Widget>[
                 ListTile(
                leading: Icon(FontAwesomeIcons.questionCircle),
                title: Text("Help & Support"),
                onTap: (){},
              ),
              _buildDivider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                onTap: signOut,
              ),
              _buildDivider(),
                 ListTile(
                title: Text("About"
              ),
                onTap: (){},
              ),
            



              ]),
             
             ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}