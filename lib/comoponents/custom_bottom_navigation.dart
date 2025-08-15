import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment_rounded),
          label: 'Accounts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Academics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Blogs',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.black,
      onTap: widget.onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue[400],
      elevation: 0,
      selectedFontSize: 14.sp,
    );
  }
}
