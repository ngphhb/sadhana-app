
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/pages/splash_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISKCON Sadhna',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
      // home: const MyHomePage(title: 'ISKCON Sadhna'),
      home: SplashScreen(title: 'Login UI',),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _setDate;
  late double _height,_width;
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Object? val;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, textAlign: TextAlign.center),
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
            ],
          ),
          padding: const EdgeInsets.only(left: 20.0),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
