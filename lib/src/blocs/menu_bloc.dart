import 'package:Voting/src/blocs/base_bloc.dart';

class MenuBloc extends BaseBloc {
  navigateToPersonalInfo() {}

  navigateToVoting() {
    navigationService.navigateTo("voting");
  }

  navigateToReportProblem() {}

  @override
  dispose() {}
}