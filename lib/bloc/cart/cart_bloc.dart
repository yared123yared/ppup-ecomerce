import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class CartBloc {
  final Repository repository;
  CartBloc(this.repository);

  var subject = BehaviorSubject<List<Product>>();
  Stream<List<Product>> get responseData => subject.stream;

  getCart() async {
    List<Product>? cartProducts = HiveHelper.cartBox.values.toList();
    subject.sink.add(cartProducts);
  }

  addToCart(Product product) async {
    // print(HiveHelper.cartBox.values);

    ///Get the existing items from the cart.
    List<Product> cartProducts = HiveHelper.cartBox.values.toList();

    ///Check if the product already exists in the cart.
    int index = cartProducts.indexWhere((element) => element.id == product.id);
    if (index == -1) {
      ///Store it to local storage.
      await HiveHelper.cartBox.add(product);

      ///Add product to existing items.
      cartProducts.add(product);

      ///Update the UI.
      subject.sink.add(cartProducts);
    }
  }

  updateProduct(Product product) async {
    List<Product> cartProducts = HiveHelper.cartBox.values.toList();
    int index = cartProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      await HiveHelper.cartBox.putAt(index, product);

      ///Update the UI.
      subject.sink.add(cartProducts);
    }
  }

  removeProduct(Product product) async {
    List<Product> cartProducts = HiveHelper.cartBox.values.toList();
    int index = cartProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      await HiveHelper.cartBox.deleteAt(index);

      ///Remove Item from list.
      cartProducts.removeAt(index);

      ///Update the UI.
      subject.sink.add(cartProducts);
    }
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
