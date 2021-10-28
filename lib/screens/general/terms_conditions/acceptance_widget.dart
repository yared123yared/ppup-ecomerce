import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/button_widget.dart';

class AcceptanceWidget extends StatelessWidget {
  final ValueChanged onChanged;
  final bool isAccepted;
  final GestureTapCallback onAcceptTap;
  const AcceptanceWidget(
      {Key? key,
      required this.onChanged,
      required this.isAccepted,
      required this.onAcceptTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: AppTheme.boxShadow,
      ),
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: AppTheme.primaryColor,
                    value: isAccepted,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: onChanged,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Text(
                          'I agree with the terms & conditions above in order to be eligible to accept Rewards and shopping experience from GigPoint.',
                          style: Styles.regular(fontSize: 14)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              ButtonWidget(
                name: 'Accept & Continue',
                isActive: isAccepted,
                onTap: onAcceptTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
