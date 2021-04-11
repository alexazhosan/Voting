import 'package:Voting/src/blocs/menu_bloc.dart';
import 'package:Voting/src/helper/buffer.dart';
import 'package:Voting/src/helper/const_texts.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget with ConstTexts {
  MenuBloc _menuBloc = MenuBloc();

  Widget _personalInfo() {
    return GestureDetector(
      child: Container(
        color: Buffer.appColors.lightGreen,
        height: Buffer.height / 3.2,
        margin: EdgeInsets.only(bottom: Buffer.width / 90),
        padding: EdgeInsets.only(
            top: Buffer.height / 12, bottom: Buffer.height / 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.account_circle,
                color: Buffer.appColors.white, size: Buffer.height / 20),
            Text(personalInfo, style: Buffer.textStyles.white20bold)
          ],
        ),
      ),
      onTap: _menuBloc.navigateToPersonalInfo,
    );
  }

  Widget _voting() {
    return GestureDetector(
      child: Container(
          color: Buffer.appColors.cyan,
          height: Buffer.height / 3.2,
          margin: EdgeInsets.only(bottom: Buffer.width / 90),
          alignment: Alignment.center,
          child: Text(voting,
              style: Buffer.textStyles.white20bold,
              textAlign: TextAlign.center)),
      onTap: _menuBloc.navigateToVoting,
    );
  }

  Widget _problemReport() {
    return GestureDetector(
      child: Container(
          color: Buffer.appColors.darkGreen,
          height: Buffer.height / 3.2,
          margin: EdgeInsets.only(bottom: Buffer.width / 90),
          alignment: Alignment.center,
          child: Text(problemReport,
              style: Buffer.textStyles.white20bold,
              textAlign: TextAlign.center)),
      onTap: _menuBloc.navigateToReportProblem,
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.all(Buffer.width / 90),
      child: ListView(
        children: <Widget>[_personalInfo(), _voting(), _problemReport()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }
}
