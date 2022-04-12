
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/splash_screen.dart';
import 'package:my_app/pages/summary.dart';
import 'package:my_app/pages/widgets/header_widget.dart';
import 'package:my_app/pages/profile_page.dart';

import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';
import 'registration_page.dart';

class Dashboard extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
     return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard>{

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

  late String _setDate;
  late double _height,_width;

  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  Object? val;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
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
        actions: [
          Container(
            margin: EdgeInsets.only( top: 16, right: 16,),
            child: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
                    constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
                    child: Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ]
              )
          ) ,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text("Welcome to Sadhana",
                    style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // ListTile(
              //   leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor,),
              //   title: Text('Splash Screen', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Splash Screen")));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
              //   title: Text('Login Page', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
              //   ),
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Profile Page', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              // ListTile(
              //   leading: Icon(Icons.person_add_alt_1, size: _drawerIconSize,color: Theme.of(context).accentColor),
              //   title: Text('Registration Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()),);
              //   },
              // ),
              // Divider(color: Theme.of(context).primaryColor, height: 1,),
              // ListTile(
              //   leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
              //   title: Text('Forgot Password Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              //   onTap: () {
              //     Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
              //   },
              // ),
              // Divider(color: Theme.of(context).primaryColor, height: 1,),
              // ListTile(
              //   leading: Icon(Icons.verified_user_sharp, size: _drawerIconSize,color: Theme.of(context).accentColor,),
              //   title: Text('Verification Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              //   onTap: () {
              //     Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage()), );
              //   },
              // ),
              // Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.dashboard,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Dashboard', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.dashboard,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Summary', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SummaryView()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // const Text(
              //   'You have pushed the button this many times:',
              // ),
              // Text(
              //   '$_counter',
              //   style: Theme.of(context).textTheme.headline4,
              // ),
              // ListTile(
              //   leading: Icon(Icons.album),
              //   title: Text('Date'),
              //   subtitle: Text('Choose date')
              // ),
              const SizedBox(
                  height: 30
              ),
              const Text(
                'Choose Date',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    fontSize: 25
                ),
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  // width: _width / 1.7,
                  // height: _height / 9,
                  margin: EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextFormField(
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _dateController,
                    onSaved: (String? val) {
                      _setDate = val!;
                    },
                    decoration: const InputDecoration(
                        disabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.only(top: 0.0)),
                  ),
                ),
              ),
              const SizedBox(
                  height: 30
              ),
              const Text(
                'Early Japa Before 10 A.M.',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    fontSize: 22
                ),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 25
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Flexible(
                    flex: 4,
                    child: Text(
                        'rounds',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            fontSize: 25
                        )
                    ),
                  )
                ],
              ),
              const SizedBox(
                  height: 30
              ),
              const Text(
                'Late Japa After 10 A.M.',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    fontSize: 22
                ),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 25
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Flexible(
                    flex: 4,
                    child: Text(
                        'rounds',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            fontSize: 25
                        )
                    ),
                  )
                ],
              ),
              const SizedBox(
                  height: 40
              ),
              const Text(
                'Reading',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    fontSize: 22
                ),
                textAlign: TextAlign.start,
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 25
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Flexible(
                    flex: 4,
                    child: Text(
                        'minutes',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            fontSize: 25
                        )
                    ),
                  )
                ],
              ),
              const SizedBox(
                  height: 30
              ),
              const Text(
                'Hearing',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    fontSize: 22
                ),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 25
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Flexible(
                    flex: 4,
                    child: Text(
                        'minutes',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            fontSize: 25
                        )
                    ),
                  )
                ],
              ),
              const SizedBox(
                  height: 30
              ),
              const Text(
                'Mangala Aarati',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    fontSize: 22
                ),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: ListTile(
                      title: const Text("Yes"),
                      leading:Radio(
                        value: 1,
                        groupValue:val,
                        onChanged: (value) {
                          setState(() {
                            val = value;
                            print(val);
                          });
                        },
                        activeColor: Colors.green,
                        toggleable: true,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ListTile(
                      title: const Text("No"),
                      leading:Radio(
                        value: 1,
                        groupValue:val,
                        onChanged: (value) {
                          setState(() {
                            val = value;
                            print(val);
                          });
                        },
                        activeColor: Colors.red,
                        toggleable: true,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                  height: 30
              ),
              Container(
                width:double.infinity ,
                padding: EdgeInsets.all(20),
                alignment: Alignment.topCenter,
                child:const ElevatedButton(
                  child: Text('Submit'),
                  onPressed: null,
                )
              )
            ],
          ),
          padding: const EdgeInsets.only(left: 20.0),
        ),
      ),
    );
  }

}

/*
SingleChildScrollView(
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
                  Text('Mr. Donald Trump', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text('Former President', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "User Information",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          leading: Icon(Icons.my_location),
                                          title: Text("Location"),
                                          subtitle: Text("USA"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text("Email"),
                                          subtitle: Text("donaldtrump@gmail.com"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone),
                                          title: Text("Phone"),
                                          subtitle: Text("99--99876-56"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.person),
                                          title: Text("About Me"),
                                          subtitle: Text(
                                              "This is a about me link and you can khow about me in this section."),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
 */



// .collection("data")
// .where("", "array-contains", "**-04-2022")