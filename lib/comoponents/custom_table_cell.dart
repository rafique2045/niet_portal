import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTableCell extends StatelessWidget {
  const CustomTableCell({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: kSubTitleStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
