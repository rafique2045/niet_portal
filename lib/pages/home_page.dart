// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:niet_portal/comoponents/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var kTextStyle = GoogleFonts.ibmPlexSans();

  var kTitleStyle = GoogleFonts.ibmPlexSans(
      fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);

  var kSubTitleStyle = GoogleFonts.ibmPlexSans(
    fontSize: 15,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        toolbarHeight: 60,
        centerTitle: true,
        title: Text(
          'NIET PORTAL',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Hi, Rafique",
            style: kTextStyle.copyWith(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
            //textAlign: TextAlign.start,
          ),
        ),
      ),
      body: SingleChildScrollView(
        //main Column , Everything will be Under these
        child: Column(
          // Header
          children: [
            // _headerSection("Md Rafique", Icons.person),
            SizedBox(
              height: 12.h,
            ),
            _attendanceSection(),
            SizedBox(
              height: 12.h,
            ),
            accountStatus(),
            SizedBox(
              height: 12.h,
            ),
            _messageBox(),
            SizedBox(
              height: 12.h,
            ),
            //RoutineSection(),
          ],
        ),
      ),
    );
  }

//Message Section
  Widget _messageBox() {
    return Container(
      margin: EdgeInsets.all(8.0).r,
      padding: EdgeInsets.only(top: 10).r,
      height: 300.h,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(15).r,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 8.h,
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
            height: 120.h,
            child: Card(
              color: Colors.greenAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Paid",
                    style: kTextStyle.copyWith(
                        fontSize: 22.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "৳ 73000",
                    style: kTextStyle.copyWith(
                        fontSize: 22.sp,
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
            margin: EdgeInsets.only(left: 8.0, right: 8.0).r,
            height: 120.h,
            child: Card(
              color: Colors.pink[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dues",
                    style: kTextStyle.copyWith(
                        fontSize: 22.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "৳ 2600",
                    style: kTextStyle.copyWith(
                        fontSize: 22.sp,
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

//Attendance Section naughty

  Widget _attendanceSection() {
    int value = 70;
    int value2 = 30;

    return AspectRatio(
      aspectRatio: 1.5.r,
      child: Container(
        //height: 200,
        margin: EdgeInsets.all(10).r,
        padding: EdgeInsets.all(8.0).r,
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(15).r,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Attendance',
                style: kTextStyle.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
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
                          titleStyle: kTextStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.r),
                          radius: 40.r,
                        ),
                        PieChartSectionData(
                            radius: 40.r,
                            value: value2.toDouble(),
                            color: Colors.pinkAccent,
                            title: '$value2%',
                            titleStyle: kTextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.r)),
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
                              height: 10.h,
                              width: 15.w,
                              child: Container(
                                color: Colors.greenAccent,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Present',
                              style: kTextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 10.h,
                              width: 15.w,
                              child: Container(
                                color: Colors.pinkAccent,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Absent',
                              style: kTextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
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
      padding:
          EdgeInsets.only(left: 12.0.r, right: 12.0.r, top: 30.h, bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(13.r),
          bottomRight: Radius.circular(13.r),
        ),
      ),
      height: 130.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello,",
                style: kTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                name,
                style: kTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Text(
            'NIET PORTAL',
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                color: const Color.fromARGB(255, 107, 11, 75),
                shadows: [
                  Shadow(color: Colors.blueAccent),
                ],
              ),
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
