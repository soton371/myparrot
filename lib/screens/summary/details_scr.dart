import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/pending_msg_mod.dart';
import 'package:myparrot/utilities/format_date.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.myMessage});
  final Datum myMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.pen,
                color: MyColors.seed,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.trash,
                color: MyColors.seed,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //for icon
                  ClipOval(
                    child: Container(
                      height: 50,
                      width: 50,
                      color: MyColors.myRandomColor(),
                      alignment: Alignment.center,
                      child: Text(
                        myMessage.name.toString().substring(0, 1),
                        style:
                            const TextStyle(fontSize: 25, color: Colors.white),
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
                          myMessage.name.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          myMessage.phones.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatDate(myMessage.scheduledAt.toString()),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                myMessage.message.toString(),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
