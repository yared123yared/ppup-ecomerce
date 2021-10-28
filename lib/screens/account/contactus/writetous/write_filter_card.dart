import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';

class WriteToFilterCard extends StatelessWidget {
  const WriteToFilterCard(
      {Key? key,
      required this.title,
      required this.onTap,
      this.isDefault = true,
      this.errorText,
      required this.hasError})
      : super(key: key);
  final String title;
  final String? errorText;
  final GestureTapCallback onTap;
  final bool isDefault;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: hasError ? AppTheme.errorColor : AppTheme.borderColor,
                  width: 1.3,
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.bold(
                        fontSize: 14,
                        color: isDefault
                            ? AppTheme.textPrimaryColor
                            : AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.expand_more,
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          if (hasError) const SizedBox(height: 5),
          if (hasError)
            Text(
              errorText ?? '',
              style: Styles.bold(fontSize: 10, color: AppTheme.errorColor),
            ),
        ],
      ),
    );
  }
}
