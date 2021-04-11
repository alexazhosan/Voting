import 'package:Voting/src/helper/buffer.dart';
import 'package:Voting/src/helper/const_texts.dart';
import 'package:Voting/src/helper/ui_helper.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> with ConstTexts, UIHelper {
  bool isMember = false;
  bool isGardener = false;

  TextEditingController _personNameEditingController = TextEditingController();
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _streetEditingController = TextEditingController();
  TextEditingController _numberEditingController = TextEditingController();

  Widget _personalInfo() {
    return Padding(
      padding: EdgeInsets.only(left: Buffer.width / 18),
      child: Text(personalInfo,
          style: Buffer.textStyles.lightGreen20bold,
          textAlign: TextAlign.center),
    );
  }

  Widget _personNameField() {
    return Container(
      height: Buffer.height / 15,
      margin: EdgeInsets.only(top: Buffer.height / 30, left: Buffer.width / 18),
      decoration: boxDecoration(Buffer.appColors.lightGreen),
      child: TextField(
        controller: _personNameEditingController,
        cursorColor: Buffer.appColors.black,
        style: Buffer.textStyles.black18,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        decoration: inputDecoration(personName),
      ),
    );
  }

  Widget _nameField() {
    return Container(
      height: Buffer.height / 15,
      margin: EdgeInsets.only(top: Buffer.height / 50, left: Buffer.width / 18),
      decoration: boxDecoration(Buffer.appColors.lightGreen),
      child: TextField(
        controller: _nameEditingController,
        cursorColor: Buffer.appColors.black,
        style: Buffer.textStyles.black18,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        decoration: inputDecoration(name),
      ),
    );
  }

  Widget _streetField() {
    return Container(
      height: Buffer.height / 15,
      margin: EdgeInsets.only(top: Buffer.height / 50, left: Buffer.width / 18),
      decoration: boxDecoration(Buffer.appColors.lightGreen),
      child: TextField(
        controller: _streetEditingController,
        cursorColor: Buffer.appColors.black,
        style: Buffer.textStyles.black18,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        decoration: inputDecoration(street),
      ),
    );
  }

  Widget _numberField() {
    return Container(
      height: Buffer.height / 15,
      margin: EdgeInsets.only(
          top: Buffer.height / 50,
          bottom: Buffer.height / 50,
          left: Buffer.width / 18),
      decoration: boxDecoration(Buffer.appColors.lightGreen),
      child: TextField(
        controller: _numberEditingController,
        cursorColor: Buffer.appColors.black,
        style: Buffer.textStyles.black18,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        decoration: inputDecoration(number),
      ),
    );
  }

  Widget _member() {
    return Theme(
        child: CheckboxListTile(
          title: Text(member, style: Buffer.textStyles.black18),
          value: isMember,
          onChanged: (newValue) {
            isMember = newValue;
            isGardener = !isMember;
            Buffer.blocObjects.personalInfoBloc.changeMember(isMember);
            Buffer.blocObjects.personalInfoBloc.changeGardener(isGardener);
            Buffer.blocObjects.personalInfoBloc.updateBloc();
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        data: ThemeData(
          primarySwatch: Colors.green,
          unselectedWidgetColor: Buffer.appColors.lightGreen,
        ));
  }

  Widget _memberCheckBox() {
    return StreamBuilder<bool>(
        stream: Buffer.blocObjects.personalInfoBloc.member,
        builder: (context, snapshot) {
          isMember = snapshot.data == null ? false : snapshot.data;
          return Container(
            height: Buffer.height / 20,
            child: _member(),
          );
        });
  }

  Widget _gardener() {
    return Theme(
        child: CheckboxListTile(
          title: Text(gardener, style: Buffer.textStyles.black18),
          value: isGardener,
          onChanged: (newValue) {
            isGardener = newValue;
            isMember = !isGardener;
            Buffer.blocObjects.personalInfoBloc.changeMember(isMember);
            Buffer.blocObjects.personalInfoBloc.changeGardener(isGardener);
            Buffer.blocObjects.personalInfoBloc.updateBloc();
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        data: ThemeData(
          primarySwatch: Colors.green,
          unselectedWidgetColor: Buffer.appColors.lightGreen,
        ));
  }

  Widget _gardenerCheckBox() {
    return StreamBuilder<bool>(
        stream: Buffer.blocObjects.personalInfoBloc.gardener,
        builder: (context, snapshot) {
          isGardener = snapshot.data == null ? false : snapshot.data;
          return Container(
            margin: EdgeInsets.only(top: Buffer.height / 60),
            child: _gardener(),
          );
        });
  }

  Widget _button() {
    return Container(
      margin: EdgeInsets.only(
          top: Buffer.height / 30,
          left: Buffer.width / 6.5,
          right: Buffer.width / 10),
      height: Buffer.height / 17,
      decoration: BoxDecoration(
        color: Buffer.appColors.lightGreen,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: FlatButton(
        focusColor: Buffer.appColors.white,
        child: Text(save, style: Buffer.textStyles.black18),
        onPressed: Buffer.blocObjects.personalInfoBloc.navigateToMenu,
      ),
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        0.0,
        Buffer.height / 25,
        Buffer.width / 18,
        Buffer.height / 60,
      ),
      child: ListView(
        children: <Widget>[
          _personalInfo(),
          _personNameField(),
          _nameField(),
          _streetField(),
          _numberField(),
          _memberCheckBox(),
          _gardenerCheckBox(),
          _button()
        ],
      ),
    );
  }

  @override
  void initState() {
    Buffer.blocObjects.personalInfoBloc.changeMember(false);
    Buffer.blocObjects.personalInfoBloc.changeGardener(false);
    Buffer.blocObjects.personalInfoBloc.updateBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(Buffer.blocObjects.personalInfoBloc.navigateToMenu),
      body: _body(),
    );
  }
}
