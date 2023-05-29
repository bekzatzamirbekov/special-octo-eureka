import 'package:flutter/material.dart';
import 'package:mocked_mbank/utils/theme_utils.dart';

import '../main.dart';
import '../models/credit_mbank.dart';

class CreditTile extends StatelessWidget {
  final CreditMbank? credit;
  final Widget title;
  final Widget subtitle;
  final DateTime date;
  final Function()? onTileTap;

  const CreditTile({
    required this.credit,
    required this.title,
    required this.subtitle,
    required this.date,
    this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final tileColor = isLightTheme ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          backgroundColor: tileColor,
          title: title,
          subtitle: subtitle,
          trailing: const Icon(Icons.keyboard_arrow_down_rounded),
          childrenPadding: EdgeInsets.zero,
          collapsedBackgroundColor: tileColor,
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          leading: CircleAvatar(
            backgroundColor: myColor,
            child: const Icon(Icons.attach_money_rounded, color: Colors.white),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      // Or StadiumBorder()
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Handle payment button tap
                  },
                  child: const Text('Pay with sum'),
                ),
              ),
            ),
          ],
          onExpansionChanged: (isExpanded) {
            if (isExpanded && onTileTap != null) {
              onTileTap!();
            }
          },
        ),
      ),
    );
  }
}
