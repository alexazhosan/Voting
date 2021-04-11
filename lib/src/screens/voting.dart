import 'package:Voting/src/helper/buffer.dart';
import 'package:Voting/src/helper/const_texts.dart';
import 'package:Voting/src/helper/ui_helper.dart';
import 'package:Voting/src/models/enums/voting_results.dart';
import 'package:flutter/material.dart';

class Voting extends StatefulWidget {
  @override
  _VotingState createState() => _VotingState();
}

class _VotingState extends State<Voting> with ConstTexts, UIHelper {
  int questionNumber = 1;
  String _currentQuestion = "";

  Widget _questionNumber() {
    return StreamBuilder<int>(
        stream: Buffer.blocObjects.votingBloc.questionNumber,
        builder: (context, snapshot) {
          questionNumber = snapshot.data == null ? 1 : snapshot.data;
          return Padding(
            padding: EdgeInsets.only(bottom: Buffer.height / 17),
            child: Text(question + "$questionNumber",
                style: Buffer.textStyles.cyan26bold,
                textAlign: TextAlign.center),
          );
        });
  }

  Widget _question() {
    return StreamBuilder<String>(
        stream: Buffer.blocObjects.votingBloc.question,
        builder: (context, snapshot) {
          _currentQuestion = snapshot.data == null ? "" : snapshot.data;
          return Container(
            height: Buffer.height / 3.5,
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: Buffer.width / 20,
                right: Buffer.width / 20,
                bottom: Buffer.height / 25),
            child: Text(_currentQuestion,
                style: Buffer.textStyles.black26bold,
                textAlign: TextAlign.center),
          );
        });
  }

  Widget _additionalInformation() {
    return Container(
      height: Buffer.height / 12,
      decoration: boxDecoration(Buffer.appColors.cyan),
      alignment: Alignment.center,
      child: Text(additionalInfo,
          style: Buffer.textStyles.cyan16, textAlign: TextAlign.center),
    );
  }

  Widget _additionalInfoFields() {
    return Container(
      height: Buffer.height / 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
              child: Text(table, style: Buffer.textStyles.black16),
              onTap: () {}),
          GestureDetector(
              child: Text(image, style: Buffer.textStyles.black16),
              onTap: () {}),
          GestureDetector(
              child: Text(present, style: Buffer.textStyles.black16),
              onTap: () {})
        ],
      ),
    );
  }

  Widget _perButton() {
    return FlatButton(
        child: Icon(Icons.add_circle,
            color: Buffer.appColors.lightGreen, size: Buffer.width / 6),
        onPressed: () {
          Buffer.blocObjects.votingBloc.answers.add(VotingResults.PER);
          Buffer.blocObjects.votingBloc.changeQuestionNumber(++questionNumber);
          Buffer.blocObjects.votingBloc.updateBloc();
        });
  }

  Widget _abstainButton() {
    return FlatButton(
        child: Icon(Icons.adjust,
            color: Buffer.appColors.white, size: Buffer.width / 5.5),
        onPressed: () {
          Buffer.blocObjects.votingBloc.answers.add(VotingResults.ABSTAIN);
          Buffer.blocObjects.votingBloc.changeQuestionNumber(++questionNumber);
          Buffer.blocObjects.votingBloc.updateBloc();
        });
  }

  Widget _againstButton() {
    return FlatButton(
        child: Icon(Icons.remove_circle,
            color: Buffer.appColors.red, size: Buffer.width / 6),
        onPressed: () {
          Buffer.blocObjects.votingBloc.answers.add(VotingResults.AGAINST);
          Buffer.blocObjects.votingBloc.changeQuestionNumber(++questionNumber);
          Buffer.blocObjects.votingBloc.updateBloc();
        });
  }

  Widget _voteFields() {
    return Container(
        height: Buffer.height / 10,
        color: Buffer.appColors.cyan,
        padding:
            EdgeInsets.only(left: Buffer.width / 25, right: Buffer.width / 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_perButton(), _abstainButton(), _againstButton()],
        ));
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        Buffer.width / 40,
        Buffer.height / 25,
        Buffer.width / 40,
        Buffer.height / 60,
      ),
      child: ListView(
        children: <Widget>[
          _questionNumber(),
          _question(),
          _additionalInformation(),
          _additionalInfoFields()
        ],
      ),
    );
  }

  @override
  void initState() {
    Buffer.blocObjects.votingBloc.changeQuestionNumber(1);
    Buffer.blocObjects.votingBloc.updateBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(Buffer.blocObjects.votingBloc.navigateToMenu),
        body: _body(),
        bottomSheet: _voteFields());
  }
}
