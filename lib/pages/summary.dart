import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pdf_apis/pdf_report_api.dart';


class SummaryOf extends StatelessWidget {
  final String docId, name;
  const SummaryOf({Key? key, required this.docId, required this.name})
      : super(key: key);



  @override
  Widget build(BuildContext context) {

    FittedBox fittedBox = FittedBox();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sadhana",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
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
        //   IconButton(
        //     icon: Icon(Icons.share),
        //     onPressed: () => PDFReportAPI.generate(fittedBox)
        //   )
        // ],
      ),
      body: SummaryView(
        docId: docId,
        nameOfDevotee: name,
      ),
    );
  }
}

class SummaryView extends StatefulWidget {
  final String docId, nameOfDevotee;
  const SummaryView(
      {Key? key, required this.docId, required this.nameOfDevotee})
      : super(key: key);

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
  // String selectedMonth = DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().toString();
  int selectedMonth = DateTime.now().month;
  String getMonthInStr(int month) {
    return month >= 10 ? month.toString() : "0" + month.toString();
  }

  User? user = FirebaseAuth.instance.currentUser;


  List<DropdownMenuItem<int>> get dropDownElementsMonths {
    List<DropdownMenuItem<int>> menuItems = [
      DropdownMenuItem(child: Text("JAN"), value: 1),
      DropdownMenuItem(child: Text("FEB"), value: 2),
      DropdownMenuItem(child: Text("MAR"), value: 3),
      DropdownMenuItem(child: Text("APR"), value: 4),
      DropdownMenuItem(child: Text("MAY"), value: 5),
      DropdownMenuItem(child: Text("JUN"), value: 6),
      DropdownMenuItem(child: Text("JUL"), value: 7),
      DropdownMenuItem(child: Text("AUG"), value: 8),
      DropdownMenuItem(child: Text("SEP"), value: 9),
      DropdownMenuItem(child: Text("OCT"), value: 10),
      DropdownMenuItem(child: Text("NOV"), value: 11),
      DropdownMenuItem(child: Text("DEC"), value: 12),
    ];
    return menuItems;
  }

  // List<TableRow> _rows;

  @override
  Widget build(BuildContext context) {
    // final prefs = await SharedPreferences.getInstance();
    // Object role = prefs.get('role') ?? "null";
    // return Container(
    //   child: SingleChildScrollView(
    //     child: Text('shs'),
    //   ),
    // );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Devotee : ${widget.nameOfDevotee}'),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    // child: countryCodePicker,
                    child: Text(
                      'Month : ',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                          fontSize: 22),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
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
                            value == null ? "Select a month" : null,
                        dropdownColor: Colors.amberAccent,
                        value: selectedMonth,
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedMonth = newValue!;
                          });
                        },
                        items: dropDownElementsMonths),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.docId)
                    .collection('data')
                    .where('date',
                        isGreaterThanOrEqualTo:
                            '2022-' + getMonthInStr(selectedMonth))
                    .where('date',
                        isLessThan: '2022-' + getMonthInStr(selectedMonth + 1))
                    .orderBy('date')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }
                  if (snapshot.hasData) {
                    List<DataCell> sadhanaAvgDataCell = [];
                    List<DataCell> sadhanaDetailDataCell = [];

                    int tmap = 0, amap = 0, map;
                    double pmap = 0.0;

                    int tjapap = 0, ajapap = 0, japap;
                    double pjapap = 0.0;

                    int tdaagpp = 0, adaagpp = 0, daagpp;
                    double pdaagpp = 0.0;

                    int tsbp = 0, asbp = 0, sbp;
                    double psbpp = 0.0;

                    int trp = 0, arp = 0, rp;
                    double prpp = 0.0;

                    double osadhanap = 0.0;
                    int noDays = 0;

                    for (var item in snapshot.data!.docs) {
                      map = int.parse(item['mangala-arati-points']);
                      japap = int.parse(item['japa-points']);
                      daagpp = int.parse(item['daagp-points']);
                      sbp = int.parse(item['sb-points']);
                      rp = int.parse(item['reading']);

                      noDays++;

                      sadhanaDetailDataCell.add(
                        DataCell(
                          Text(
                            item['date'].toString().substring(8, 10),
                          ),
                        ),
                      );
                      sadhanaDetailDataCell.add(
                        DataCell(
                          Text(
                            item['mangala-arati-points'],
                          ),
                        ),
                      );

                      tmap += 8;
                      amap += map;

                      sadhanaDetailDataCell.add(
                        DataCell(
                          Text(
                            item['japa-points'],
                          ),
                        ),
                      );

                      tjapap += 8;
                      ajapap += japap;

                      sadhanaDetailDataCell.add(
                        DataCell(
                          Text(
                            item['daagp-points'],
                          ),
                        ),
                      );

                      tdaagpp += 4;
                      adaagpp += daagpp;

                      sadhanaDetailDataCell.add(
                        DataCell(
                          Text(
                            item['sb-points'].toString(),
                          ),
                        ),
                      );

                      tsbp += 4;
                      asbp += sbp;

                      sadhanaDetailDataCell.add(
                        DataCell(
                          Text(
                            item['reading'].toString(),
                          ),
                        ),
                      );

                      trp += 6;
                      arp += rp;
                      // TBD
                      sadhanaDetailDataCell.add(
                        DataCell(
                          Text((map + japap + daagpp + sbp + rp).toString()),
                        ),
                      );
                    }

                    sadhanaAvgDataCell.add(DataCell(Text('MA')));
                    sadhanaAvgDataCell.add(DataCell(Text(tmap.toString())));
                    sadhanaAvgDataCell.add(DataCell(Text(amap.toString())));
                    sadhanaAvgDataCell.add(DataCell(
                        Text((100 * amap / tmap).toStringAsPrecision(4))));

                    sadhanaAvgDataCell.add(DataCell(Text('JAPA')));
                    sadhanaAvgDataCell.add(DataCell(Text(tjapap.toString())));
                    sadhanaAvgDataCell.add(DataCell(Text(ajapap.toString())));
                    sadhanaAvgDataCell.add(DataCell(
                        Text((100 * ajapap / tjapap).toStringAsPrecision(4))));

                    sadhanaAvgDataCell.add(DataCell(Text('DA&GP')));
                    sadhanaAvgDataCell.add(DataCell(Text(tdaagpp.toString())));
                    sadhanaAvgDataCell.add(DataCell(Text(adaagpp.toString())));
                    sadhanaAvgDataCell.add(DataCell(Text(
                        (100 * adaagpp / tdaagpp).toStringAsPrecision(4))));

                    sadhanaAvgDataCell.add(const DataCell(Text('SB')));
                    sadhanaAvgDataCell.add(DataCell(Text(tsbp.toString())));
                    sadhanaAvgDataCell.add(DataCell(Text(asbp.toString())));
                    sadhanaAvgDataCell.add(DataCell(
                        Text((100 * asbp / tsbp).toStringAsPrecision(4))));

                    sadhanaAvgDataCell.add(const DataCell(Text('Reading')));
                    sadhanaAvgDataCell.add(DataCell(Text(trp.toString())));
                    sadhanaAvgDataCell.add(DataCell(Text(arp.toString())));
                    sadhanaAvgDataCell.add(DataCell(
                        Text((100 * arp / trp).toStringAsPrecision(4))));

                    osadhanap = 100*(amap+ajapap+adaagpp+asbp+arp)/(tmap+tjapap+tdaagpp+tsbp+trp);
                    
                    return Column(
                      children: [
                        FittedBox(
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Angas',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Full Points',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Actual Points',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Percentage',
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              for (int i = 0;
                                  i < sadhanaAvgDataCell.length;
                                  i += 4)
                                DataRow(cells: [
                                  sadhanaAvgDataCell[i],
                                  sadhanaAvgDataCell[i + 1],
                                  sadhanaAvgDataCell[i + 2],
                                  sadhanaAvgDataCell[i + 3]
                                ])
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text('Overall Sadhana Percentage : ' + osadhanap.toStringAsPrecision(4)),
                        ),
                        ListTile(
                          title: Text('No. of Days available for Sadhana: $noDays')
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const ListTile(
                          title: Text('Day wise Sadhana details ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        ),
                        FittedBox(
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Day',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'MAP',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'JP',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'SA&GP',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'SB',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'R',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'T',
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              for (int i = 0;
                                  i < sadhanaDetailDataCell.length;
                                  i += 7)
                                DataRow(cells: [
                                  sadhanaDetailDataCell[i],
                                  sadhanaDetailDataCell[i + 1],
                                  sadhanaDetailDataCell[i + 2],
                                  sadhanaDetailDataCell[i + 3],
                                  sadhanaDetailDataCell[i + 4],
                                  sadhanaDetailDataCell[i + 5],
                                  sadhanaDetailDataCell[i + 6]
                                ])
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              // child: Table(
              //   // columnWidths: Tab,
              //   children: [
              //     TableRow(
              //         children: <Widget>[
              //           Text('Day'),
              //           // SizedBox(
              //           //   width: 1,
              //           // ),
              //           Text('MGA'),
              //           // SizedBox(
              //           //   width: 1,
              //           // ),Text('Date'),
              //           // SizedBox(
              //           //   width: 1,
              //           // ),
              //           Text('JAPA'),
              //           // SizedBox(
              //           //   width: 1,
              //           // ),
              //           Text('SA'),
              //           // SizedBox(
              //           //   width: 1,
              //           // ),
              //           Text('SB'),
              //           // SizedBox(
              //           //   width: 1,
              //           // ),
              //           Text('R'),
              //           Text('T'),
              //         ]
              //     ),
              //     TableRow(
              //         children: <Widget>[
              //           // Flexible(
              //           //   flex: 1,
              //           //   child: Text('Day'),
              //           // ),
              //           // Flexible(
              //           //     flex: 1,
              //           //     child: Text('Day'),
              //           // ),
              //           // Flexible(
              //           //     flex: 1,
              //           //     child: Text('Day'),
              //           // ),
              //           // Flexible(
              //           //     flex: 1,
              //           //     child: Text('Day'),
              //           // ),
              //           // Flexible(
              //           //     flex: 1,
              //           //     child: Text('Day'),
              //           // ),
              //           // Flexible(
              //           //     flex: 1,
              //           //     child: Text('Day'),
              //           // ),
              //           // Flexible(
              //           //     flex: 1,
              //           //     child: Text('Day'),
              //           // ),
              //           Text('1'),
              //           Text('8'),
              //           Text('4'),
              //           Text('1'),
              //           Text('1'),
              //           Text('1'),
              //           Text('1'),
              //         ]
              //     ),
              //   ],
              // ),
            )
          ],
        ),
      ),
    );
  }
}

/*

class SummaryView extends StatelessWidget {
  const SummaryView({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: const [
              ListTile(
                title: Text('Summary'),
              ),
              Card(
                child: Text('Devotee Name'),
              ),
              GridView.count(
                  crossAxisCount: 7,
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */
