import 'dart:async';

import 'package:Voting/src/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PersonalInfoBloc extends BaseBloc {
  PersonalInfoBloc() {
    _memberController.stream.listen(onMemberAdded);
    _gardenerController.stream.listen(onGardenerAdded);
  }

  bool isMember = false;
  bool isGardner = false;

  StreamController _memberController = StreamController();
  Stream get member => _memberStream.stream;
  final _memberStream = BehaviorSubject<bool>();
  Sink get addMember => _memberStream.sink;
  StreamSink get memberSink => _memberController.sink;

  StreamController _gardenerController = StreamController();
  Stream get gardener => _gardenerStream.stream;
  final _gardenerStream = BehaviorSubject<bool>();
  Sink get addGardener => _gardenerStream.sink;
  StreamSink get gardenerSink => _gardenerController.sink;

  onMemberAdded(data) async {
    addMember.add(isMember);
  }

  onGardenerAdded(data) async {
    addGardener.add(isGardner);
  }

  changeMember(data) async {
    isMember = data;
  }

  changeGardener(data) async {
    isGardner = data;
  }

  updateBloc() {
    memberSink.add(null);
    gardenerSink.add(null);
  }

  navigateToMenu() {
    navigationService.navigateAndRemoveUntil("/");
  }

  @override
  dispose() {
    _memberController.close();
    _memberStream.close();
    _gardenerController.close();
    _gardenerStream.close();
  }
}
