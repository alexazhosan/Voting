import 'package:Voting/src/routing/navigation_service.dart';

import '../../main.dart';

abstract class BaseBloc{
  final NavigationService navigationService = getIt<NavigationService>();
  dispose();
}