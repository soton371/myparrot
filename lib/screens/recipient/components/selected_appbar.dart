import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparrot/blocs/selected_recipient/selected_recipient_bloc.dart';
import 'package:myparrot/models/recipient_mod.dart';
import 'package:myparrot/screens/message/message_screen.dart';

class SelectedAppBar extends StatelessWidget {
  const SelectedAppBar(
      {super.key,
      required this.selectedCount,
      required this.selectRecipientList});
  final int selectedCount;
  final List<RecipientModel> selectRecipientList;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      leading: IconButton(
          onPressed: () {
            context.read<SelectedRecipientBloc>().add(CallUnselectRecipient());
          },
          icon: const Icon(CupertinoIcons.chevron_back)),
      title: Text("$selectedCount selected"),
      actions: [
        CupertinoButton(
            child: const Icon(CupertinoIcons.paperplane),
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (_) =>
                           MessageScreen(recipients: selectRecipientList,)));
            })
        
      ],
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: .5,
            width: double.maxFinite,
            color: Colors.grey.shade300,
          )),
    );
  }
}
