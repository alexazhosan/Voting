import 'dart:async';

import 'package:Voting/src/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegistrationBloc extends BaseBloc {
  RegistrationBloc() {
    _phoneController.stream.listen(onPhoneAdded);
    _codeController.stream.listen(onCodeAdded);
  }

  bool isEmpty = true;
  bool visibility = false;

  StreamController _phoneController = StreamController();
  Stream get phone => _phoneStream.stream;
  final _phoneStream = BehaviorSubject<bool>();
  Sink get addPhone => _phoneStream.sink;
  StreamSink get phoneSink => _phoneController.sink;

  StreamController _codeController = StreamController();
  Stream get code => _codeStream.stream;
  final _codeStream = BehaviorSubject<bool>();
  Sink get addCode => _codeStream.sink;
  StreamSink get codeSink => _codeController.sink;

  onPhoneAdded(data) async {
    addPhone.add(isEmpty);
  }

  onCodeAdded(data) async {
    addCode.add(visibility);
  }

  changePhoneNumber(data) async {
    isEmpty = data;
  }

  changeCode(data) async {
    visibility = data;
  }

  updateBloc() {
    phoneSink.add(null);
    codeSink.add(null);
  }

  updatePhoneNumber() {
    phoneSink.add(null);
  }

  updateCode() {
    codeSink.add(null);
  }

  navigateToPersonalInfo() {
    navigationService.navigateAndRemoveUntil("personal_info");
  }

  @override
  dispose() {
    _phoneController.close();
    _phoneStream.close();
    _codeController.close();
    _codeStream.close();
  }
}
