import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode, nextFocus;
  final String title, hint;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final bool autofocus, absorbing;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool obscureText;
  final ValueChanged<bool> onFocusChange;
  final bool hasError;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.nextFocus,
    required this.title,
    this.hint = '',
    required this.textInputType,
    required this.textInputAction,
    required this.textCapitalization,
    this.suffixIcon,
    this.absorbing = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.obscureText = false,
    required this.onFocusChange,
    this.hasError = false,
    this.errorText,
    this.validator,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: hasError
                    ? AppTheme.errorColor
                    : focusNode.hasFocus
                        ? AppTheme.primaryColor
                        : AppTheme.borderColor,
                width: 1.5,
              )),
          child: Row(
            children: [
              Expanded(
                child: Focus(
                  onFocusChange: onFocusChange,
                  child: TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    onChanged: onChanged,
                    keyboardType: textInputType,
                    textInputAction: textInputAction,
                    inputFormatters: inputFormatters,
                    textCapitalization: textCapitalization,
                    autofocus: autofocus,
                    maxLines: maxLines,
                    maxLength: maxLength,
                    obscureText: obscureText,
                    style: Styles.bold(
                        fontSize: 14, color: AppTheme.textPrimaryColor),
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(nextFocus);
                    },
                    validator: validator,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                        isDense: true,
                        // label: Text(
                        //   title,
                        //   style: Styles.bold(
                        //       fontSize: 14,
                        //       color: (focusNode.hasFocus ||
                        //               controller.text.isNotEmpty)
                        //           ? AppTheme.textSecondaryColor
                        //           : AppTheme.textPrimaryColor),
                        // ),
                        errorStyle: Styles.bold(
                            fontSize: 10, color: AppTheme.errorColor)),
                  ),
                ),
              ),
              suffixIcon ?? const SizedBox(),
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
