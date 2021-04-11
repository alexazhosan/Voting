import 'package:Voting/src/helper/buffer.dart';
import 'package:Voting/src/helper/const_texts.dart';
import 'package:Voting/src/helper/ui_helper.dart';
import 'package:Voting/src/models/enums/voting_results.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ResultsList extends StatefulWidget {
  @override
  _ResultsListState createState() => _ResultsListState();
}

class _ResultsListState extends State<ResultsList> with ConstTexts, UIHelper {
  bool visibility = false;
  MaskTextInputFormatter _codeFormatter =
      MaskTextInputFormatter(mask: '******', filter: {"*": RegExp(r'[0-9]')});

  Widget _votingResults() {
    return Padding(
      padding: EdgeInsets.only(bottom: Buffer.height / 20),
      child: Text(results,
          style: Buffer.textStyles.cyan26bold, textAlign: TextAlign.center),
    );
  }

  Widget _answer(VotingResults result) {
    return Container(
      width: Buffer.width / 5.5,
      height: Buffer.height / 20,
      color: Buffer.appColors.darkGreen,
      alignment: Alignment.center,
      child: Text(
          result == VotingResults.PER
              ? per
              : result == VotingResults.AGAINST ? against : abstain,
          style: Buffer.textStyles.white16,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center),
    );
  }

  Widget _resultsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: Buffer.blocObjects.votingBloc.questions.length,
        itemBuilder: (BuildContext context, int index) {
          VotingResults result = Buffer.blocObjects.votingBloc.answers[index];
          return Container(
              margin: EdgeInsets.only(bottom: Buffer.height / 77),
              child: ListTile(
                  title: Text(question + "${index + 1}",
                      style: Buffer.textStyles.black18bold),
                  subtitle: Text(Buffer.blocObjects.votingBloc.questions[index],
                      style: Buffer.textStyles.black16),
                  trailing: _answer(result)));
        },
      ),
    );
  }

  Widget _inputCodeField() {
    return StreamBuilder<bool>(
        stream: Buffer.blocObjects.resultsListBloc.code,
        builder: (context, snapshot) {
          visibility = snapshot.data == null ? false : snapshot.data;
          return Visibility(
              child: Container(
                margin: EdgeInsets.only(
                    bottom: Buffer.height / 10,
                    left: Buffer.width / 6,
                    right: Buffer.width / 6),
                decoration: boxDecoration(Buffer.appColors.cyan),
                child: TextField(
                  inputFormatters: [_codeFormatter],
                  cursorColor: Buffer.appColors.black,
                  style: Buffer.textStyles.black16,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration(enterCode),
                  keyboardType: TextInputType.number,
                ),
              ),
              visible: visibility);
        });
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        Buffer.width / 40,
        Buffer.height / 25,
        Buffer.width / 40,
        Buffer.height / 60,
      ),
      child: Column(
        children: <Widget>[_votingResults(), _resultsList(), _inputCodeField()],
      ),
    );
  }

  Widget _bottomSheet() {
    return Container(
      height: Buffer.height / 10,
      width: Buffer.width,
      color: Buffer.appColors.cyan,
      child: FlatButton(
        child: Text(confirm, style: Buffer.textStyles.white24bold),
        onPressed: () {
          if (visibility == false) {
            Buffer.blocObjects.resultsListBloc.changeCode(true);
            Buffer.blocObjects.resultsListBloc.updateBloc();
          } else if (_codeFormatter.getUnmaskedText().length == 6) {
            Buffer.blocObjects.resultsListBloc.navigateToMenu();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    Buffer.blocObjects.resultsListBloc.changeCode(false);
    Buffer.blocObjects.resultsListBloc.updateBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(Buffer.blocObjects.votingBloc.navigateToMenu),
        body: _body(),
        bottomSheet: _bottomSheet());
  }
}
