import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:my_app/common/theme_helper.dart';
import 'package:my_app/pages/UsersListView.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/pages/summary.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';
import 'registration_page.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  String? selectedValueMA = null,
      selectedValueJapa = null,
      selectedValueDAAGP = null,
      selectedValueSB = null,
      selectedValueReading = null;

  void resetValues() {
    setState(() {
      selectedValueMA = null;
      selectedValueJapa = null;
      selectedValueDAAGP = null;
      selectedValueSB = null;
      selectedValueReading = null;
    });
  }

  final _dropdownFormKey = GlobalKey<FormState>();

  var isSuccessful = false, errMessage = "";

  double _drawerIconSize = 24;
  double _drawerFontSize = 17;

  late String _setDate = DateTime.now().toString();
  late double _height, _width;

  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController(
    text: DateFormat.yMd().format(DateTime.now()),
  );

  Object? val;

  User? user = FirebaseAuth.instance.currentUser;

  List<DropdownMenuItem<String>> get dropDownElementsMA {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("AS"), value: "08"),
      DropdownMenuItem(child: Text("3:00am - 4:35am"), value: "8"),
      DropdownMenuItem(child: Text("4:35am - 4:47am"), value: "4"),
      DropdownMenuItem(child: Text("4:47am - 5:15am"), value: "2"),
      DropdownMenuItem(child: Text("Absent"), value: "0"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropDownElementsJapa {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("AS"), value: "08"),
      DropdownMenuItem(child: Text("Completing 16R before 7:15am"), value: "8"),
      DropdownMenuItem(
          child: Text("Completing 16R before 10:00am"), value: "6"),
      DropdownMenuItem(child: Text("Completing 16R before 1:00pm"), value: "4"),
      DropdownMenuItem(child: Text("Completing 16R before 5:30pm"), value: "1"),
      DropdownMenuItem(child: Text("Absent"), value: "0"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropDownElementsDAAGP {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("AS"), value: "04"),
      DropdownMenuItem(child: Text("7:15am- 7:20am"), value: "4"),
      DropdownMenuItem(child: Text("7:20am-7:45am"), value: "2"),
      DropdownMenuItem(child: Text("7:45am-8:00am"), value: "1"),
      DropdownMenuItem(child: Text("Absent"), value: "0"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropDownElementsSB {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("AS"), value: "04"),
      DropdownMenuItem(child: Text("8:00am-8:10am"), value: "4"),
      DropdownMenuItem(child: Text("8:10am-8:20am"), value: "2"),
      DropdownMenuItem(child: Text("8:20am-8:30am"), value: "1"),
      DropdownMenuItem(child: Text("Absent"), value: "0"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropDownElementsReading {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("AS"), value: "06"),
      DropdownMenuItem(child: Text("60 mins and above"), value: "6"),
      DropdownMenuItem(child: Text("45min - 60 min"), value: "4"),
      DropdownMenuItem(child: Text("30min - 45 min"), value: "2"),
      DropdownMenuItem(child: Text("15min - 30min"), value: "1"),
      DropdownMenuItem(child: Text("Absent"), value: "0"),
    ];
    return menuItems;
  }

  // Future<void> addUser() {
  //   // Call the user's CollectionReference to add a new user
  //   return data
  //       .add({
  //     'date' : _setDate,
  //     'mangala-arati-points' : selectedValueMA,
  //     'japa-points' : selectedValueJapa,
  //     'daagp-points' : selectedValueDAAGP,
  //     'sb-points' : selectedValueSB,
  //     'reading' : selectedValueReading
  //     // 'full_name': fullName, // John Doe
  //     // 'company': company, // Stokes and Sons
  //     // 'age': age // 42
  //   })
  //       .then((value) => print("Data Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

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
        _dropdownFormKey.currentState?.reset();
        resetValues();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sadhana",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ])),
        ),
        // actions: [
        //   Container(
        //     margin: EdgeInsets.only(
        //       top: 16,
        //       right: 16,
        //     ),
        //     child: Stack(
        //       children: <Widget>[
        //         Icon(Icons.notifications),
        //         Positioned(
        //           right: 0,
        //           child: Container(
        //             padding: EdgeInsets.all(1),
        //             decoration: BoxDecoration(
        //               color: Colors.red,
        //               borderRadius: BorderRadius.circular(6),
        //             ),
        //             constraints: BoxConstraints(
        //               minWidth: 12,
        //               minHeight: 12,
        //             ),
        //             child: Text(
        //               '5',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 8,
        //               ),
        //               textAlign: TextAlign.center,
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   )
        // ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [
                0.0,
                1.0
              ],
                  colors: [
                Theme.of(context).primaryColor.withOpacity(0.2),
                Theme.of(context).accentColor.withOpacity(0.5),
              ])),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Welcome to Sadhana",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor),
                title: Text(
                  'Profile Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.dashboard,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor),
                title: Text(
                  'Dashboard',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.dashboard,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor),
                title: Text(
                  'Summary',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  Object id = prefs.get('userid') ?? "null";
                  Object name = prefs.get('name') ?? "null";
                  Object role = prefs.get('role') ?? "null";
                  if (role.toString().compareTo("DEVOTEE") == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SummaryOf(
                                docId: id.toString(),
                                name: name.toString(),
                              )),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UsersListView()),
                    );
                  }
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () async {
                  try {
                    await GoogleSignIn().signOut();
                    await FirebaseAuth.instance.signOut();
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    // prefs.setString('email', Null);
                    // prefs.setString('role', null);
                    // prefs.setString('userid', null);
                    // Navigator.of(context).pushReplacementNamed('login');
                    SystemNavigator.pop();
                  } catch (e) {
                    print(e.toString());
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                  // SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _dropdownFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Padding(
                //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                //   child: Text(
                //     'Choose appropriate options for following Sadhana Angas',
                //     style: TextStyle(
                //       fontSize: 20,
                //       // fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 30),
                const Text(
                  'Choose Date',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      fontSize: 22),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    // width: _width / 1.7,
                    // height: _height / 9,
                    margin: const EdgeInsets.fromLTRB(60, 5, 60, 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                const SizedBox(height: 30),
                const Text(
                  'Mangala Arati',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.amber,
                      ),
                      validator: (value) =>
                          value == null ? "Select an option" : null,
                      dropdownColor: Colors.amberAccent,
                      value: selectedValueMA,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValueMA = newValue!;
                        });
                      },
                      items: dropDownElementsMA),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Japa',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.amber,
                      ),
                      validator: (value) =>
                          value == null ? "Select an option" : null,
                      dropdownColor: Colors.amberAccent,
                      value: selectedValueJapa,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValueJapa = newValue!;
                        });
                      },
                      items: dropDownElementsJapa),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Darshana Arati & Guru Pooja',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.amber,
                      ),
                      validator: (value) =>
                          value == null ? "Select an option" : null,
                      dropdownColor: Colors.amberAccent,
                      value: selectedValueDAAGP,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValueDAAGP = newValue!;
                        });
                      },
                      items: dropDownElementsDAAGP),
                ),
                const SizedBox(height: 30),
                const Text(
                  'SB Class',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.amber,
                      ),
                      validator: (value) =>
                          value == null ? "Select an option" : null,
                      dropdownColor: Colors.amberAccent,
                      value: selectedValueSB,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValueSB = newValue!;
                        });
                      },
                      items: dropDownElementsSB),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Reading',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.amber,
                      ),
                      validator: (value) =>
                          value == null ? "Select an option" : null,
                      dropdownColor: Colors.amberAccent,
                      value: selectedValueReading,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValueReading = newValue!;
                        });
                      },
                      items: dropDownElementsReading),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    onPressed: () async {
                      if (_dropdownFormKey.currentState!.validate()) {
                        final prefs = await SharedPreferences.getInstance();
                        Object userid = prefs.get('userid') ?? "null";
                        // if null need to handle
                        CollectionReference data = FirebaseFirestore.instance
                            .collection('users')
                            .doc(userid.toString())
                            .collection("data");

                        // Update id document exits TBD

                        // FirebaseFirestore.instance
                        //     .collection('users')
                        //     .where('age', isGreaterThan: 20)
                        //     .get()
                        //     .then( (data) {
                        //       for (var doc in data.docs) {
                        //         doc.update({
                        //
                        //         });
                        //       }
                        // });

                        // DocumentSnapshot doc = data
                        //     .where('date',
                        //         isEqualTo:
                        //             selectedDate.toString().split(" ")[0])
                        //     .get() as DocumentSnapshot<Object?>;

                        // data.where('date', isEqualTo: selectedDate.toString().split(" ")[0]).get().then((value) {
                        //   for( var doc in value.docs){
                        //     doc.reference.delete();
                        //   }
                        // });

                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(userid.toString())
                            .collection("data")
                            .where('date',
                                isEqualTo:
                                    selectedDate.toString().split(" ")[0])
                            .get()
                            .then((value) {
                          if (value.docs.isNotEmpty) {
                            for (var doc in value.docs) {
                              doc.reference.set({
                                'date': selectedDate.toString().split(" ")[0],
                                'mangala-arati-points': selectedValueMA,
                                'japa-points': selectedValueJapa,
                                'daagp-points': selectedValueDAAGP,
                                'sb-points': selectedValueSB,
                                'reading': selectedValueReading
                              }, SetOptions(merge: true));
                              Fluttertoast.showToast(
                                  msg: "Updated. Hare Krishna!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(),
                                ));
                            //       for ( var doc in value.docs){
                            //
                            //         ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                            //           content: Text('Updated. Hare Krishna!'), backgroundColor: Colors.green,
                            //         ));
                            //
                            //         // _onAlertWithCustomImagePressed(context) {
                            //         //   Alert(
                            //         //     context: context,
                            //         //     title: "RFLUTTER ALERT",
                            //         //     desc: "Flutter is more awesome with RFlutter Alert.",
                            //         //     i
                            //         //     // image: ImageIcon(Icons.done_all_outlined),
                            //         //   ).show();
                            //         // }
                            //
                            // // ElevatedButton(
                            // // child: Text('mnmn'),
                            // // onPressed: () => _onAlertWithCustomImagePressed(context),
                            // // );
                            //       }

                          } else {
                            data.add({
                              'date': selectedDate.toString().split(" ")[0],
                              'mangala-arati-points': selectedValueMA,
                              'japa-points': selectedValueJapa,
                              'daagp-points': selectedValueDAAGP,
                              'sb-points': selectedValueSB,
                              'reading': selectedValueReading
                            }).then((value) async {
                              print("Data Added");
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(const SnackBar(
                              //   content: Text('Successful'),
                              //   backgroundColor: Colors.green,
                              // ));
                              Fluttertoast.showToast(
                                  msg: "Successful",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Dashboard(),
                                  ));
                            }).catchError((error) {
                              print("Failed to submit: $error");
                              errMessage = error.toString();
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(SnackBar(
                              //   content: Text("Failed to submit: $error"),
                              //   backgroundColor: Colors.red,
                              // ));

                                Fluttertoast.showToast(
                                    msg: "Failed to Submit. Error :$errMessage",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard(),
                              ));

                            });
                          }
                        }).catchError((value) {
                          print("Failed to submit: $value");
                          errMessage = value.toString();
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //   content: Text("Failed to submit: $value"),
                          // ));

                            Fluttertoast.showToast(
                                msg: "Failed to Submit. Error :$errMessage",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard(),
                          ));
                        });

                        // QueryDocumentSnapshot doc = data
                        //     .where('date',
                        //     isEqualTo:
                        //     selectedDate.toString().split(" ")[0])
                        //     .get() as QueryDocumentSnapshot<Object?>;
                        // if (doc.exists){
                        //   print("exists");
                        //   data.doc(doc.id).set(
                        //     {
                        //       'date': selectedDate.toString().split(" ")[0],
                        //       'mangala-arati-points': selectedValueMA,
                        //       'japa-points': selectedValueJapa,
                        //       'daagp-points': selectedValueDAAGP,
                        //       'sb-points': selectedValueSB,
                        //       'reading': selectedValueReading
                        //     }
                        //   ).then((value) {
                        //     print("Data Updated");
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(const SnackBar(
                        //       content: Text('Updated'),
                        //     ));
                        //   }).catchError((error) {
                        //     print("Failed to Updated user req: $error");
                        //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //       content: Text("Failed to Updated user req: $error"),
                        //     ));
                        //   });
                        // }

                        // QueryDocumentSnapshot doc = data
                        //     .where('date',
                        //         isEqualTo:
                        //             selectedDate.toString().split(" ")[0])
                        //     .get() as QueryDocumentSnapshot<Object?>;
                        // if (doc.exists) {
                        //   doc.reference.update({
                        //     'date': selectedDate.toString().split(" ")[0],
                        //     'mangala-arati-points': selectedValueMA,
                        //     'japa-points': selectedValueJapa,
                        //     'daagp-points': selectedValueDAAGP,
                        //     'sb-points': selectedValueSB,
                        //     'reading': selectedValueReading
                        //   });
                        // }
                        // else {

                        // print("doesn't exists creating");
                        // data.add({
                        //   'date': selectedDate.toString().split(" ")[0],
                        //   'mangala-arati-points': selectedValueMA,
                        //   'japa-points': selectedValueJapa,
                        //   'daagp-points': selectedValueDAAGP,
                        //   'sb-points': selectedValueSB,
                        //   'reading': selectedValueReading
                        // }).then((value) {
                        //   print("Data Added");
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(const SnackBar(
                        //     content: Text('Data Added'),
                        //   ));
                        // }).catchError((error) {
                        //   print("Failed to add user: $error");
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: Text("Failed to add user: $error"),
                        //   ));
                        // });

                        // _dropdownFormKey.currentState?.reset();
                        // resetValues();
                        // if(isSuccessful==true) {
                        //   Fluttertoast.showToast(
                        //     msg: "Successful",
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.CENTER,
                        //     timeInSecForIosWeb: 1,
                        //     backgroundColor: Colors.green,
                        //     textColor: Colors.white,
                        //     fontSize: 16.0
                        // );
                        // }
                        // else{
                        //   Fluttertoast.showToast(
                        //       msg: "Failed to Submit. Error :$errMessage",
                        //       toastLength: Toast.LENGTH_SHORT,
                        //       gravity: ToastGravity.CENTER,
                        //       timeInSecForIosWeb: 1,
                        //       backgroundColor: Colors.red,
                        //       textColor: Colors.white,
                        //       fontSize: 16.0
                        //   );
                        // }

                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => Dashboard(),
                        // ));

                      }
                      // }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        'Submit'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            )),
      ),
    );
  }
}

/*
Container(
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
        )
 */

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
