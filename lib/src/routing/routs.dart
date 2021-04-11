import 'package:Voting/src/screens/menu.dart';
import 'package:Voting/src/screens/personal_info.dart';
import 'package:Voting/src/screens/registration.dart';
import 'package:Voting/src/screens/results_list.dart';
import 'package:Voting/src/screens/voting.dart';
import 'package:flutter/material.dart';

checkPageName(String route) {
  if (route == "/") {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => Menu(),
      transitionsBuilder: (_, anim, __, child) {
        Animation<Offset> customAnimation =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(anim);
        return SlideTransition(position: customAnimation, child: child);
      },
    );
  }
  if(route == "register") {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => Registration(),
      transitionsBuilder: (_, anim, __, child) {
        Animation<Offset> customAnimation =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(anim);
        return SlideTransition(position: customAnimation, child: child);
      },
    );
  }
  if(route == "personal_info") {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => PersonalInfo(),
      transitionsBuilder: (_, anim, __, child) {
        Animation<Offset> customAnimation =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(anim);
        return SlideTransition(position: customAnimation, child: child);
      },
    );
  }
  if(route == "voting") {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => Voting(),
      transitionsBuilder: (_, anim, __, child) {
        Animation<Offset> customAnimation =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(anim);
        return SlideTransition(position: customAnimation, child: child);
      },
    );
  }
  if(route == "results_list") {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => ResultsList(),
      transitionsBuilder: (_, anim, __, child) {
        Animation<Offset> customAnimation =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(anim);
        return SlideTransition(position: customAnimation, child: child);
      },
    );
  }
  return null;
}