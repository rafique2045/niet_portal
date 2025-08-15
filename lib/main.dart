import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart'; // No longer needed
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:niet_portal/api_keys.dart';
import 'package:niet_portal/comoponents/custom_bottom_navigation.dart';
import 'package:niet_portal/pages/academices_page.dart';
import 'package:niet_portal/pages/accounts_page.dart';
import 'package:niet_portal/pages/blogs_page.dart';
import 'package:niet_portal/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://nebmyulcbqmsmjcackym.supabase.co',
    anonKey: supabase_anonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive design
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Your design reference size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: GoogleFonts.ibmPlexSans().toString(),
          ),
          debugShowCheckedModeBanner: false,
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
  late PageController _pageController;
  int _selectedIndex = 0; // Tracks the currently selected tab index

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const AccountsPage(),
    const AcademicesPage(),
    const BlogsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Function to handle tab taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Animate to the selected page when a tab is tapped
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          // Update selected index when page is swiped
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages, // The content widgets for each tab
      ),
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
