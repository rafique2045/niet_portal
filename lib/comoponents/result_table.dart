import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niet_portal/comoponents/custom_container.dart';

import '../constants.dart';
import 'custom_table_cell.dart';

class ResultTable extends StatelessWidget {
  const ResultTable({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Text(
            "Semester Results",
            style: kTitleStyle,
          ),
          Padding(
            padding: EdgeInsets.all(3.0).r,
            child: Table(
              border: TableBorder.all(width: 1.5),
              columnWidths: const <int, TableColumnWidth>{
                // 0: FixedColumnWidth(125),
                // 1: FixedColumnWidth(150),
                // //2: FixedColumnWidth(80),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                  ),
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        "Semester",
                        textAlign: TextAlign.center,
                        style: kTitleStyle,
                      ),
                    ),
                    //Container(height: 32, color: Colors.green),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        "Retakes",
                        textAlign: TextAlign.center,
                        style: kTitleStyle,
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        "CGPA",
                        textAlign: TextAlign.center,
                        style: kTitleStyle,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  //decoration: const BoxDecoration(color: Colors.grey),
                  children: <Widget>[
                    CustomTableCell(text: "1st Semester"),
                    CustomTableCell(text: "no retake"),
                    CustomTableCell(text: "3.50"),
                  ],
                ),
                TableRow(
                  //decoration: const BoxDecoration(color: Colors.grey),
                  children: <Widget>[
                    CustomTableCell(text: "2nd Semester"),
                    CustomTableCell(text: "no retake"),
                    CustomTableCell(text: "3.61"),
                  ],
                ),
                TableRow(
                  //decoration: const BoxDecoration(color: Colors.grey),
                  children: <Widget>[
                    CustomTableCell(text: "3rd Semester"),
                    CustomTableCell(text: "no retake"),
                    CustomTableCell(text: "3.67"),
                  ],
                ),
                TableRow(
                  //decoration: const BoxDecoration(color: Colors.grey),
                  children: <Widget>[
                    CustomTableCell(text: "4th Semester"),
                    CustomTableCell(text: "no retake"),
                    CustomTableCell(text: "3.78"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// DataTable(
// showBottomBorder: true,
// headingRowColor: WidgetStateProperty.resolveWith<Color?>(
// (Set<WidgetState> states) {
// return Colors.pink;
// },
// ),
// showCheckboxColumn: true,
// sortAscending: true,
// columns: [
// DataColumn(
// label: Expanded(
// child: Text('Name',
// style: TextStyle(fontStyle: FontStyle.italic))),
// ),
// DataColumn(
// label: Expanded(
// child:
// Text('Age', style: TextStyle(fontStyle: FontStyle.italic))),
// ),
// DataColumn(
// label: Expanded(
// child: Text('Role',
// style: TextStyle(fontStyle: FontStyle.italic))),
// ),
// ],
// rows: [
// DataRow(
// cells: <DataCell>[
// DataCell(Text('Sarah')),
// DataCell(Text('19')),
// DataCell(Text('Student')),
// ],
// ),
// DataRow(
// cells: <DataCell>[
// DataCell(Text('Janine')),
// DataCell(Text('43')),
// DataCell(Text('Professor')),
// ],
// ),
// DataRow(
// cells: <DataCell>[
// DataCell(Text('William')),
// DataCell(Text('27')),
// DataCell(Text('Associate Professor Associate Professor')),
// ],
// ),
// ],
// ),
