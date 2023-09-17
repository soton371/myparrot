import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparrot/blocs/identifier/identifier_bloc.dart';
import 'package:myparrot/models/recipient_mod.dart';
import 'package:myparrot/screens/recipient/components/recipient_empty.dart';
import 'package:myparrot/screens/recipient/components/recipient_list.dart';
import 'package:myparrot/utilities/recipient_crud.dart';

class RecipientScreen extends StatefulWidget {
  const RecipientScreen({super.key});

  @override
  State<RecipientScreen> createState() => _RecipientScreenState();
}

class _RecipientScreenState extends State<RecipientScreen> {
  List<RecipientModel> recipients = [];
  bool load = true;

  @override
  void initState() {
    super.initState();
    getRecipients().then((value) {
      recipients = value;
      load = false;
      setState(() {});
    });
    context.read<IdentifierBloc>().add(FetchIdentifierEvent());
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? const Scaffold(
            body: Center(
            child: CupertinoActivityIndicator(),
          ))
        : recipients.isNotEmpty
            ? RecipientListView(
                recipients: recipients,
              )
            : const RecipientEmptyView();
  }
}
