import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparrot/blocs/delete_msg/delete_msg_bloc.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/pending_msg_mod.dart';
import 'package:myparrot/screens/summary/summary_scr.dart';
import 'package:myparrot/utilities/format_date.dart';
import 'package:myparrot/widgets/my_dialog.dart';
import 'package:myparrot/widgets/my_loader.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen(
      {super.key, required this.myMessage, this.isPending = false});
  final Datum myMessage;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: isPending
            ? [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.pen,
                      color: MyColors.seed,
                    )),
                IconButton(
                    onPressed: () {
                      myDialog(
                          context: context,
                          title: "Delete of this message?",
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("Cancel"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            CupertinoDialogAction(
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                              onPressed: () {
                                context
                                    .read<DeleteMsgBloc>()
                                    .add(DoDeleteMsg(msgId: "${myMessage.id}"));
                              },
                              isDestructiveAction: true,
                              child: const Text("Delete"),
                            ),
                          ]);
                    },
                    icon: const Icon(
                      CupertinoIcons.trash,
                      color: MyColors.seed,
                    )),
              ]
            : null,
      ),
      body: BlocListener<DeleteMsgBloc, DeleteMsgState>(
        listener: (context, state) {
          if (state is DeleteMsgLoading) {
            myLoader(context, "Please wait..");
          } else if (state is DeleteMsgSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (_) => const SummaryScreen()));
          } else if (state is DeleteMsgFailed) {
            Navigator.pop(context);
            Navigator.pop(context);
            myDialog(
                context: context,
                title: "Warning",
                content: Text(state.errorMsg),
                actions: [
                  CupertinoDialogAction(
                    textStyle: const TextStyle(fontWeight: FontWeight.w500),
                    child: const Text("Ok"),
                    onPressed: () => Navigator.pop(context),
                  )
                ]);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //for icon
                    ClipOval(
                      child: Container(
                        height: 50,
                        width: 50,
                        color: MyColors.myRandomColor(),
                        alignment: Alignment.center,
                        child: Text(
                          myMessage.name.toString().substring(0, 1),
                          style: const TextStyle(
                              fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                    //end icon
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myMessage.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            myMessage.phones.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      formatDate(myMessage.scheduledAt.toString()),
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  myMessage.message.toString(),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
