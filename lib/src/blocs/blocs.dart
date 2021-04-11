import 'package:Voting/src/blocs/personal_info_bloc.dart';
import 'package:Voting/src/blocs/register_bloc.dart';
import 'package:Voting/src/blocs/results_list_bloc.dart';
import 'package:Voting/src/blocs/voting_bloc.dart';

class BlocObjects {
  RegistrationBloc registerBloc = RegistrationBloc();
  PersonalInfoBloc personalInfoBloc = PersonalInfoBloc();
  VotingBloc votingBloc = VotingBloc();
  ResultsListBloc resultsListBloc = ResultsListBloc();
}