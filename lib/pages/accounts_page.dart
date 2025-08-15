import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:niet_portal/comoponents/custom_drawer.dart';
import 'package:niet_portal/constants.dart';

var kPayStyle = GoogleFonts.ibmPlexSans(
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text(
          'Accounts',
          style: kTextStyle.copyWith(fontWeight: FontWeight.w900),
        ),
        //actions: [Icon(Icons.search)],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            SizedBox(height: 10.h),
            _buildUpcomingPayment(),
            SizedBox(height: 10.h),
            _buildPaymentHistory(),
            //SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fee Summary',
                style: kTitleStyle.copyWith(
                    fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 12.h),
            _buildSummaryRow('Total Fee', '৳ 50,000'),
            _buildSummaryRow('Paid', '৳ 30,000'),
            _buildSummaryRow('Due', '৳ 20,000', isDue: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isDue = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: kTitleStyle.copyWith(fontSize: 16.sp)),
          Text(value,
              style: kTextStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isDue ? Colors.red : Colors.green,
              )),
        ],
      ),
    );
  }

  Widget _buildUpcomingPayment() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(LucideIcons.calendarClock),
        title: Text('Upcoming Payment'),
        subtitle: Text('৳ 10,000 due on 30 May 2025'),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, textStyle: kTitleStyle),
          onPressed: () {},
          child: Text('Pay Now'),
        ),
      ),
    );
  }

  Widget _buildPaymentHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Card1(),
          ),
        ),
      ],
    );
  }
}

// Don't forget to add Lucide Icons dependency in pubspec.yaml:
// lucide_icons: ^0.2.0

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class Card1 extends StatelessWidget {
  const Card1({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Card(
      child: Column(
        children: <Widget>[
          ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
              ),
              header: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: ListTile(
                  // leading: Icon(LucideIcons.receipt),
                  title: Text(
                    'Payment Recieved ৳ 4000',
                    style: kTitleStyle,
                  ),
                  subtitle: Text(
                    'Paid on 15 April 2025 via Cash',
                    style: kSubTitleStyle,
                  ),
                  trailing: Icon(Icons.check_circle, color: Colors.green),
                ),
              ),
              collapsed: Text(
                "More Details",
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: kPayStyle,
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Text(
                              "Pay id:10115",
                              style: kPayStyle,
                            ),
                          ],
                        ),
                        devider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SL",
                              style: kPayStyle,
                            ),
                            Text(
                              "Detail",
                              style: kPayStyle,
                            ),
                            Text(
                              "Month",
                              style: kPayStyle,
                            ),
                            Text(
                              "Amount",
                              style: kPayStyle,
                            ),
                          ],
                        ),
                        devider(),
                        PaymentHistoryDetail(
                            sl: "01",
                            detail: "Exam Fee",
                            month: "May",
                            amount: "2600৳"),
                        devider(),
                        PaymentHistoryDetail(
                            sl: "02",
                            detail: "Tution Fee",
                            month: "May",
                            amount: "1500৳"),
                        devider(),
                        PaymentHistoryDetail(
                            sl: "03",
                            detail: "Fines",
                            month: "",
                            amount: "000.0৳"),
                        devider(),
                        PaymentHistoryDetail(
                            sl: "03",
                            detail: "Others",
                            month: "",
                            amount: "000.0৳"),
                        devider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount",
                              style: kPayStyle,
                            ),
                            Text(
                              "- 100৳",
                              style: kPayStyle,
                            ),
                          ],
                        ),
                        devider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: kPayStyle,
                            ),
                            Text(
                              "4000.0 ৳",
                              style: kPayStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  Widget devider() {
    return SizedBox(
      height: 20,
      child: Divider(
        color: Colors.teal[100],
      ),
    );
  }
}

class PaymentHistoryDetail extends StatelessWidget {
  const PaymentHistoryDetail({
    super.key,
    required this.sl,
    required this.detail,
    required this.month,
    required this.amount,
  });
  final String sl;
  final String detail;
  final String month;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sl,
          style: kPayStyle,
        ),
        Text(
          detail,
          style: kPayStyle,
        ),
        Text(
          month,
          style: kPayStyle,
        ),
        Text(
          amount,
          style: kPayStyle,
        ),
      ],
    );
  }
}

// ListTile(
//               leading: Icon(LucideIcons.receipt),
//               title: Text('৳ 10,000'),
//               subtitle: Text('Paid on 15 April 2025 via bKash'),
//               trailing: Icon(Icons.check_circle, color: Colors.green),
//             ),
