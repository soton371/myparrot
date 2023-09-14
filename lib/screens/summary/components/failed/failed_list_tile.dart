import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/pending_msg_mod.dart';
import 'package:myparrot/screens/summary/details_scr.dart';
import 'package:myparrot/utilities/format_date.dart';

class FailedListTile extends StatelessWidget {
  const FailedListTile({super.key, required this.failedMsg});
  final Datum failedMsg;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_)=> DetailsScreen(myMessage: failedMsg))),
      child: Card(
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //for icon
              ClipOval(
                child: Container(
                  height: 45,
                  width: 45,
                  color: MyColors.myRandomColor(),
                  alignment: Alignment.center,
                  child: Text(
                    failedMsg.name.toString().substring(0, 1),
                    style: const TextStyle(fontSize: 21, color: Colors.white),
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
                      failedMsg.name.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    Text(
                      failedMsg.phones.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    Text(
                      failedMsg.message.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
              Text(
                formatDate(failedMsg.scheduledAt.toString()),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 9,fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}