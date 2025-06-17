import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niet_portal/constants.dart';
import 'package:niet_portal/pages/academices_page.dart';
import 'package:niet_portal/pages/accounts_page.dart';
import 'package:niet_portal/pages/blogs_page.dart';
import 'package:niet_portal/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.blue[200],
          ),
          home: child,
        );
      },
      child: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final List<Widget> pages = <Widget>[
    HomePage(),
    AccountsPage(),
    AcademicesPage(),
    BlogsPage(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        color: Colors.blue[400],
        child: GNav(
          textStyle: kSubTitleStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 16),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          activeColor: Colors.black,
          color: Colors.black,
          tabBackgroundColor: const Color.fromRGBO(144, 202, 249, 1),
          tabBorderRadius: 100.0,
          gap: 8,
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.assured_workload_outlined,
              text: "Accounts",
            ),
            GButton(
              icon: Icons.menu_book_outlined,
              text: 'Academic',
            ),
            GButton(
              icon: Icons.newspaper_outlined,
              text: 'Blog',
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue[200],
      body: pages[_selectedIndex],
    );
  }
}
