import 'package:flutter/cupertino.dart';

void myLoader(BuildContext context,String msg) {
  CupertinoAlertDialog alert= CupertinoAlertDialog(
    content: Row(
      children: [
        const CupertinoActivityIndicator(),
        Text("  $msg"),
      ],),
  );
  showCupertinoDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}