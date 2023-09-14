import 'package:flutter/material.dart';
import 'package:myparrot/models/pending_msg_mod.dart';
import 'package:myparrot/screens/summary/components/failed/failed_list_tile.dart';

class FailedListView extends StatelessWidget {
  const FailedListView({super.key, required this.failedMsgs});
  final List<Datum> failedMsgs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: failedMsgs.length,
        itemBuilder: (context, index) {
          final data = failedMsgs[index];
          return FailedListTile(failedMsg: data);
        });
  }
}