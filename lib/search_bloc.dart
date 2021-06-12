import 'dart:async';

class SearchBloc {
  final _stateStreamController = StreamController<String>();

  StreamSink<String> get counterSink => _stateStreamController.sink;
  Stream<String> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<String>();

  StreamSink<String> get eventSink => _eventStreamController.sink;
  Stream<String> get eventStream => _eventStreamController.stream;

  SearchBloc() {
    eventStream.listen((keyword) {
      counterSink.add(keyword);
    });
  }
}
