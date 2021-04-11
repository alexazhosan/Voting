import 'package:Voting/src/helper/buffer.dart';
import 'package:Voting/src/helper/const_texts.dart';
import 'package:flutter/material.dart';

mixin UIHelper on ConstTexts{
  Widget appbar(Function function) {
    return AppBar(
        backgroundColor: Buffer.appColors.cyan,
        automaticallyImplyLeading: false,
        title: FlatButton(
            child: Container(
              margin: EdgeInsets.only(left: Buffer.width / 4.2),
              child: Row(
                children: <Widget>[
                  Icon(Icons.menu,
                      size: Buffer.width / 12, color: Buffer.appColors.white),
                  SizedBox(width: Buffer.width / 50),
                  Text(menu, style: Buffer.textStyles.white20)
                ],
              ),
            ),
            onPressed: function
        ));
  }

  BoxDecoration boxDecoration(Color color) {
    return BoxDecoration(
        border: Border.all(width: 2, color: color));
  }

  InputDecoration inputDecoration(String title) {
    return InputDecoration(
        hintText: title,
        border: InputBorder.none,
        focusColor: Buffer.appColors.black,
        hintStyle: Buffer.textStyles.black16);
  }
}