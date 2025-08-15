class AttendanceModel {
  final int id;
  final String date;
  final String day;
  final String status;
  final String? inTime;
  final String? outTime;

  AttendanceModel({
    required this.id,
    required this.date,
    required this.day,
    required this.status,
    this.inTime,
    this.outTime,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] as int,
      date: json['date'] as String,
      day: json['day'] as String,
      status: json['status'] as String,
      inTime: json['in'] == 'null' ? null : json['in'] as String?,
      outTime: json['out'] == 'null' ? null : json['out'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'day': day,
      'status': status,
      'in': inTime,
      'out': outTime,
    };
  }
}
