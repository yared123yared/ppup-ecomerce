import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class PaginationLoadingBloc {
  var subject = BehaviorSubject.seeded(false);
  Stream<bool> get responseData => subject.stream;

  showLoading() => subject.sink.add(true);

  stopLoading() => subject.sink.add(false);

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
