import 'package:flutter/material.dart';
import 'package:signup/services/authentication.dart';




class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  
  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  String _repassword;
  String _name;

     bool _isLoginForm=true;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
        } 
        else {
           await widget.auth.signUp(_email, _password,_name);
            toggleSigninFormmode();
         
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          // print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

     
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          // _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }
void toggleSigninFormmode(){
resetForm();
    setState(() {
      _isLoginForm = true;
    });

}
  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(_isLoginForm){
    return new Scaffold(
        body:Stack(
          children: <Widget>[
            _showLoginForm(),
            _showCircularProgress(),
          ],
        ));}
      else  if(!_isLoginForm){ 
      return new Scaffold(
              body:Stack(
                children: <Widget>[
                  _showRegistration(),
                  _showCircularProgress(),
                ],
              ));

        }
        else{
          return new Scaffold(
            body:Stack(children: <Widget>[
              Text("Error")
            ],)
          );
        }
       
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }


  Widget _showLoginForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
       
        child: new Form(
          key: _formKey,
          
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              showEmailInput(),
              showPasswordInput(),
              showErrorMessage(),
              showForgetpassword(),
              showPrimaryButton(),
              showLoginwithFb(),
              showRegistration()    
            ],
          ),
        ));
  }



  Widget _showRegistration() {
    return new Container(
        padding: EdgeInsets.all(16.0),
       
        child: new Form(
          key: _formKey,
          
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              
              showTiele(),
              showUserName(),
              showEmailInput(),
              showPasswordInput(),
              showRePasswordInput(),
              showErrorMessage(),
              showPrimaryButton(),
              showSignin(),   
            ],
          ),
        ));
  }

  Widget showSignin(){
  return Padding(
    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
  child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Have Already Wokhati ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: toggleSigninFormmode,
                 
                  child: Text(
                    'Sign',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ));
}

Widget showRePasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Re Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
              validator: (value) {
                      if (value.isEmpty) {
                        return 'Repassword can\'t be empty' ;
                      }
                      // if(value == _password){
                      //   return 'Password not Match!!!';
                      // }
                      return null;
              },
        onSaved: (value) => _repassword = value.trim(),
      ),
    );
  }

  Widget showTiele(){
  return    Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 90.0, 0.0, 0.0),
                  child: Text(
                    'Register',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
}


  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Padding( padding: EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 0.0),
     child: Text(
        _errorMessage,
        style: TextStyle(

            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.bold),
      ));
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
  Widget showLogo() {
    return new Hero(
      tag: 'Wokhati',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 50.0),
        child: CircleAvatar(
          backgroundColor: Colors.black87,
          radius: 60.0,
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }
  Widget showForgetpassword(){
    return    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                         onTap: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    );
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 15.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text(_isLoginForm ? 'Login' : 'Create account',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }


Widget showLoginwithFb()
{
  return Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child:
                                  ImageIcon(AssetImage('assets/facebook.png')),
                            ),
                            SizedBox(width: 10.0),
                            Center(
                            
                              child: Text('Log in with facebook',
                                  style: TextStyle(
                                    
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            )
                          ],
                        ),
                      ),
                    );
}
Widget showRegistration(){
  return Padding(
    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
  child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to Wokhati ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: toggleFormMode,
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ));
}

Widget showUserName() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Full Name',
            icon: new Icon(
              Icons.supervised_user_circle,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Full name  can\'t be empty' : null,
       
         onSaved:(value) =>_name=value.trim(),
       
      ),
    );
  }
}