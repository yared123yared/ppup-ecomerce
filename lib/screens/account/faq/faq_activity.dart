import 'package:flutter/material.dart';
import 'package:gigpoint/screens/account/faq/faq_list.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:linkwell/linkwell.dart';

class FaqActivity extends StatefulWidget {
  const FaqActivity({Key? key, required this.faqList}) : super(key: key);
  final FAQList faqList;

  @override
  _FaqActivityState createState() => _FaqActivityState();
}

class _FaqActivityState extends State<FaqActivity> {
  bool isExpanded = false;
  void _toggle() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggle,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isExpanded ? AppTheme.primaryColor : Colors.white,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  title: Text(
                    widget.faqList.title,
                    style: Styles.semiBold(fontSize: 16),
                  ),
                  trailing: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 24,
                    color: AppTheme.primaryColor,
                  ),
                  onTap: () {
                    _toggle();
                  },
                ),
                if (isExpanded)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 16, left: 20, right: 20),
                    child: LinkWell(
                      widget.faqList.description,
                      textAlign: TextAlign.start,
                      style: Styles.regular(fontSize: 14),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
