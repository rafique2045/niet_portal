// class CustomBottomNavigation extends StatelessWidget {
//   const CustomBottomNavigation({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.inbox),
//           label: 'Inbox',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.star),
//           label: 'Starred',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.send),
//           label: 'Sent',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.drafts),
//           label: 'Drafts',
//         ),
//       ],
//       currentIndex: _selectedIndex, // The currently selected item
//       selectedItemColor: Colors.blueAccent, // Color for the selected icon/label
//       unselectedItemColor: Colors.grey, // Color for unselected icons/labels
//       onTap: _onItemTapped, // Callback when an item is tapped
//       type: BottomNavigationBarType.fixed, // Ensures all labels are visible
//       backgroundColor: Colors.white, // Background color of the bar
//       elevation: 8.0, // Shadow beneath the bar
//     ),);
//   }
// }
