import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart'; // No longer needed
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niet_portal/constants.dart'; // Assuming this contains necessary constants
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
    // Initialize ScreenUtil for responsive design
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Your design reference size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            // Define your app's theme here
            primarySwatch: Colors.blue, // Example primary color
            // Set scaffold background to transparent if you want the very bottom corners
            // outside the rounded container to show through to the MaterialApp's background
            // or the underlying content if Scaffold has no background.
            scaffoldBackgroundColor: Colors.transparent,
          ),
          debugShowCheckedModeBanner: false,
          home: child, // MainScaffold will be the home
        );
      },
      child: const MainScaffold(), // Pass MainScaffold as the child
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

  // List of widgets for each tab's content
  final List<Widget> _pages = <Widget>[
    const HomePage(), // Placeholder for your Home page content
    const AccountsPage(), // Placeholder for your Accounts page content
    const AcademicesPage(), // Placeholder for your Academics page content
    const BlogsPage(), // Placeholder for your Blogs page content
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
      bottomNavigationBar: Container(
        // The container now spans the full width by removing horizontal margins.
        // Only a bottom margin is kept if you want a small gap from the very bottom edge.
        // To make it truly "not floating" and flush with the bottom, remove this margin too.
        margin: EdgeInsets.only(bottom: 0.h), // No horizontal margin for full width
        //padding: EdgeInsets.only(top: 8.0.h, bottom: 0.h), // Padding for content inside
        // The height of the container can be controlled here.
        height: 68.h, // Explicit height for the container
        decoration: BoxDecoration(
          color: Colors.blue, // Background color for the entire nav bar container
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
            bottomLeft:Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          ), // Apply rounded corners only to the top
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -5), // Shadow pointing upwards
            )
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home), // Changed to home for consistency
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), // Changed to account_circle
              label: 'Accounts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school), // Changed to school
              label: 'Academics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article), // Changed to article
              label: 'Blogs',
            ),
          ],
          currentIndex: _selectedIndex, // The currently selected item
          selectedItemColor: Colors.black,
          // Color for the selected icon/label
          unselectedItemColor: Colors.black, // Color for unselected icons/labels
          onTap: _onItemTapped, // Callback when an item is tapped
          type: BottomNavigationBarType.fixed, // Ensures all labels are visible
          backgroundColor: Colors.transparent, // Crucial: makes the BottomNavigationBar itself transparent
          elevation: 0, // Removes the default shadow from BottomNavigationBar
        ),
      ),
    );
  }
}

