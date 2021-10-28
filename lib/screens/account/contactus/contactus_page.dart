import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/model/contact_us.dart';
import 'package:gigpoint/screens/account/contactus/writetous/write_to_us_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/webservices/graphql_api_client.dart';
import 'package:gigpoint/webservices/queries/contact_us_queries.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/errors_widget.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'contactus_card.dart';
import 'writetous/write_to_us_card.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();

  List<ContactUsList> contactUsList = [];

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: getIt<GraphQLApiClient>().client,
      child: Scaffold(
        appBar: const AppbarWidget(
          title: 'Contact Us',
          actions: [],
        ),
        body: NoNetworkWrapper(
          onRefresh: () {
            connectivityListnerBloc.refresh().then((value) {
              if (value) {
                setState(() {});
              }
            });
          },
          child: Query(
              options: getIt<GraphQLApiClient>()
                  .queryOptions(query: ContactUsQueries.getContactUsList),
              builder: (QueryResult result, {fetchMore, refetch}) {
                if (result.isLoading && result.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (result.hasException) {
                  getIt<GraphQLApiClient>().handleExceptions(result.exception);
                  return ErrorsWidget(exception: result.exception);
                } else {
                  ContactUs contactUs = ContactUs.fromJson(result.data!);
                  contactUsList = contactUs.contactUsList ?? [];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 19),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ContactUsCard(contactUsList: contactUsList),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen:
                                  WriteToUsPage(contactUsList: contactUsList),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: const WriteToUsCard(
                            title: 'Write to us',
                            desc:
                                'We are here to help. Tell us what we can help you with.',
                          ),
                        )
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
