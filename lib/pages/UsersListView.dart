import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/summary.dart';

import 'summary.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({Key? key}) : super(key: key);

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  bool _load = false;
  int _itemCount = 0;
  Future<List<Widget>> loadUsers() async {
    // CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");
    // QuerySnapshot snapshot = collectionReference.get();

    List<Widget> list = List<Widget>.empty();
    try{
      final QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').get();
      for(var doc in snapshot.docs){
        list.add(
            SizedBox(
              height: 30,
            ));
        list.add(
          ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text(doc['name']),
          ),
        );

        for(var doc in snapshot.docs){
          print(doc['name']);
        }
      }
    }
    catch (e){
      print(e.toString());
    }

    // _itemCount = snapshot.docs.length;

    // if(sn)



    return list;
    // return snapshot.docs;
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
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else {
      //       return ListView(
      //         children: snapshot.data?.docs.map((document) {
      //           // return Center(
      //           //   child: SizedBox(
      //           //     width: MediaQuery.of(context).size.width / 1.2,
      //           //     height: MediaQuery.of(context).size.height / 6,
      //           //     child: Text("Title: " + document['title']),
      //           //   ),
      //           // );
      //            Container(
      //             child: Text('wh'),
      //           ),
      //         ).toList(),
      //       );
      //     }
      //   },
      // ),
      // body: !_load ?
      // SingleChildScrollView(
      //   // child: ListView(
      //   //   children: [
      //   //     ListTile(
      //   //       title: Text('hi'),
      //   //     )
      //   //   ],
      //   //   // children: loadUsers(),
      //   // ),
      //   child: Column(
      //     children: [
      //       const SizedBox(
      //           height: 30
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.account_box_rounded),
      //         title: Text('User name'),
      //         onTap: () {
      //
      //         },
      //       ),
      //       const SizedBox(
      //           height: 30
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.account_box_rounded),
      //         title: Text('User name'),
      //       ),
      //       const SizedBox(
      //           height: 30
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.account_box_rounded),
      //         title: Text('User name'),
      //       ),
      //       // loadUsers(),
      //       // for( var doc in loadUsers()){
      //       //   SizedBox(
      //       //       height: 30
      //       //   ),
      //       //   ListTile(
      //       //     leading: Icon(Icons.account_box_rounded),
      //       //     title: Text('User name'),
      //       //   ),
      //       // },
      //       FutureBuilder<List<Widget>>(
      //           future: loadUsers(),
      //           builder: (context, future){
      //             if(!future.hasData) {
      //               return Container();
      //             } else {
      //               List<Widget>? list = future.data;
      //               return ListView(
      //                 children: future.data!,
      //               );
      //               // return ListView.builder(
      //               //     itemCount: list?.length,
      //               //     itemBuilder: (context, index){
      //               //       return // Your widget Here ; // Put your widget, such as container, decoratedBox, listTiles, button etc
      //               //     }
      //               // );
      //             }
      //           }
      //       ),
      //     ],
      //   ),
      // ) : const Center(
      //   child: CircularProgressIndicator(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                leading: const Icon(Icons.account_box_rounded),
                title: Text(data['name']),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SummaryOf(docId: document.id,name: document['name'])),);
                },
                // subtitle: Text(data['company']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
