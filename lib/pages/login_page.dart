import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/common/theme_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password_page.dart';
import 'dashboard.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '', _password = '';
  // bool _showPassword = true;
  bool _load = true;

  User? result = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      const Text(
                        'Sadhana',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Signin into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper()
                            .buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                40, 10, 40, 10),
                            child: Text(
                              'Google Sign In / Sign Up'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            result != null ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Dashboard())) : {
                              // _load ? Center(
                              //   child: CircularProgressIndicator(),
                              // ) : Container(),
                              signIn()
                            };
                          },
                        ),
                      )

                      // Form(
                      //     key: _formKey,
                      //     child: Column(
                      //       children: [
                      //         Container(
                      //           child: TextField(
                      //             onChanged: (input) => _email = input,
                      //             keyboardType: TextInputType.emailAddress,
                      //             decoration: ThemeHelper().textInputDecoration(
                      //                 'User Name', 'Enter your user name'),
                      //           ),
                      //           decoration:
                      //               ThemeHelper().inputBoxDecorationShaddow(),
                      //         ),
                      //         const SizedBox(height: 30.0),
                      //         Container(
                      //           child: TextField(
                      //             obscureText: true,
                      //             onChanged: (input) => _password = input,
                      //             keyboardType: TextInputType.visiblePassword,
                      //             decoration: ThemeHelper().textInputDecoration(
                      //                 'Password', 'Enter your password'),
                      //           ),
                      //           decoration:
                      //               ThemeHelper().inputBoxDecorationShaddow(),
                      //         ),
                      //         const SizedBox(height: 15.0),
                      //         Container(
                      //           margin:
                      //               const EdgeInsets.fromLTRB(10, 0, 10, 20),
                      //           alignment: Alignment.topRight,
                      //           child: GestureDetector(
                      //             onTap: () {
                      //               Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         ForgotPasswordPage()),
                      //               );
                      //             },
                      //             child: const Text(
                      //               "Forgot your password?",
                      //               style: TextStyle(
                      //                 color: Colors.grey,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         !_load
                      //             ? Container(
                      //                 decoration: ThemeHelper()
                      //                     .buttonBoxDecoration(context),
                      //                 child: ElevatedButton(
                      //                   style: ThemeHelper().buttonStyle(),
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.fromLTRB(
                      //                         40, 10, 40, 10),
                      //                     child: Text(
                      //                       'Sign In'.toUpperCase(),
                      //                       style: const TextStyle(
                      //                           fontSize: 20,
                      //                           fontWeight: FontWeight.bold,
                      //                           color: Colors.white),
                      //                     ),
                      //                   ),
                      //                   onPressed: () {
                      //                     RegExp regExp = RegExp(
                      //                         r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
                      //                     final formState =
                      //                         _formKey.currentState;
                      //                     formState?.save();
                      //                     if (_email.isEmpty) {
                      //                       ScaffoldMessenger.of(context)
                      //                           .showSnackBar(const SnackBar(
                      //                               content: Text(
                      //                                   'Email Cannot be empty')));
                      //                     } else if (_password.length < 6) {
                      //                       ScaffoldMessenger.of(context)
                      //                           .showSnackBar(const SnackBar(
                      //                               content: Text(
                      //                                   'Password needs to be atleast six characters')));
                      //                     } else if (!regExp.hasMatch(_email)) {
                      //                       ScaffoldMessenger.of(context)
                      //                           .showSnackBar(const SnackBar(
                      //                               content: Text(
                      //                                   'Enter a Valid Email')));
                      //                     } else {
                      //                       setState(() {
                      //                         _load = true;
                      //                       });
                      //                       signIn();
                      //                       // //After successful login we will redirect to profile page. Let's create profile page now
                      //                       // Navigator.pushReplacement(
                      //                       //     context,
                      //                       //     MaterialPageRoute(
                      //                       //         builder: (context) =>
                      //                       //             Dashboard()));
                      //                     }
                      //                   },
                      //                 ),
                      //               )
                      //             : const Center(
                      //                 child: CircularProgressIndicator(),
                      //               ),
                      //         Container(
                      //           margin:
                      //               const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      //           //child: Text('Don\'t have an account? Create'),
                      //           child: Text.rich(TextSpan(children: [
                      //             TextSpan(text: "Don\'t have an account? "),
                      //             TextSpan(
                      //               text: 'Create',
                      //               recognizer: TapGestureRecognizer()
                      //                 ..onTap = () {
                      //                   Navigator.push(
                      //                       context,
                      //                       MaterialPageRoute(
                      //                           builder: (context) =>
                      //                               RegistrationPage()));
                      //                 },
                      //               style: TextStyle(
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Theme.of(context).accentColor),
                      //             ),
                      //           ])),
                      //         ),
                      //       ],
                      //     )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signIn() async {
    // try {
    //   AuthResult result = await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: _email, password: _password);
    //   FirebaseUser user = result.user;
    //
    //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
    //       .collection('users')
    //       .document(user.uid)
    //       .get();
    //
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString('email', user.email);
    //   prefs.setString('role', snapshot['role']);
    //   print(snapshot['role']);
    //   prefs.setString('userid', user.uid);
    //   setState(() {
    //     _load = false;
    //   });
    //   Navigator.of(context).pushReplacementNamed('home');
    // } catch (e) {
    //   setState(() {
    //     _load = false;
    //   });
    //   print(e.toString());
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(e.toString())));
    // }

    try {
      // final result = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(email: _email, password: _password);

      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      final UserCredential authResult = await firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;

      // User? user = result?.user;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();

      if (!snapshot.exists) {
        CollectionReference data = FirebaseFirestore.instance
            .collection('users');
        data.doc(user?.uid).set({
          "name": user?.displayName,
          "email": user?.email,
          "role": "DEVOTEE"
        });
        snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .get();
      }

      storeUserInSharedPreferences('email',user?.email);
      storeUserInSharedPreferences('userid',user?.uid);
      storeUserInSharedPreferences('name',user?.displayName);
      storeUserInSharedPreferences('role',snapshot['role']);
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      //
      // prefs.setString('email', user?.email);
      // prefs.setString('role', snapshot['role']);
      // print(snapshot['role']);
      // prefs.setString('userid', user?.uid);
      print("Logged in");
      if(mounted)
        setState(() {
        _load = false;
      });
      // Navigator.of(context).pushReplacementNamed('home');
      //After successful login we will redirect to profile page. Let's create profile page now
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Dashboard()));
    } on FirebaseAuthException catch (e) {

      if(mounted)
        setState(() {
        _load = false;
      });
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No user found for that email.")));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Wrong password provided for that user.")));
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> storeUserInSharedPreferences(String key, String? newCity) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, newCity!);
  }
}
