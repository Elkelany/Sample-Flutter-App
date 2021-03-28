import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<T> {
  BehaviorSubject<T> _events = BehaviorSubject<T>();
  BehaviorSubject<T> _states = BehaviorSubject<T>();

  Stream<T> get statesStream => _states.stream;

  Sink<T> get eventsSink => _events.sink;

  @protected
  Sink<T> get statesSink => _states.sink;

  BaseBloc() {
    _events.listen((message) {
      print("Receiving new event: $message");
      eventHandler(message);
    });

    _states.listen((message) {
      print("Pushing new state: $message");
    });
  }

  void dispose() {
    _events.close();
    _states.close();
  }

  @protected
  void eventHandler(T message);
}
