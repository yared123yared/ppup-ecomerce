import 'package:flutter/material.dart';
import 'package:gigpoint/model/contact_us.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({Key? key, required this.contactUsList})
      : super(key: key);
  final List<ContactUsList> contactUsList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              'Call us',
              style: Styles.bold(fontSize: 16),
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: contactUsList.length,
              itemBuilder: (BuildContext context, int index) {
                ContactUsList item = contactUsList[index];
                return (item.phone == null || item.phone!.isEmpty)
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 22),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${item.category ?? ''}:',
                                style: Styles.semiBold(fontSize: 14),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(item.phone ?? '',
                                style: Styles.bold(fontSize: 14)),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                AppUtils.makePhoneCall(item.phone ?? '');
                              },
                              child: const SvgImage(
                                height: 24,
                                width: 24,
                                asset: Images.callIcon,
                              ),
                            )
                          ],
                        ),
                      );
              },
              separatorBuilder: (context, index) =>
                  (contactUsList[index].phone == null ||
                          contactUsList[index].phone!.isEmpty)
                      ? const SizedBox()
                      : const Divider(color: Colors.black54)),
        ],
      ),
    );
  }
}
