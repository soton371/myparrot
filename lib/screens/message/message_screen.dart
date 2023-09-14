import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myparrot/models/message_mod.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key,required this.name, required this.number, this.pendingMsg});
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
      
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}"),
      ),
      body: Column(
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
        ],
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
