import 'package:flutter/material.dart';
import 'package:gigpoint/dialog/primary_address_dialog.dart';
import 'package:gigpoint/model/address.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/custom_radio_button.dart';

import 'address_options.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key? key,
    required this.value,
    required this.selectedValue,
    required this.onTap,
    required this.onChanged,
    required this.onOptionsTap,
    required this.showOptions,
    required this.onDeleteTap,
    required this.onEditTap,
    required this.onCloseTap,
    required this.addressList,
    required this.isSelection,
  }) : super(key: key);

  final String value;
  final String selectedValue;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onOptionsTap;
  final ValueChanged? onChanged;
  final bool showOptions;
  final GestureTapCallback? onDeleteTap;
  final GestureTapCallback? onEditTap;
  final GestureTapCallback? onCloseTap;
  final AddressList? addressList;
  final bool isSelection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 18, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: isSelection
                          ? CustomRadioButton(
                              title:
                                  '${addressList!.firstName} ${addressList!.lastName}',
                              titleStyle: Styles.bold(fontSize: 16),
                              groupValue: selectedValue,
                              onTap: onTap,
                              value: value,
                              onChanged: onChanged,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 8),
                              child: Text(
                                '${addressList!.firstName} ${addressList!.lastName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.bold(fontSize: 16),
                              ),
                            ),
                    ),
                    (addressList!.addressType!.toLowerCase() !=
                            Constants.primary)
                        ? GestureDetector(
                            onTap: onOptionsTap,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(
                                Icons.more_vert,
                                size: 24,
                                color: AppTheme.textSecondaryColor,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              AppUtils.dialogBuilder(
                                  context, const PrimaryAddressDialog());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      'PRIMARY',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.semiBold(
                                          fontSize: 10,
                                          color: AppTheme.textSecondaryColor),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.info_outline,
                                    size: 13,
                                    color: AppTheme.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: isSelection ? 48.0 : 20, right: 24),
                  child: Text(
                    '${addressList!.addressLine}, ${addressList!.city}, ${addressList!.state}, ${addressList!.country}'
                    ' - ${addressList!.zipcode}',
                    style: Styles.semiBold(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          if (showOptions)
            AddressOptions(
                onDeleteTap: onDeleteTap,
                onEditTap: onEditTap,
                onCloseTap: onCloseTap),
        ],
      ),
    );
  }
}
