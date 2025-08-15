import 'package:flutter/material.dart';
import 'package:niet_portal/attendance_section/attendance_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceProvider extends ChangeNotifier {
  List<AttendanceModel> _attendanceList = [];
  List<AttendanceModel> get attendanceList => _attendanceList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  final supabase = Supabase.instance.client;

  // Constructor: Fetch data as soon as the provider is created.
  AttendanceProvider() {
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Corrected the table name to 'attendance'
      final data = await supabase.from('attendance_data').select();
      _attendanceList =
          (data as List).map((json) => AttendanceModel.fromJson(json)).toList();
    } catch (e) {
      _error = 'Error fetching attendance: $e';
      debugPrint("Error fetching attendance: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
