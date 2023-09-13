import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/recipient_mod.dart';
import 'package:myparrot/utilities/recipient_crud.dart';
import 'package:myparrot/widgets/my_dialog.dart';
import 'package:myparrot/widgets/my_text_field.dart';
import 'package:myparrot/widgets/recipient_tile.dart';

class RecipientListView extends StatefulWidget {
  RecipientListView({super.key, required this.recipients});
  List<RecipientModel> recipients;

  @override
  State<RecipientListView> createState() => _RecipientListViewState();
}

class _RecipientListViewState extends State<RecipientListView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

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
                                          child: const Text("Try again!"),
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
                                          child: const Text("Try again!"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        )
                                      ]);
                                  return;
                                }

                                //here double number check
                                bool t = false;
                                for (var element in widget.recipients) {
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
                                    widget.recipients = value;
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
              ))
        ],
      ),
      body: ListView.builder(
          itemCount: widget.recipients.length,
          itemBuilder: (context, index) {
            final data = widget.recipients[index];
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
                                              widget.recipients = value;
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
                        deleteRecipient(widget.recipients[index])
                            .then((value1) {
                          getRecipients().then((value) {
                            setState(() {
                              widget.recipients = value;
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
            // RecipientTile(
            //   recipient: data,
            // );
          }),
    );
  }
}
