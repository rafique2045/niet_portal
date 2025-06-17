// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:niet_portal/comoponents/custom_widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  var ktextStyle = GoogleFonts.ibmPlexSans();

  var kTitleStyle = GoogleFonts.ibmPlexSans(
      fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);

  var kSubTitleStyle = GoogleFonts.ibmPlexSans(
    fontSize: 15,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(items: []),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),

        //main Column , Everything will be Under these
        child: Column(
          // Header
          children: [
            _headerSection("Md Rafique", Icons.person),
            SizedBox(
              height: 12,
            ),
            _attendenceSection(),
            SizedBox(
              height: 12,
            ),
            accountStatus(),
            SizedBox(
              height: 12,
            ),
            _messageBox(),
            SizedBox(
              height: 12,
            ),
            RoutineSection(),
          ],
        ),
      ),
    );
  }

//Message Sectoin
  Widget _messageBox() {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.only(top: 10),
      height: 300,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 8,
          ),
          Expanded(
              flex: 1,
              child: Text(
                'Messages',
                style: kTitleStyle,
              )),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  MessageTile(
                    kTitleStyle: kTitleStyle,
                    kSubTitleStyle: kSubTitleStyle,
                    title: "Class Test will be Held on 05 April",
                    subTitle: "Dear Concern, According to academic …",
                  ),
                  MessageTile(
                    kTitleStyle: kTitleStyle,
                    kSubTitleStyle: kSubTitleStyle,
                    title: "Payment Received",
                    subTitle: "Dear Concern, Exam fee paid 1000tk on…",
                  ),
                  MessageTile(
                    kTitleStyle: kTitleStyle,
                    kSubTitleStyle: kSubTitleStyle,
                    title: "Your child is absent today classes",
                    subTitle: "Dear Concern, Your Child Md Rafique is absent…",
                  ),
                  MessageTile(
                    kTitleStyle: kTitleStyle,
                    kSubTitleStyle: kSubTitleStyle,
                    title: "Payment Received",
                    subTitle: "Dear Concern, Exam fee paid 1000tk on…",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Class Routine
  Widget accountStatus() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            height: 120,
            child: Card(
              color: Colors.greenAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Paid",
                    style: ktextStyle.copyWith(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "৳ 73000",
                    style: ktextStyle.copyWith(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            height: 120,
            child: Card(
              color: Colors.pink[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dues",
                    style: ktextStyle.copyWith(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "৳ 2600",
                    style: ktextStyle.copyWith(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

//Attendence Section
  Widget _attendenceSection() {
    int value = 70;
    int value2 = 30;

    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        //height: 200,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.blue[300], borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Attendance',
                style: ktextStyle.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: PieChart(PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: value.toDouble(),
                          color: Colors.greenAccent,
                          title: '$value%',
                          titleStyle: ktextStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          radius: 50,
                        ),
                        PieChartSectionData(
                            radius: 50,
                            value: value2.toDouble(),
                            color: Colors.pinkAccent,
                            title: '$value2%',
                            titleStyle: ktextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ],
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 10,
                              width: 15,
                              child: Container(
                                color: Colors.greenAccent,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Present',
                              style: ktextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 10,
                              width: 15,
                              child: Container(
                                color: Colors.pinkAccent,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Absent',
                              style: ktextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//Header Widget
  Widget _headerSection(String name, IconData icon) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 25),
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(13),
          bottomRight: Radius.circular(13),
        ),
      ),
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello,",
                style: ktextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                name,
                style: ktextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Text(
            'NIET PORTAL',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: 8,
          ),
          CircleAvatar(
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 107, 11, 75),
              shadows: [
                Shadow(color: Colors.blueAccent),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.kTitleStyle,
    required this.kSubTitleStyle,
    required this.title,
    required this.subTitle,
  });

  final TextStyle kTitleStyle;
  final TextStyle kSubTitleStyle;
  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[200],
      child: ListTile(
        title: Text(
          title,
          style: kTitleStyle,
        ),
        subtitle: Text(
          subTitle,
          style: kSubTitleStyle,
        ),
      ),
    );
  }
}
