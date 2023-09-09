import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  TwilioFlutter? twilioFlutter;

  @override
  void initState() {
    twilioFlutter =
        TwilioFlutter(accountSid: 'ACf31555922d1c0a1d704e0be29aab8421', authToken: '374e523498a6013cd937c6f177785cea', twilioNumber: '+12568183852');

    super.initState();
  }

  void sendSms() async {
    if(twilioFlutter == null){
      debugPrint("twilioFlutter is null");
      return;
    }
    twilioFlutter?.sendSMS(toNumber: '+8801518606399', messageBody: 'hello world');
  }

  void sendWhatsApp() {
    if(twilioFlutter == null){
      debugPrint("twilioFlutter is null");
      return;
    }
    twilioFlutter?.sendWhatsApp(toNumber: '+8801763483781', messageBody: 'hello world wp');
  }

  void getSms() async {
    if(twilioFlutter == null){
      debugPrint("twilioFlutter is null");
      return;
    }
    var data = await twilioFlutter?.getSmsList();
    debugPrint("data: $data");

    // await twilioFlutter.getSMS('***************************');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: sendSms, child: const Text("Send SMS")),
          ElevatedButton(onPressed: getSms, child: const Text("Get SMS")),
        ],
      ),
    );
  }
}
