import 'package:Voting/src/helper/buffer.dart';
import 'package:Voting/src/helper/const_texts.dart';
import 'package:Voting/src/helper/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> with ConstTexts, UIHelper {
  TextEditingController _textEditingControllerForPhoneNumber =
      TextEditingController();
  MaskTextInputFormatter _codeFormatter =
      MaskTextInputFormatter(mask: '******', filter: {"*": RegExp(r'[0-9]')});

  bool visibility = false;

  Widget _authInfo() {
    return Container(
      margin: EdgeInsets.only(top: Buffer.height / 65),
      height: Buffer.height / 4,
      alignment: Alignment.center,
      child: Text(
        authRequired,
        style: Buffer.textStyles.green24bold,
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
      ),
    );
  }

  checkPhoneNumber(String result) {
    if (result.length == 1 && result != "+") {
      if (result == "7") {
        _textEditingControllerForPhoneNumber.text = "+7";
      } else {
        _textEditingControllerForPhoneNumber.text = "+7" + result;
      }
    } else if (result.length == 2 && result[0] == "+") {
      if (result.substring(0, 2) != "+7")
        _textEditingControllerForPhoneNumber.text = "+7" + result.substring(2);
    } else if (result.length > 2 && result[0] == "+") {
      if (result.substring(1, 2) != "7") {
        _textEditingControllerForPhoneNumber.text = "+7" + result.substring(1);
      }
    } else if (result.length > 2 && result[0] == "7") {
      _textEditingControllerForPhoneNumber.text = "+" + result;
    }
  }

  onChanged(String result) {
    Buffer.blocObjects.registerBloc.changePhoneNumber(true);
    Buffer.blocObjects.registerBloc.updatePhoneNumber();
    checkPhoneNumber(result);
    _textEditingControllerForPhoneNumber.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingControllerForPhoneNumber.text.length));
  }

  Widget _inputPhoneNumberField() {
    return StreamBuilder<bool>(
        stream: Buffer.blocObjects.registerBloc.phone,
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.only(top: Buffer.height / 10),
            decoration: boxDecoration(Buffer.appColors.darkGreen),
            child: TextField(
              controller: _textEditingControllerForPhoneNumber,
              cursorColor: Buffer.appColors.black,
              style: Buffer.textStyles.black16,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: inputDecoration(inputPhoneNumber),
              onChanged: (result) {
                onChanged(result);
              },
            ),
          );
        });
  }

  Widget _inputCodeField() {
    return StreamBuilder<bool>(
        stream: Buffer.blocObjects.registerBloc.code,
        builder: (context, snapshot) {
          visibility = snapshot.data == null ? false : snapshot.data;
          return Visibility(
              child: Container(
                margin: EdgeInsets.only(
                    top: Buffer.height / 15,
                    left: Buffer.width / 7,
                    right: Buffer.width / 7),
                decoration: boxDecoration(Buffer.appColors.darkGreen),
                child: TextField(
                  inputFormatters: [_codeFormatter],
                  cursorColor: Buffer.appColors.black,
                  style: Buffer.textStyles.black16,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration(inputCode),
                  keyboardType: TextInputType.number,
                ),
              ),
              visible: visibility);
        });
  }

  onPressed() {
    if (_textEditingControllerForPhoneNumber.text.length >= 12 &&
        _textEditingControllerForPhoneNumber.text.length < 15) {
      if (visibility == false) {
        Buffer.blocObjects.registerBloc.changeCode(true);
        Buffer.blocObjects.registerBloc.updateCode();
      } else if (_codeFormatter.getUnmaskedText().length == 6) {
        Buffer.blocObjects.registerBloc.navigateToPersonalInfo();
      }
    }
  }

  Widget _button() {
    return Container(
      margin: EdgeInsets.only(
          top: Buffer.height / 15,
          left: Buffer.width / 12,
          right: Buffer.width / 12),
      height: Buffer.height / 17,
      decoration: BoxDecoration(
        color: Buffer.appColors.darkGreen,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: FlatButton(
          focusColor: Buffer.appColors.white,
          child: Text(send, style: Buffer.textStyles.white18),
          onPressed: onPressed),
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          Buffer.width / 8, Buffer.height / 30, Buffer.width / 8, 0.0),
      child: ListView(
        children: <Widget>[
          _authInfo(),
          _inputPhoneNumberField(),
          _inputCodeField(),
          _button()
        ],
      ),
    );
  }

  @override
  void initState() {
    Buffer.blocObjects.registerBloc.changePhoneNumber(true);
    Buffer.blocObjects.registerBloc.changeCode(false);
    Buffer.blocObjects.registerBloc.updateBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  @override
  void dispose() {
    _textEditingControllerForPhoneNumber.dispose();
    super.dispose();
  }
}
