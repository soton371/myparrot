import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/pending_msg_mod.dart';
import 'package:myparrot/utilities/format_date.dart';

class PendingListTile extends StatelessWidget {
  const PendingListTile({super.key, required this.pendingMsg});
  final Datum pendingMsg;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //for icon
            ClipOval(
              child: Container(
                height: 40,
                width: 40,
                color: MyColors.myRandomColor(),
                alignment: Alignment.center,
                child: Text(
                  pendingMsg.name.toString().substring(0, 1),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            //end icon
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pendingMsg.name.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    pendingMsg.phones.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    pendingMsg.message.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            Text(
              formatDate(pendingMsg.scheduledAt.toString()),
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 9,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}