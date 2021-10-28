import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';

class FilterCard extends StatelessWidget {
  const FilterCard(
      {Key? key,
      required this.title,
      required this.onTap,
      this.isDefault = true})
      : super(key: key);
  final String title;
  final GestureTapCallback onTap;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.semiBold(
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
      ),
    );
  }
}
