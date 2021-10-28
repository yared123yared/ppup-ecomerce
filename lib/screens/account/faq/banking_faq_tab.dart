import 'package:flutter/material.dart';
import 'package:gigpoint/utils/styles.dart';

import 'faq_activity.dart';
import 'faq_list.dart';

class BankingFAQTab extends StatefulWidget {
  const BankingFAQTab({Key? key}) : super(key: key);

  @override
  _BankingFAQTabState createState() => _BankingFAQTabState();
}

class _BankingFAQTabState extends State<BankingFAQTab> {
  /// FAQ List
  List<FAQList> bankingFaqList = [];

  @override
  void initState() {
    super.initState();
    getLoadBankingFAQList();
  }

  getLoadBankingFAQList() {
    setState(() {
      bankingFaqList.add(FAQList(
          title: 'What is a Point Trust Visa Debit Card?',
          description:
              'The Point Trust Visa® Debit Card is issued by Sutton Bank.  You can use it anywhere Visa debit cards are accepted, including ATMs. Since it’s a debit card, transactions that exceed your available balance will normally be declined. We don’t charge overdraft fees.'
              '\nThe Point Trust Visa® Debit Card is issued by Sutton Bank, Member FDIC, pursuant to a license from Visa U.S.A. Inc. \nYour Point Trust Visa® Debit Card includes Visa Zero Liability Policy.\n'
              'Visa\'s Zero Liability Policy* is Visa\'s guarantee that you won\'t be held responsible for unauthorized charges made with your account or account information. You\'re protected if your Visa credit or debit card is lost, stolen or fraudulently used, online or offline.\n'
              '* Visa\'s Zero Liability Policy does not apply to certain commercial card and anonymous prepaid card transactions or transactions not processed by Visa. Cardholders must use care in protecting their card and notify their issuing financial institution immediately of any unauthorized use. Contact your issuer for more detail.'));
      bankingFaqList.add(FAQList(
          title: 'How to activate your Point Trust Visa Debit Card?',
          description: 'How long does it take for my debit card to arrive? \n'
              ' Your Point Trust Visa® Debit Card is sent out automatically after your Point Trust Account is approved. It should arrive within 5-7 business days. If you haven\'t received your    Debit Card within that time, just give us a call at 833 333 0419.'));
      bankingFaqList.add(FAQList(
        title: 'How do I activate my Point Trust Visa® Debit Card?',
        description:
            'You have two easy ways: \n 1.\t Login to GigPoint and tap on Banking.  Go to My Card. You will see an image of the card and it should say “Card Activation Pending”. Tap to  activate your card and set your PIN.\n'
            '2.\t Call 833 333 0419 to activate your card and set your  PIN.',
      ));
      bankingFaqList.add(FAQList(
        title: 'How do I change my PIN number?',
        description:
            'Go to Banking > My Card > Change Pin, and make the change. Remember not to write your PIN on your card, keep it in a safe and secure place. You can also call 833 333 0419 and follow the prompts to change your pin.',
      ));
      bankingFaqList.add(FAQList(
        title: 'How do I suspend my Debit Card?',
        description:
            'Go to Banking > My Card in the GigPoint app. Tap on Suspend under the card image to suspend the card.\n'
            ' \nSuspending your debit card helps prevent unauthorized purchases and withdrawals. Once your card is suspended, it cannot be used to make in-store or online purchases, withdraw money from ATMs, or receive instant transfers from digital money payments like Venmo, Cash App, Facebook Pay. Other types of transactions, like direct deposits, ACH transfers and bill payments, are not affected.'
            ' \nTo reactivate your card, go to My Card again and tap Reactivate under the card. \nIf you know your card is lost or stolen, contact Customer Service at 833 333 0419 immediately to close your card and get a replacement card.',
      ));
      bankingFaqList.add(FAQList(
        title: 'What happens if I lose my Debit Card, or if it is stolen?',
        description:
            'Call Customer Service immediately at  833 333 0419 to report your stolen card.\n If you\'d like a replacement card, Customer Service will be happy to send you one. Simply call our Customer Service at  833 333 0419 and follow the prompts to receive a replacement. If your address on file has changed, you will be directed to a live agent for assistance. You will need to send proof of your new address before a new card is shipped. We may charge a replacement card fee of \$4.9',
      ));
      bankingFaqList.add(FAQList(
        title: 'Can I use my Debit Card for booking hotels and rental cars?',
        description:
            'Yes, you can use your Debit Card to book hotel and rental car reservations. However, these kinds of reservations may result in a prolonged hold, which may affect your access to funds. When you use any debit card to reserve a hotel or rental car, the hotel or rental car agency typically puts a hold on your account to cover both the estimated charges for your stay/rental plus an extra amount to cover any additional charges. Holds typically last for about 3-10 business days.\n'
            ' If you have concerns about a hold that remains on your account after you settle your final bill with a hotel or rental car agency, please call us at 833 333 0419',
      ));
      bankingFaqList.add(FAQList(
          title:
              'What do I need to know about using my Debit Card at Restaurants, Gas Stations and other service-oriented retailers?',
          description:
              'When using your Debit Card at a gas station, we recommend paying at the cashier instead of at the pump. When paying at the pump, up to \$100 may be automatically made unavailable from your debit card until the actual transaction posts (typically within 3-10 business days). If you have less than \$100 on your debit card your transaction may be declined at the pump. After the merchant settles, the accurate funds will be refunded back to your debit card. Paying at the cashier allows only the amount incurred to be debited to your account.\n'
              'Service-oriented merchants such as restaurants and salons may factor in an additional 20% on top on your total bill to cover any tip you may leave on the debit card. If your total bill, combined with the additional 20%, exceeds the amount on the debit card, it may be declined. To prevent this, there must be an available balance that is 20% greater than your total bill.\n'
              'This does not mean that you will be charged the additional 20%. Once the merchant processes the transaction for the total bill amount, only the original authorization amount will be deducted from your available balance.'));
      bankingFaqList.add(FAQList(
        title:
            'What should I do if I don’t receive a credit I am expecting on my Debit Card?',
        description:
            'When expecting a return or refund to your debit card, wait at least 10 business days from the date the credit was issued for the credit to appear back on your debit card. If you still do not see the credit after 10 business days, reach out to  the merchant first for confirmation that the credit processed. Once the merchant provides you confirmation of the credit and you still have not received the funds, you will need to file a dispute on the original charge. Call the number listed on the back of your Point Trust Visa® Debit Card to file a dispute on any charge.',
      ));
      bankingFaqList.add(FAQList(
        title: 'Can I use my Debit Card internationally?',
        description:
            'Yes, you can use your card internationally in most countries. You will be charged 3% of the total for foreign transactions.',
      ));
      bankingFaqList.add(FAQList(
        title: 'Can I get cash at ATMs?',
        description:
            'Yes, you can withdraw cash at an ATM. At our In Network / Allpoint ATMs, no transaction fees will be incurred for the first 2 transactions every month. Subsequent transactions will be charged \$1.95 (cash withdrawals or balance inquiries). There are more than 55,000 Allpoint® ATMs worldwide. You can find them in stores near you, like CVS, Walgreens, Rite Aid, Kroger’s, and Target.\n'
            ' To find your closest Allpoint ATM, go to www.allpointnetwork.com. Cash withdrawals from ATMs outside the Allpoint Network will incur a withdrawal fee of \$2.95. The owner of the ATM may also choose to charge additional fees.\n'
            'You can take out up to \$500 cash per calendar day from ATMs, \$5000 total per month.\n'
            'Other ways to get cash:\n'
            ' When you check out at a store, many have the option to get cash. Use your Debit Card and follow the on-screen prompts to withdraw up to \$500 per calendar day. The store may limit how much cash can be received, and some may charge a fee. When you withdraw cash from a Point-of-Sale Terminal, it is deducted from your daily Point of Sale transaction limit.\n'
            ' However you get cash, the most you can get combined from ATMs or POS is \$500 per calendar day.',
      ));
      bankingFaqList.add(FAQList(
        title: 'Can I check my balance at an ATM?',
        description:
            'Yes, but the most economical way to check your balance is to sign up for alerts on your  Point Trust Account or login to your GigPoint account and check your available balance.',
      ));
      bankingFaqList.add(FAQList(
        title: 'Can I deposit money at an ATM?',
        description:
            'At this time, you cannot deposit cash or checks at an ATM. There are a few options available from direct deposit, ACH, to mobile wallets.',
      ));
      bankingFaqList.add(FAQList(
        title: 'Can I use my Debit Card at an International ATM?',
        description:
            'You can use your card at International ATMS. Before your trip, check if there are Allpoint ATMs in the country you are going to. You can find international Allpoint ATMs at www.allpointnetwork.com. ATM. At our In Network / Allpoint ATMs, no transaction fees will be incurred for the first 2 transactions every month (cash withdrawals or balance inquiries). Subsequent transactions will be charged \$1.95. Cash withdrawals from ATMs outside the Allpoint Network will incur a withdrawal fee of \$2.95. The owner of the ATM may also choose to charge additional fees. Limit for International ATM use is \$500 per day.',
      ));
      bankingFaqList.add(FAQList(
        title: 'What is the Point Trust Digital Account?',
        description:
            'The Point Trust Digital Account gives our gig workers access and use of their money, anytime and anywhere through GigPoint. \n'
            'The Point Trust Digital Account with Earnings Credit includes a Point Trust Visa Debit Card, an In-Network ATM, Online Bill Pay and P2P Payments (US, including Puerto Rico). \n'
            'Point Trust facilitates banking services through Sutton Bank. Member FDIC.',
      ));
      bankingFaqList.add(FAQList(
        title:
            'How can I sign up for a Point Trust Digital Account with Earnings Credit?',
        description:
            'To sign up, login to the GigPoint App and tap on Banking to begin the sign up process. Enter your Point Pickup Driver App login information, and verify that the information about you is correct- name, address, phone, date of birth. You will need to enter your Social Security or ITIN number.',
      ));
      bankingFaqList.add(FAQList(
        title:
            'Why do you need my personal information to verify my identity for a Point Trust Digital Account?',
        description:
            'Protecting you and your data is our priority. Federal law requires that we collect this information so that we can verify your identity and help prevent fraud. All financial institutions are required to obtain, verify, and record information that identifies each person who opens an account in accordance with the USA PATRIOT Act. Providing your personal information helps the government fight the funding of terrorism and money laundering activities. \n'
            'While we may request identity documentation, your credit report or FICO score will not be checked. Documentation is stored safely using appropriate security measures and technology to protect against unauthorized access to your information. Maintaining  the privacy of your personal information is one of our highest priorities.',
      ));
      bankingFaqList.add(FAQList(
        title: 'What can I expect from the ID verification process?',
        description:
            'Once documentation is received and validated, you should be approved within 30 minutes. If more information is required to process your registration, we will reach out to you.',
      ));
      bankingFaqList.add(FAQList(
        title: 'Where can I find your policies / agreements?',
        description:
            'You can locate policies and agreements in GigPoint under the Banking tab. Tap on Agreements to access agreements that apply to your account. PDF versions are available for download if required.',
      ));
      bankingFaqList.add(FAQList(
        title: 'How do I update or change my address?',
        description:
            'You can change your address by calling  833 333 0419 and speaking with a Customer Service Representative.',
      ));
      bankingFaqList.add(FAQList(
        title: 'How do I update my password, phone number, email?',
        description:
            'Within the Banking tab, go to Profile and update the necessary information.',
      ));
      bankingFaqList.add(FAQList(
        title: 'What is Earnings Credit?',
        description:
            'Earnings Credit is money earned from funds in your account. The current rate is 38 Basis Points. There is no minimum opening balance required to receive Earnings Credit.\n'
            'Earnings Credit will be calculated daily\n'
            'The current Earnings Credit Rate is divided by the number of days in a year (365 days in period, except for leap year with 366) times the daily account balance each day of the month\n'
            'Monthly Earnings Credit will be credited to your account on the first day of the next month\n'
            'The Earnings Credit may be taxable. Please consult your own tax, legal and accounting advisors if you have additional questions.',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Text(
              'FAQ',
              style: Styles.bold(fontSize: 18),
            ),
          ),
          ListView.separated(
            itemCount: bankingFaqList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) =>
                FaqActivity(faqList: bankingFaqList[index]),
          )
        ],
      ),
    );
  }
}
