import 'package:flutter/material.dart';
import 'package:gigpoint/utils/styles.dart';

import 'faq_activity.dart';
import 'faq_list.dart';

class InsuranceFAQTab extends StatefulWidget {
  const InsuranceFAQTab({Key? key}) : super(key: key);

  @override
  _InsuranceFAQTabState createState() => _InsuranceFAQTabState();
}

class _InsuranceFAQTabState extends State<InsuranceFAQTab> {
  /// FAQ List
  List<FAQList> insuranceFaqList = [];

  @override
  void initState() {
    super.initState();
    getLoadInsuranceFAQList();
  }

  getLoadInsuranceFAQList() {
    setState(() {
      insuranceFaqList.add(FAQList(
        title: 'Who is the insurer?',
        description:
            'Nationwide Insurance, one of the largest insurance companies in the world, is the carrier that has issued a policy to back the GigPoint program. The program is facilitated by Vault Captive, a licensed and regulated Captive Insurance company in North Carolina.  Captive insurance companies are typically formed for specific programs, like this one.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'Who is eligible?',
        description:
            'To participate in the plan, you must be a gig worker contracted with Point Pickup, accessing the plan via the GigPoint app.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'What is available to me?',
        description:
            'We offer four great plan designs for gig workers and their dependents. The four plans include Vault Direct 2.0, MEC Visit Plus, Premium Health and Elite Health Plus. All plans offer unlimited telemedicine visits; among the four, you’ll find a spectrum of coverage, from light to heavy, so you can choose the plan that works for you at the price you can afford',
      ));
      insuranceFaqList.add(FAQList(
        title: 'What is the enrollment process?',
        description:
            'Enrolling is easy! Prices are fixed and there’s no medical qualifying. Choose your plan design, enter your credit card information and you’re done! If you’ve reviewed the plans and are ready to choose, enrollment can take you as little as ten minutes.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'What’s the commitment?',
        description:
            'You can enroll and cancel at any time. Your plan is month to month, so you decide how long you want coverage. There is a waiting period to re-enroll, though – if you cancel, you must wait 12 months before you will be allowed to rejoin the plan.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'What is the effective date of this plan?',
        description:
            'Enroll now (November 1 – December 15, 2021) for coverage starting January 1, 2022. Starting in January 2022, you will have until (midnight) the 15th of each month to choose your plan for the 1st of the following month.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'What is Vault and what is AMPS?',
        description:
            'There are many functions that go on behind the scenes for any health benefits program.  The overall program manager for this program is Vault Consulting. Vault Captive is the Captive insurance company with the financial responsibilities. Vault Admin Services is responsible for day-to-day services, and they have delegated claims processing and most customer service responsibilities to AMPS. You would contact Vault Admin Services, powered by AMPS, for address changes, ID cards, and help with seeking and setting up appointments with your provider. AMPS also audits all medical claims to help contain costs and to help with member advocacy. They help find additional savings and keep your costs as a member lower than other plans. The 800 number on the back of your card will direct you to Vault Admin Services for all these services.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'Who is eligible?',
        description:
            'All independent Point Pickup gig workers and their dependents are eligible to enroll via the GigPoint app. There is no medical qualifying or underwriting – the rates you see are the rates you will get, though rates are subject to an increase effective January of each year.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'How are my premium payments processed?',
        description:
            'Your payments will be processed via credit card each month between the 25th and the last day of the month, with that payment applied to your coverage for the next month. For example, your card will be charged January 25-31 for your February coverage. For the first month of coverage, your card may be charged as early as the 15th.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'When will I receive my card(s)?',
        description:
            'Your ID cards will be available through the member portal prior to your coverage effective date.  You will receive an email after enrollment with instructions for accessing the portal.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'How much do I pay when going to the doctor?',
        description:
            'Your copay will vary depending on the plan you select. All plans offer telemedicine at no charge; some plans require you to schedule a telemedicine appointment and receive authorization before an in-person visit. All plans also cover urgent care; some cover specialist visits; those copays vary depending on the plan you select.',
      ));
      insuranceFaqList.add(FAQList(
        title:
            'What happens if the doctor doesn’t recognize the carrier? Do I have to pay the entire amount up front?',
        description:
            'The program will accept billing from any provider. You should not pay for your services up front outside the standard copay. Ask your practitioner to call the number on the back of your card to confirm coverage. ',
      ));
      insuranceFaqList.add(FAQList(
        title:
            'Is there a medical provider, or PPO, network? Is there a list of preferred systems?',
        description:
            'We are using two of the largest provider networks in the United States for this program.  You can search for in-network providers at www.PSIProviderLookup.com.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'Is preventative care covered?',
        description:
            'Three plans - Visit Plus, Premium Health and Elite Health Plus – cover preventative care at 100%. The fourth plan, Direct 2.0, is a direct healthcare model and not a standard insurance plan.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'Are my prescriptions covered?',
        description:
            'These plans offer 200+ common prescriptions at \$0 copay; the formulary is limited but a discount program is available for all plans. Click here to check.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'Are there caps on plans?',
        description:
            'These are limited benefit plans that only cover certain medical needs, and there are limits on some of them.  As an example, on the Premium Health plan, the plan will only cover three advanced scanning services per year. Be sure to review the Schedule of Benefits and Coverages for the plan you are considering.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'May I talk to someone about the plans?',
        description:
            'Yes! You can click on the chat icon within the app or call the 800 number provided. Our representatives cannot make a recommendation – you must choose what works best for you – but they can help you understand the plans available to you.',
      ));
      insuranceFaqList.add(FAQList(
        title:
            'Once I’m enrolled, who do I call for help with claims? Who should my doctor call?',
        description:
            'There will be a telephone number on the back of your medical ID card for you and your providers to call for any questions. In addition, there will be phone number for you to call for help finding an in-network provider.',
      ));
      insuranceFaqList.add(FAQList(
        title: 'How can I change my payment information?',
        description:
            'You can log back into the app and click on ‘insurance’ to change your information.',
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
            itemCount: insuranceFaqList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) =>
                FaqActivity(faqList: insuranceFaqList[index]),
          )
        ],
      ),
    );
  }
}
