import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/widgets/header_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Object name='null',email='null';
    Future<void> getUserDetails() async {
      final prefs = await SharedPreferences.getInstance();
      name = prefs.get('name') ?? "null";
      name = prefs.get('email') ?? "null";
    }
    getUserDetails();
    String userName = "null",userEmail="null";
    User? user = FirebaseAuth.instance.currentUser;
    userName = user?.displayName ?? "null";
    userEmail = user?.email ?? "null";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sadhana",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
              )
          ),
        ),
        // actions: [
        //   Container(
        //     margin: EdgeInsets.only( top: 16, right: 16,),
        //     child: Stack(
        //       children: <Widget>[
        //         Icon(Icons.notifications),
        //         Positioned(
        //           right: 0,
        //           child: Container(
        //             padding: EdgeInsets.all(1),
        //             decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
        //             constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
        //             child: Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
        //           ),
        //         )
        //       ],
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 20, offset: const Offset(5, 5),),
                      ],
                    ),
                    child: Icon(Icons.person, size: 80, color: Colors.grey.shade300,),
                  ),
                  SizedBox(height: 20,),
                  // Text('Mr. Donald Trump', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  Text(userName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  // Text('this part of app is under development', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text(userEmail, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  // Container(
                  //   padding: EdgeInsets.all(10),
                  //   child: Column(
                  //     children: <Widget>[
                  //       Container(
                  //         padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                  //         alignment: Alignment.topLeft,
                  //         child: Text(
                  //           "User Information",
                  //           style: TextStyle(
                  //             color: Colors.black87,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 16,
                  //           ),
                  //           textAlign: TextAlign.left,
                  //         ),
                  //       ),
                  //       Card(
                  //         child: Container(
                  //           alignment: Alignment.topLeft,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             children: <Widget>[
                  //               Column(
                  //                 children: <Widget>[
                  //                   ...ListTile.divideTiles(
                  //                     color: Colors.grey,
                  //                     tiles: [
                  //                       ListTile(
                  //                         contentPadding: EdgeInsets.symmetric(
                  //                             horizontal: 12, vertical: 4),
                  //                         leading: Icon(Icons.my_location),
                  //                         title: Text("Location"),
                  //                         subtitle: Text("USA"),
                  //                       ),
                  //                       ListTile(
                  //                         leading: Icon(Icons.email),
                  //                         title: Text("Email"),
                  //                         subtitle: Text("donaldtrump@gmail.com"),
                  //                       ),
                  //                       ListTile(
                  //                         leading: Icon(Icons.phone),
                  //                         title: Text("Phone"),
                  //                         subtitle: Text("99--99876-56"),
                  //                       ),
                  //                       ListTile(
                  //                         leading: Icon(Icons.person),
                  //                         title: Text("About Me"),
                  //                         subtitle: Text(
                  //                             "This is a about me link and you can khow about me in this section."),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
