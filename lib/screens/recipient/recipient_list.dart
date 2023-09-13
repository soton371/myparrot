import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_colors.dart';

class RecipientListView extends StatelessWidget {
  const RecipientListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipient"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.person_add,
                color: MyColors.seed,
              ))
        ],
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
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
                          "$index",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
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
                          'Recipient $index',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '0151860639$index',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: MyColors.disable
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
