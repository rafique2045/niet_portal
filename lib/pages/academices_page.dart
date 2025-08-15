import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niet_portal/comoponents/custom_drawer.dart';
import 'package:niet_portal/comoponents/custom_widgets.dart';
import 'package:niet_portal/comoponents/result_table.dart';
import 'package:niet_portal/constants.dart';
import 'package:niet_portal/roboto/ai_chat_page.dart';

import '../comoponents/custom_container.dart';

class AcademicesPage extends StatelessWidget {
  const AcademicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AiChatPage()));
        },
        child: Image.asset('assets/ai.png'),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text(
          "Academics",
          style: kTitleStyle.copyWith(fontSize: 22, letterSpacing: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 5.0, right: 5.0).r,
        child: Column(
          children: [
            //Home Work Card
            CustomContainer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Homeworks",
                        style: kTitleStyle,
                      ),
                      Icon(
                        Icons.task,
                        size: 28.r,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120.h,
                  ),
                  Center(
                    child: Text(
                      "Practice Yourself.\nToday has no Homework",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            RoutineSection(),
            SizedBox(
              height: 8.h,
            ),
            ResultTable()
            //
          ],
        ),
      ),
    );
  }
}
