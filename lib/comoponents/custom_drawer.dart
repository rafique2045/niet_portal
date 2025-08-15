import 'package:flutter/material.dart';
import 'package:niet_portal/attendance_section/attendance_page.dart';
import 'package:niet_portal/roboto/ai_chat_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[400],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Profile Clicked")));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: const Color.fromARGB(255, 107, 11, 75),
                      shadows: [
                        Shadow(color: Colors.blueAccent),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.mark_chat_read),
            title: const Text('MR.ROBOTO'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AiChatPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Personal Information'),
            onTap: () {
              // Navigate to home page or perform an action
            },
          ),
          ListTile(
            leading: const Icon(Icons.co_present),
            title: const Text('Attendances'),
            onTap: () {
              // Navigate to settings page or perform an action
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AttendancePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About NIET'),
            onTap: () {
              // Navigate to about us page or perform an action
            },
          ),
        ],
      ),
    );
  }
}
