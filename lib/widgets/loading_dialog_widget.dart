import 'package:flutter/material.dart';

class LoadingDialogWidget extends Dialog {
  String text;

  LoadingDialogWidget({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(

        /// 透明
        type: MaterialType.transparency,

        /// 保证控件居中显示
        child: Center(
            child: SizedBox(
                width: 120.0,
                height: 120.0,
                child: Container(
                    decoration: ShapeDecoration(
                        color: Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(this.text,
                                style: new TextStyle(fontSize: 12.0)),
                          )
                        ])))));
  }
}
