import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key, required this.textController, required this.placeholder,required this.inputType});
  final TextEditingController textController;
  final String placeholder;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholder: placeholder,
      controller: textController,
      keyboardType: inputType,
      inputFormatters: inputType == TextInputType.number ? [
        FilteringTextInputFormatter.allow(RegExp('^[0-9]*')),
      ]:null,
    );
  }
}
