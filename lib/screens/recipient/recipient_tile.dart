import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/recipient_mod.dart';
import 'package:myparrot/screens/message/message_screen.dart';

class RecipientTile extends StatelessWidget {
  const RecipientTile({super.key, required this.recipient});
  final RecipientModel recipient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_)=> MessageScreen(name: recipient.name, number: recipient.number))),
      child: Card(
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              //for icon
              ClipOval(
                child: Container(
                  height: 45,
                  width: 45,
                  color: MyColors.myRandomColor(),
                  alignment: Alignment.center,
                  child: Text(
                    recipient.name.substring(0, 1),
                    style: const TextStyle(fontSize: 21, color: Colors.white),
                  ),
                ),
              ),
              //end icon
              const SizedBox(
                width: 10,
              ),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipient.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                    ),
                  ),
                  Text(
                    recipient.number,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: MyColors.disable),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
