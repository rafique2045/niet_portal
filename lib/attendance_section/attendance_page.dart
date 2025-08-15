import 'package:flutter/material.dart';
import 'package:niet_portal/attendance_section/attendance_provider.dart';
import 'package:provider/provider.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    AttendanceProvider attendanceProvider = AttendanceProvider();
    //attendanceProvider.fetchAttendance();

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AttendanceProvider())],
      child: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendances"),
      ),
      body: Consumer<AttendanceProvider>(
        builder: (context, attendanceProvider, child) {
          // Conditionally show UI based on the provider's state.
          if (attendanceProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (attendanceProvider.error != null) {
            return Center(child: Text('Error: ${attendanceProvider.error}'));
          }
          if (attendanceProvider.attendanceList.isEmpty) {
            return const Center(child: Text('No attendance data found.'));
          }

          // Otherwise, display the list of attendance records.
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: attendanceProvider.attendanceList.length,
            itemBuilder: (BuildContext context, int index) {
              final attendance = attendanceProvider.attendanceList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(attendance.date),
                  subtitle: Text('${attendance.day} - ${attendance.status}'),
                  trailing: Text(
                      '${attendance.inTime ?? '--'} to ${attendance.outTime ?? '--'}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a refresh button to manually fetch the data again.
          Provider.of<AttendanceProvider>(context, listen: false)
              .fetchAttendance();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
