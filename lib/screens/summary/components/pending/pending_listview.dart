import 'package:flutter/material.dart';
import 'package:myparrot/models/pending_msg_mod.dart';
import 'package:myparrot/screens/summary/components/pending/pending_list_tile.dart';

class PendingListView extends StatelessWidget {
  const PendingListView({super.key, required this.pendingMsgs});
  final List<Datum> pendingMsgs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: pendingMsgs.length,
        itemBuilder: (context, index) {
          final data = pendingMsgs[index];
          return PendingListTile(pendingMsg: data);
        });
  }
}
