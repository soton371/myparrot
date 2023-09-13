import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/recipient_mod.dart';

class RecipientTile extends StatelessWidget {
  const RecipientTile({super.key, required this.recipient});
  final RecipientModel recipient;

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
                  recipient.name.substring(0, 1),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
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
                    fontWeight: FontWeight.bold,
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
    );
  }
}
