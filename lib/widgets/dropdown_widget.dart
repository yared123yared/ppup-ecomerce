import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    Key? key,
    this.value,
    required this.items,
    required this.onChanged,
    this.hasError = false,
    this.errorText,
    required this.title,
  }) : super(key: key);

  final String? value;
  final String title;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged onChanged;
  final bool hasError;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10, vertical: value != null ? 5 : 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: hasError ? AppTheme.errorColor : AppTheme.borderColor,
                width: 1.5,
              )),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              const AbsorbPointer(
                absorbing: false,
                child: Icon(
                  Icons.expand_more_outlined,
                  color: AppTheme.primaryColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (value != null)
                    Text(
                      title,
                      style: Styles.bold(
                          fontSize: 9.5, color: AppTheme.textSecondaryColor),
                    ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: value,
                      items: items,
                      onChanged: onChanged,
                      isDense: true,
                      isExpanded: true,
                      hint: Text(
                        title,
                        style: Styles.bold(fontSize: 14),
                      ),
                      iconSize: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (hasError) const SizedBox(height: 5),
        if (hasError)
          Text(
            errorText ?? '',
            style: Styles.bold(fontSize: 10, color: AppTheme.errorColor),
          ),
      ],
    );
  }
}
