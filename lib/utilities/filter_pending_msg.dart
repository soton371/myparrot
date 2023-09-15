import 'package:flutter/material.dart';
import 'package:myparrot/models/pending_msg_mod.dart';

List<Datum> filterPendingMsg(String selectDate, List<Datum> pendingMsgs) {
  debugPrint("selectDate: $selectDate :: pendingMsgs: ${pendingMsgs.length}");
  return pendingMsgs
      .where((element) => element.date == selectDate)
      .toList();
}
