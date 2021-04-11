import 'dart:async';

import 'package:Voting/src/blocs/base_bloc.dart';
import 'package:Voting/src/helper/buffer.dart';
import 'package:rxdart/rxdart.dart';

class ResultsListBloc extends BaseBloc {
  ResultsListBloc() {
    _codeController.stream.listen(onCodeAdded);
  }

  bool visibility = false;

  StreamController _codeController = StreamController();
  Stream get code => _codeStream.stream;
  final _codeStream = BehaviorSubject<bool>();
  Sink get addCode => _codeStream.sink;
  StreamSink get codeSink => _codeController.sink;

  onCodeAdded(data) async {
    addCode.add(visibility);
  }

  changeCode(data) async {
    visibility = data;
  }

  updateBloc() {
    codeSink.add(null);
  }

  navigateToMenu() {

    Buffer.blocObjects.votingBloc.answers.clear();
    navigationService.navigateAndRemoveUntil("/");
  }

  @override
  dispose() {
    _codeController.close();
    _codeStream.close();
  }
}
