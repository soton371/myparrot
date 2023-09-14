import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/recipient_mod.dart';
import 'package:myparrot/screens/summary/summary_scr.dart';
import 'package:myparrot/utilities/recipient_crud.dart';
import 'package:myparrot/widgets/my_dialog.dart';
import 'package:myparrot/widgets/my_text_field.dart';
import 'package:myparrot/screens/recipient/recipient_tile.dart';

class RecipientListView extends StatefulWidget {
  const RecipientListView({super.key, required this.recipients});
  final List<RecipientModel> recipients;

  @override
  State<RecipientListView> createState() => _RecipientListViewState();
}

class _RecipientListViewState extends State<RecipientListView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  List<RecipientModel> recipientList = [];

  @override
  void initState() {
    super.initState();
    recipientList = widget.recipients;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipient"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                nameController.clear();
                numberController.clear();
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
                                          child: const Text("Try again!"),
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

                                if (numberController.text.trim().length != 11) {
                                  myDialog(
                                      context: context,
                                      title: "Warning",
                                      content: const Text(
                                          "Please enter 11-digit number"),
                                      actions: [
                                        CupertinoDialogAction(
                                          textStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                                          child: const Text("Try again!"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        )
                                      ]);
                                  return;
                                }

                                if (numberController.text
                                    .trim()
                                    .contains(RegExp(r'^[a-zA-Z][a-zA-Z ]'))) {
                                  myDialog(
                                      context: context,
                                      title: "Warning",
                                      content:
                                          const Text('Number must be numeric'),
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

                                //here double number check
                                bool t = false;
                                for (var element in recipientList) {
                                  if (element.number ==
                                      numberController.text.trim()) {
                                    t = true;
                                    break;
                                  }
                                }

                                if (t) {
                                  myDialog(
                                      context: context,
                                      title: "Warning",
                                      content: const Text(
                                          "Please ignore duplicate number"),
                                      actions: [
                                        CupertinoDialogAction(
                                          textStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                                          child: const Text("Try again!"),
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
                                    recipientList = value;
                                    Navigator.pop(context);
                                    setState(() {});
                                  });
                                });
                              },
                            ),
                          ],
                        ));
              },
              icon: const Icon(
                CupertinoIcons.person_add,
                color: MyColors.seed,
              )),

          //for summary screen route
          IconButton(
              onPressed: () => Navigator.push(context,
                  CupertinoPageRoute(builder: (_) => const SummaryScreen())),
              icon: const Icon(
                CupertinoIcons.list_bullet,
                color: MyColors.seed,
              )),
        ],
      ),
      body: ListView.builder(
          itemCount: recipientList.length,
          itemBuilder: (context, index) {
            final data = recipientList[index];
            return Slidable(
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) {
                        nameController.clear();
                        numberController.clear();
                        nameController = TextEditingController(text: data.name);
                        numberController =
                            TextEditingController(text: data.number);
                        showCupertinoDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => CupertinoAlertDialog(
                                  title: const Text("Edit Recipient"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MyTextField(
                                        textController: nameController,
                                        placeholder: "Edit recipient name",
                                        inputType: TextInputType.name,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MyTextField(
                                        textController: numberController,
                                        placeholder: "Edit recipient number",
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
                                      child: const Text("Update"),
                                      onPressed: () {
                                        //all validation here
                                        if (nameController.text
                                                .trim()
                                                .isEmpty ||
                                            nameController.text.trim().length <
                                                3) {
                                          myDialog(
                                              context: context,
                                              title: "Warning",
                                              content: const Text(
                                                  "Please enter recipient full name"),
                                              actions: [
                                                CupertinoDialogAction(
                                                  textStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                                                  child:
                                                      const Text("Try again!"),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )
                                              ]);
                                          return;
                                        }

                                        if (numberController.text
                                                .trim()
                                                .length !=
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
                                                  child:
                                                      const Text("Try again!"),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )
                                              ]);
                                          return;
                                        }

                                        //here edit recipient
                                        updateRecipient(
                                                recipient: data,
                                                newName: nameController.text,
                                                newNumber:
                                                    numberController.text)
                                            .then((value1) {
                                          getRecipients().then((value) {
                                            setState(() {
                                              recipientList = value;
                                            });
                                            Navigator.pop(context);
                                          });
                                        });
                                      },
                                    ),
                                  ],
                                ));
                      },
                      backgroundColor: MyColors.seed,
                      foregroundColor: Colors.white,
                      icon: CupertinoIcons.pen,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (_) {
                        deleteRecipient(recipientList[index]).then((value1) {
                          getRecipients().then((value) {
                            setState(() {
                              recipientList = value;
                            });
                          });
                        });
                      },
                      backgroundColor: MyColors.dismiss,
                      foregroundColor: Colors.white,
                      icon: CupertinoIcons.trash,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: RecipientTile(
                  recipient: data,
                ));
          }),
    );
  }
}
