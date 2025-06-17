import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:niet_portal/constants.dart';

class RoutineSection extends StatefulWidget {
  const RoutineSection({super.key});

  @override
  State<RoutineSection> createState() => _RoutineSectionState();
}

const List<String> list = <String>[
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday'
];

class _RoutineSectionState extends State<RoutineSection> {
  String day = list.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      //height: 400,
      //width: 400,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Class Routine',
                  style: kTitleStyle,
                ),
                DropdownButton<String>(
                  alignment: Alignment.center,
                  value: day,
                  // elevation: 16,
                  icon: Icon(
                    Icons.arrow_circle_down,
                    color: Colors.black,
                  ),
                  style: kTitleStyle,
                  dropdownColor: Colors.blue[300],
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      day = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                ),
              ],
            ),
          ),
          day == "Sunday"
              ? sunday()
              : day == "Monday"
                  ? monday()
                  : day == "Tuesday"
                      ? tuesday()
                      : day == "Wednesday"
                          ? wednesday()
                          : day == "Thursday"
                              ? thursday()
                              : Text("No Class"),
        ],
      ),
    );
  }
}

//Sunday
Widget sunday() {
  return Column(
    children: [
      ClassTile(
          subject: Subjects.web,
          time: "12:35 PM-01:10 PM",
          teacher: Teachers.tafsirul),
      ClassTile(
          subject: Subjects.dataCommunication,
          time: '02:10 PM-02:45 PM',
          teacher: Teachers.jobayer),
      ClassTile(
          subject: Subjects.accounting,
          time: '02:45 PM-03:20 PM',
          teacher: Teachers.sangita),
      ClassTile(
          subject: Subjects.os,
          time: '03:20 PM-04:30 PM',
          teacher: Teachers.jobayer),
    ],
  );
}

// Monday Routine
Widget monday() {
  return Column(
    children: [
      ClassTile(
          subject: Subjects.java,
          time: "12:30 PM-01:10 PM",
          teacher: Teachers.tafsirul),
      ClassTile(
          subject: Subjects.cam,
          time: '02:10 PM-02:45 PM',
          teacher: Teachers.tafsirul),
      ClassTile(
          subject: Subjects.pw,
          time: '03:20 PM-04:30 PM',
          teacher: Teachers.sahid),
    ],
  );
}

// tuesday Routine
Widget tuesday() {
  return Column(
    children: [
      ClassTile(
          subject: Subjects.cam,
          time: '12:30 PM-01:10 PM',
          teacher: Teachers.tafsirul),
      ClassTile(
          subject: Subjects.accounting,
          time: '02:10 PM-02:45 PM',
          teacher: Teachers.sangita),
      ClassTile(
          subject: Subjects.java,
          time: "02:45 PM-03:20 PM",
          teacher: Teachers.tafsirul),
      ClassTile(
          subject: Subjects.dataCommunication,
          time: '03:20 PM-04:30 PM',
          teacher: Teachers.sahid),
    ],
  );
}

// tuesday Routine
Widget wednesday() {
  return Column(
    children: [
      ClassTile(
          subject: Subjects.os,
          time: '12:00 PM-12:35 PM',
          teacher: Teachers.jobayer),
      ClassTile(
          subject: Subjects.java,
          time: "12:35 PM PM-01:10 PM",
          teacher: Teachers.tafsirul),
      ClassTile(
          subject: Subjects.dataCommunication,
          time: '02:10 PM-02:45 PM',
          teacher: Teachers.sahid),
      ClassTile(
          subject: Subjects.cam,
          time: '02:45 PM-03:20 PM',
          teacher: Teachers.tafsirul),
      ClassTile(
          subject: Subjects.web,
          time: "03:20 PM-04:30 PM",
          teacher: Teachers.tafsirul),
    ],
  );
}

//Thursday Routine

Widget thursday() {
  return Column(
    children: [
      ClassTile(
          subject: Subjects.cam,
          time: '02:45 PM-03:20 PM',
          teacher: Teachers.tafsirul),
      ClassTile(
          subject: Subjects.dataCommunication,
          time: '02:10 PM-02:45 PM',
          teacher: Teachers.sahid),
      ClassTile(
          subject: Subjects.os,
          time: '12:00 PM-12:35 PM',
          teacher: Teachers.jobayer),
      ClassTile(
          subject: Subjects.web,
          time: "03:20 PM-04:30 PM",
          teacher: Teachers.tafsirul),
    ],
  );
}

//Class Routine single subject Tile
class ClassTile extends StatelessWidget {
  ClassTile(
      {super.key,
      required this.subject,
      required this.time,
      required this.teacher});
  final TextStyle ksubjectStyle = GoogleFonts.ibmPlexSans(
      fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);
  final TextStyle ktimeStyle = GoogleFonts.ibmPlexSans(
    fontSize: 15,
    color: Colors.black,
  );
  final String subject, time, teacher;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[200],
      child: ListTile(
        title: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            subject,
            style: ksubjectStyle,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              teacher,
              style: ktimeStyle,
              softWrap: true,
            ),
            Text(
              time,
              style: ktimeStyle,
            ),
          ],
        ),
      ),
    );
  }
}
// Teachers Provider

class Teachers {
  static String tafsirul = 'Md.Tafsirul Islam';
  static String jobayer = 'Abdur Rahaman Zubayer';
  static String sahid = 'Md.Shahid Miah';
  static String sangita = 'Sangita Dey';
}

//Subjects Name
class Subjects {
  static String java = 'Application Development Using Java';
  static String web = 'Web Design and Development';
  static String os = 'Operating System';
  static String cam = 'Computer Architecture and Microprocssor';
  static String pw = 'Project Work-01';
  static String accounting = 'Accounting';
  static String dataCommunication = 'Data Communication';
}
