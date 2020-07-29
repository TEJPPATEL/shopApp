import 'package:ShopApp/models/httpexception.dart';
import 'package:ShopApp/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Login, Signup }

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.Login;

  final usernameInput = TextEditingController();
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();

  final _formkey = new GlobalKey<FormState>();
  bool _isLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    void _showErrorDialoug(String errorMessage) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              child: Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }

    print(_authMode);
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple.withOpacity(0.1), Colors.white],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (_isLoading) CircularProgressIndicator(),
                  // Image.network(
                  //     "https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-sample-grunge-red-round-stamp.jpg"),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          onSaved: (value) => _authData["email"] = value,
                          keyboardType: TextInputType.emailAddress,
                          key: ValueKey("email"),
                          validator: (value) =>
                              value.isEmpty || !value.contains("@")
                                  ? "Please Enter Email"
                                  : null,
                          controller: emailInput,
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                        if (_authMode == AuthMode.Signup)
                          TextFormField(
                            key: ValueKey("username"),
                            validator: (value) =>
                                value.isEmpty ? "Please Enter Username" : null,
                            controller: usernameInput,
                            decoration: InputDecoration(labelText: "Username"),
                          ),
                        TextFormField(
                          onSaved: (value) => _authData["password"] = value,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          key: ValueKey("password"),
                          validator: (value) =>
                              value.isEmpty ? "Please Enter Password" : null,
                          controller: passwordInput,
                          decoration: InputDecoration(labelText: "Password"),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          setState(() {
                            _authMode = AuthMode.Login;
                            _isLoading = true;
                          });
                          if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();
                            print("Valid");
                            try {
                             await Provider.of<Auth>(context).logIn(
                                  _authData["email"], _authData["password"]);
                            } on HttpException catch (error) {
                              print("httpblock");
                              var errorMessage = "Authetication Failed";
                              if (error.toString().contains("EMAIL_EXISTS")) {
                                errorMessage = "This Email is Already Exist";
                              } else if (error
                                  .toString()
                                  .contains("INVALID_EMAIL")) {
                                errorMessage = "This Email Address is Invalid";
                              } else if (error
                                  .toString()
                                  .contains("WEAK_PASSWORD")) {
                                errorMessage = "This Password is too weak";
                              } else if (error
                                  .toString()
                                  .contains("EMAIL_NOT_FOUND")) {
                                errorMessage = "Could find user with email";
                              } else if (error
                                  .toString()
                                  .contains("INVALID_PASSWORD")) {
                                errorMessage = "Invalid Password";
                              }
                              _showErrorDialoug(errorMessage);
                            } catch (err) {
                              print(err);
                              var errorMessage =
                                  "Colud not autheticate you. plase try again after some minutes";
                              _showErrorDialoug(errorMessage);
                            }
                          }
                          setState(() {
                            _isLoading = false;
                          });
                          // catch()
                        },
                      ),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                              _authMode = AuthMode.Signup;
                            });
                            if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              print("Valid");
                              // print(_authData["email"]);
                              try {
                                // print(_authData["email"]);
                                final data = await Provider.of<Auth>(context,
                                        listen: false)
                                    .signUp(_authData["email"],
                                        _authData["password"]);
                                print(data);
                              } on HttpException catch (error) {
                                print("httpblock");
                                var errorMessage = "Authetication Failed";
                                if (error.toString().contains("EMAIL_EXISTS")) {
                                  errorMessage = "This Email is Already Exist";
                                } else if (error
                                    .toString()
                                    .contains("INVALID_EMAIL")) {
                                  errorMessage =
                                      "This Email Address is Invalid";
                                } else if (error
                                    .toString()
                                    .contains("WEAK_PASSWORD")) {
                                  errorMessage = "This Password is too weak";
                                } else if (error
                                    .toString()
                                    .contains("EMAIL_NOT_FOUND")) {
                                  errorMessage = "Could find user with email";
                                } else if (error
                                    .toString()
                                    .contains("INVALID_PASSWORD")) {
                                  errorMessage = "Invalid Password";
                                }
                                _showErrorDialoug(errorMessage);
                              } catch (error) {
                                print("errorblock");
                                print(error);
                              }
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
