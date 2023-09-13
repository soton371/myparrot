import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/models/recipient_mod.dart';
import 'package:myparrot/screens/recipient/recipient_empty.dart';
import 'package:myparrot/screens/recipient/recipient_list.dart';
import 'package:myparrot/utilities/recipient_crud.dart';

class RecipientScreen extends StatefulWidget {
  const RecipientScreen({super.key});

  @override
  State<RecipientScreen> createState() => _RecipientScreenState();
}

class _RecipientScreenState extends State<RecipientScreen> {
  List<RecipientModel> recipients = [];

  @override
  void initState() {
    super.initState();
    getRecipients().then((value) {
      setState(() {
        recipients = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return recipients.isNotEmpty ? const RecipientListView() : const RecipientEmptyView();
  }
}

