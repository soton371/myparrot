import 'package:flutter/cupertino.dart';

Future myDialog(
    {required BuildContext context,
    required String title,
    Widget? content,
    List<Widget>? actions}) {
  return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: content,
            actions: actions ?? [],
          ),);
}
