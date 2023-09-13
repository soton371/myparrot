import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/configs/my_sizes.dart';
import 'package:myparrot/widgets/my_text_field.dart';

class RecipientEmptyView extends StatelessWidget {
  const RecipientEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/phone_book.png",
              height: MySizes.emptyIcon,
              width: MySizes.emptyIcon,
            ),
            const Text(
              "There are no any\nrecipients saved yet\n\n",
              textAlign: TextAlign.center,
              style: TextStyle(color: MyColors.disable),
            ),
            CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                onPressed: () {
                  showCupertinoDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => CupertinoAlertDialog(
                            title: const Text("Add New Recipient"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                MyTextField(
                                  textController: nameController,
                                  placeholder: "Enter recipient name",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyTextField(
                                  textController: numberController,
                                  placeholder: "Enter recipient number",
                                )
                              ],
                            ),
                            actions: [
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              CupertinoDialogAction(
                                child: const Text("Save"),
                                onPressed: () {
                                  //all validation here
                                },
                              ),
                            ],
                          ));
                },
                child: const Text("Add Recipient"))
          ],
        ),
      ),
    );
  }
}
