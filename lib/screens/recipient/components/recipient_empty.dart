import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/configs/my_sizes.dart';
import 'package:myparrot/screens/recipient/components/recipient_list.dart';
import 'package:myparrot/utilities/recipient_crud.dart';
import 'package:myparrot/widgets/my_dialog.dart';
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
                                  inputType: TextInputType.name,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyTextField(
                                  textController: numberController,
                                  placeholder: "Enter recipient number",
                                  inputType: TextInputType.number,
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
                                textStyle: const TextStyle(fontWeight: FontWeight.w500),
                                child: const Text("Save"),
                                onPressed: () {
                                  //all validation here
                                  if (nameController.text.trim().isEmpty ||
                                      nameController.text.trim().length < 3) {
                                    myDialog(
                                        context: context,
                                        title: "Warning",
                                        content: const Text(
                                            "Please enter recipient full name"),
                                        actions: [
                                          CupertinoDialogAction(
                                            textStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                                            child: const Text("Try again"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          )
                                        ]);
                                    return;
                                  }
                                  if (!nameController.text.trim().startsWith(
                                      RegExp(r'^[a-zA-Z][a-zA-Z ]'))) {
                                    myDialog(
                                        context: context,
                                        title: "Warning",
                                        content: const Text(
                                            'Name must start with a letter'),
                                        actions: [
                                          CupertinoDialogAction(
                                            textStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                                            child: const Text("Try again"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          )
                                        ]);
                                    return;
                                  }

                                  if (numberController.text.trim().length !=
                                      11) {
                                    myDialog(
                                        context: context,
                                        title: "Warning",
                                        content: const Text(
                                            "Please enter 11-digit number"),
                                        actions: [
                                          CupertinoDialogAction(
                                            textStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                                            child: const Text("Try again"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          )
                                        ]);
                                    return;
                                  }

                                  if (numberController.text.trim().contains(
                                    RegExp(r'^[a-zA-Z][a-zA-Z ]'))) {
                                  myDialog(
                                      context: context,
                                      title: "Warning",
                                      content: const Text(
                                          'Number must be numeric'),
                                      actions: [
                                        CupertinoDialogAction(
                                          textStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                                          child: const Text("Try again"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        )
                                      ]);
                                  return;
                                }

                                  //here add recipient
                                  addRecipient(
                                          name: nameController.text.trim(),
                                          number: numberController.text.trim())
                                      .then((value1) {
                                    getRecipients().then((value) {
                                      Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (_) => RecipientListView(
                                                    recipients: value,
                                                  )));
                                    });
                                  });
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
