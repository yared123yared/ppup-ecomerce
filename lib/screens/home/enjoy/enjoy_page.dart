import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/shop/get_categores_bloc.dart';
import 'package:gigpoint/model/categories.dart';
import 'package:gigpoint/screens/home/enjoy/enjoy_card.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';

class EnjoyPage extends StatefulWidget {
  const EnjoyPage({Key? key}) : super(key: key);

  @override
  _EnjoyPageState createState() => _EnjoyPageState();
}

class _EnjoyPageState extends State<EnjoyPage> {
  @override
  void initState() {
    super.initState();
    getIt<GetCategoriesBloc>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: 'Enjoy',
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: categories.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          itemBuilder: (BuildContext context, int index) {
            return EnjoyCard(category: categories[index]);
          }),
    );
  }
}

List<Category> categories = [
  Category(
    id: '91393283',
    name: '202',
    title: 'Personal',
    notes:
        'Find everything from jewelry and apparel to gift cards and luggage.',
    mainImageHash: Images.purhasePersonal,
  ),
  Category(
    id: '91394261',
    name: '221',
    title: 'Housewares',
    notes:
        'Features products like appliances, kitchenware, and home improvement.',
    mainImageHash: Images.purhaseHouseware,
  ),
  Category(
    id: '91393859',
    name: '210',
    title: 'Recreation',
    notes: 'Discover outdoor exploration, travel, games, and sporting goods.',
    mainImageHash: Images.purhaseRecreation,
  ),
  Category(
    id: '91393625',
    name: '205',
    title: 'Electronics',
    notes:
        'Showcases audio, TV/video, tablets, computer, and other technology products.',
    mainImageHash: Images.purhaseElectronics,
  ),
  //Category(
  // id: '92688596',
  //name: 'ecertificates',
  //title: 'eCertificates',
  //notes: 'Purchase Electronics, Homewares..etc with Points',
  //mainImageHash: Images.purhaseeCertificates,
  //),
  Category(
    id: '91394749',
    name: '174751',
    title: 'Entertainment',
    notes:
        'Explore digital card downloads for Xbox, Apple, PlayStation, and more.',
    mainImageHash: Images.purhaseMusic,
  ),
];
