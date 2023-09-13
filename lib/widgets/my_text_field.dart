import 'package:flutter/cupertino.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.textController, required this.placeholder});
  final TextEditingController textController;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholder: placeholder,
      controller: textController,
    );
    /*
      TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MySizes.radius),
            borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
    */
  }
}
