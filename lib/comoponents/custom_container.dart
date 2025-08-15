import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0).r,
        padding: EdgeInsets.all(13.0).r,
        //height: 300.h,
        width: 400.w,
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(15).r,
        ),
        child: child);
  }
}
