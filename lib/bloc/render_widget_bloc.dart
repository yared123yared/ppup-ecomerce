import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

/// This class is used to stop re-render the classes when switching between tabs.
@lazySingleton
class RenderWidgetBloc {
  var subject = BehaviorSubject.seeded(0);
  Stream<int> get responseData => subject.stream;

  render(int index) => subject.sink.add(index);

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
