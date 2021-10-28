import 'package:flutter/material.dart';
import 'package:gigpoint/dialog/success_dialog.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/textfield_widget.dart';

class VerifyEmailDialog extends StatefulWidget {
  const VerifyEmailDialog({Key? key}) : super(key: key);

  @override
  _VerifyEmailDialogState createState() => _VerifyEmailDialogState();
}

class _VerifyEmailDialogState extends State<VerifyEmailDialog> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Align(
          alignment: Alignment.topRight,
          child: IconButton(
              splashRadius: 1,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, color: AppTheme.primaryColor))),
      content: SizedBox(
        width: Constants.dialogWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Verify Your Email',
                textAlign: TextAlign.center,
                style: Styles.bold(fontSize: 20),
              ),
              const SizedBox(height: 16),
              Text(
                'Enter the email associated with your point pickup driver app and we\'ll send an email with instructions to reset your password',
                textAlign: TextAlign.center,
                style: Styles.regular(fontSize: 16),
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                controller: _emailController,
                focusNode: _emailFocus,
                nextFocus: FocusNode(),
                onFocusChange: (val) {
                  setState(() {});
                },
                title: 'Email',
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
              ),
              const SizedBox(height: 20),
              ButtonWidget(
                  name: 'Submit',
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const SuccessDialog(),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
