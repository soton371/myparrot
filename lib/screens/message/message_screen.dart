import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forked_slider_button/forked_slider_button.dart';
import 'package:intl/intl.dart';
import 'package:myparrot/blocs/identifier/identifier_bloc.dart';
import 'package:myparrot/blocs/send_msg/send_msg_bloc.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/message_mod.dart';
import 'package:myparrot/widgets/my_dialog.dart';
import 'package:myparrot/widgets/my_loader.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen(
      {super.key, required this.name, required this.number, this.pendingMsg});
  final String? name, number;
  final MessageModel? pendingMsg;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  DateTime chosenDateTime = DateTime.now().add(const Duration(minutes: 2));
  String formattedDate = '';
  String formattedTime = '';
  String initShowDate = DateFormat.MMMEd().format(DateTime.now());
  String initTime =
      DateFormat.jm().format(DateTime.now().add(const Duration(minutes: 2)));

  TextEditingController msgController = TextEditingController();
  String msg = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final identifierBloc = BlocProvider.of<IdentifierBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}"),
      ),
      body: BlocListener<SendMsgBloc, SendMsgState>(
        listener: (context, state) {
          if (state is SendMsgLoading) {
            myLoader(context, "Please wait..");
          } else if (state is SendMsgSuccess) {
            myDialog(context: context, title: "Route Summary", actions: [
              CupertinoDialogAction(
                child: const Text("Ok"),
                onPressed: () => Navigator.pop(context),
              )
            ]);
          } else if (state is SendMsgFailed) {
            Navigator.pop(context);
            myDialog(
                context: context,
                title: "Warning",
                content: Text(state.errorMsg),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("Ok"),
                    onPressed: () => Navigator.pop(context),
                  )
                ]);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //add date time picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate.isEmpty ? initShowDate : formattedDate,
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .fontSize,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        formattedTime.isEmpty ? initTime : formattedTime,
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _showDatePicker(context),
                      child: const Icon(CupertinoIcons.pen))
                ],
              ),
              //end date time picker

              //start msg
              Text('\nMessage', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: 8,
              ),
              CupertinoTextField(
                controller: msgController,
                maxLines: 4,
                onChanged: (v) {
                  setState(() {
                    msg = v;
                  });
                },
              ),
              //end msg
              const SizedBox(
                height: 20,
              ),
              //add for button
              msg.trim().isEmpty
                  ? const SizedBox()
                  : SliderButton(
                      baseColor: MyColors.seed,
                      backgroundColor: MyColors.seed.shade50,
                      action: () {
                        final scheduledAt = DateFormat('dd-MM-yyyy HH:mm')
                            .format(chosenDateTime);
                        debugPrint("scheduledAt: $scheduledAt");
                        context.read<SendMsgBloc>().add(DoSendMsg(
                            deviceId: identifierBloc.identifier,
                            message: msgController.text,
                            name: widget.name ?? '',
                            phones: widget.number ?? '',
                            scheduledAt: scheduledAt));
                      },
                      dismissible: false,
                      label: const Text(
                        "Slide to send message",
                        style: TextStyle(
                            color: Color(0xff4a4a4a),
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                      icon: const Icon(CupertinoIcons.right_chevron),
                      height: 55,
                      buttonSize: 50,
                      width: double.maxFinite,
                      alignLabel: Alignment.center,
                      radius: 10,
                    ),
              //end for button
            ],
          ),
        ),
      ),
    );
  }

  //all method
  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 302,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Close the modal
                CupertinoButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),

                //date convert
                CupertinoButton(
                  child: const Text(
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    formattedDate = DateFormat.MMMEd().format(chosenDateTime);
                    formattedTime = DateFormat.jm().format(chosenDateTime);
                    debugPrint(
                        "formattedDate: $formattedDate , formattedTime: $formattedTime");
                    setState(() {});
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                  initialDateTime:
                      DateTime.now().add(const Duration(minutes: 3)),
                  minimumDate: DateTime.now().add(const Duration(minutes: 2)),
                  maximumDate: DateTime.now().add(const Duration(days: 60)),
                  onDateTimeChanged: (val) {
                    setState(() {
                      chosenDateTime = val;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
