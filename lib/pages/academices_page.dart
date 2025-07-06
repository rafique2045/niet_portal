import 'package:flutter/material.dart';
import 'package:niet_portal/comoponents/custom_drawer.dart';
import 'package:niet_portal/constants.dart';


class AcademicesPage extends StatelessWidget {
  const AcademicesPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text(
          "Academics",
          style: kTitleStyle.copyWith(fontSize: 22, letterSpacing: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
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
                        size: 28,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 180,
                  ),
                  Center(
                    child: Text("Practice Yourself.\nToday has no Homework"),
                  )
                ],
              ),
            ),

            //
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(13.0),
        height: 400,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: child);
  }
}
