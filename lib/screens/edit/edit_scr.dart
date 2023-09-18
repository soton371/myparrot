import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forked_slider_button/forked_slider_button.dart';
import 'package:intl/intl.dart';
import 'package:myparrot/blocs/edit_msg/edit_msg_bloc.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/pending_msg_mod.dart';
import 'package:myparrot/screens/summary/summary_scr.dart';
import 'package:myparrot/widgets/my_dialog.dart';
import 'package:myparrot/widgets/my_loader.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.myMsg});
  final Datum myMsg;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  DateTime chosenDateTime = DateTime.now();
  String formattedDate = '';
  String formattedTime = '';
  DateTime getDateTime = DateTime.now().add(const Duration(minutes: 3));
  
  TextEditingController msgController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  bool listeningIs = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    getDateTime =
        DateFormat('dd-MM-yyyy HH:mm').parse(widget.myMsg.scheduledAt ?? '');
    chosenDateTime = getDateTime;
    formattedDate = DateFormat.MMMEd().format(getDateTime);
    formattedTime = DateFormat.jm().format(getDateTime);
    msgController = TextEditingController(text: widget.myMsg.message);
    _initSpeech();
  }
  
  @override
  void dispose() {
    super.dispose();
    _stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.myMsg.name ?? ''),
      ),
      body: BlocListener<EditMsgBloc, EditMsgState>(
        listener: (context, state) {
          if (state is EditMsgLoading) {
            myLoader(context, "Please wait..");
          } else if (state is EditMsgSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (_) => const SummaryScreen()));
          } else if (state is EditMsgFailed) {
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
                //add date time picker
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .fontSize,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          formattedTime,
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
                Text('\nMessage',
                    style: Theme.of(context).textTheme.titleLarge),
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
                SizedBox(
                  height: 20,
                ),

                //add for button
                SliderButton(
                  baseColor: MyColors.seed,
                  backgroundColor: MyColors.seed.shade50,
                  action: () {
                    final scheduledAt =
                        DateFormat('dd-MM-yyyy HH:mm').format(chosenDateTime);
                    context.read<EditMsgBloc>().add(DoEditMsg(
                        msgId: widget.myMsg.id.toString(),
                        message: msgController.text,
                        name: widget.myMsg.name ?? '',
                        phones: widget.myMsg.phones ?? '',
                        scheduledAt: scheduledAt));
                  },
                  dismissible: false,
                  label: const Text(
                    "Slide to update message",
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
            )),
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
                  initialDateTime: getDateTime,
                  minimumDate: DateTime.now().add(const Duration(minutes: 3)),
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
