import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forked_slider_button/forked_slider_button.dart';
import 'package:intl/intl.dart';
import 'package:myparrot/blocs/identifier/identifier_bloc.dart';
import 'package:myparrot/blocs/selected_recipient/selected_recipient_bloc.dart';
import 'package:myparrot/blocs/send_msg/send_msg_bloc.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/recipient_mod.dart';
import 'package:myparrot/screens/summary/summary_scr.dart';
import 'package:myparrot/widgets/my_dialog.dart';
import 'package:myparrot/widgets/my_loader.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, required this.recipients});
  // final String? name, number;
  final List<RecipientModel> recipients;

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
  final SpeechToText _speechToText = SpeechToText();
  bool listeningIs = false;
  String _lastWords = '';

  List<String> names = [];
  List<String> numbers = [];

  void findNameNumber() {
    names = [];
    numbers = [];
    for (var element in widget.recipients) {
      names.add(element.name);
      numbers.add(element.number);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
    findNameNumber();
  }

  @override
  void dispose() {
    super.dispose();
    _stopListening();
  }

  @override
  Widget build(BuildContext context) {
    final identifierBloc = BlocProvider.of<IdentifierBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: names.length > 1
            ? const Text("Message")
            : Text(names.toString().replaceAll('[', '').replaceAll(']', '')),
      ),
      body: BlocListener<SendMsgBloc, SendMsgState>(
        listener: (context, state) {
          if (state is SendMsgLoading) {
            myLoader(context, "Please wait..");
          } else if (state is SendMsgSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (_) => const SummaryScreen()));
          } else if (state is SendMsgFailed) {
            Navigator.pop(context);
            myDialog(
                context: context,
                title: "Warning",
                content: Text(state.errorMsg),
                actions: [
                  CupertinoDialogAction(
                    textStyle: const TextStyle(fontWeight: FontWeight.w500),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"),
                  )
                ]);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              //for name
              names.length > 1
                  ? SizedBox(
                      height: 35,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: names.length,
                          itemBuilder: (_, index) => Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: MyColors.inputBg,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(names[index]),
                                          Text(numbers[index],style: const TextStyle(fontSize: 8,color: MyColors.disable),),
                                        ],
                                      ),
                                      const SizedBox(width: 5,),
                                    InkWell(
                                        onTap: () {
                                          //name & number delete
                                          context
                                              .read<SelectedRecipientBloc>()
                                              .add(CallUnselectRecipient());
                                          names.removeAt(index);
                                          numbers.removeAt(index);
                                          setState(() {});
                                        },
                                        child: const Icon(
                                          CupertinoIcons.multiply_circle_fill,
                                          size: 15,
                                          color: MyColors.disable,
                                        ))
                                  ],
                                ),
                              )),
                    )
                  : const SizedBox(),
              //end name
              const SizedBox(
                height: 10,
              ),

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

              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.inputBg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintText: listeningIs
                                ? "Listening.."
                                : "Type message here",
                            border: InputBorder.none),
                        controller: msgController,
                      ),
                    ),
                    //for voice to text
                    AvatarGlow(
                      glowColor: MyColors.seed,
                      endRadius: 25.0,
                      duration: const Duration(milliseconds: 2000),
                      repeat: true,
                      showTwoGlows: true,
                      animate: listeningIs,
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      child: CupertinoButton(
                        onPressed:
                            listeningIs ? _stopListening : _startListening,
                        child: const Icon(CupertinoIcons.mic),
                      ),
                    )
                  ],
                ),
              ),
              //end msg
              const SizedBox(
                height: 20,
              ),
              //add for button
              SliderButton(
                baseColor: MyColors.seed,
                backgroundColor: MyColors.seed.shade50,
                action: () {
                  final scheduledAt =
                      DateFormat('dd-MM-yyyy HH:mm').format(chosenDateTime);
                  debugPrint("scheduledAt: $scheduledAt");
                  context
                      .read<SelectedRecipientBloc>()
                      .add(CallUnselectRecipient());
                  context.read<SendMsgBloc>().add(DoSendMsg(
                      deviceId: identifierBloc.identifier,
                      message: msgController.text.trim(),
                      name: names
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', ''),
                      phone: numbers
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', ''),
                      scheduledAt: scheduledAt));
                },
                dismissible: false,
                label: const Text(
                  "Slide to send message",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
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
  // all voice method

  void _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    listeningIs = true;
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    listeningIs = false;
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      msgController = TextEditingController(text: _lastWords);
    });
  }
}
