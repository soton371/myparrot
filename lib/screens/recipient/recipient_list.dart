import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/recipient_mod.dart';
import 'package:myparrot/widgets/recipient_tile.dart';

class RecipientListView extends StatelessWidget {
  const RecipientListView({super.key, required this.recipients});
  final List<RecipientModel> recipients;

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
          itemCount: recipients.length,
          itemBuilder: (context, index) {
            final data = recipients[index];
            return RecipientTile(recipient: data,);
          }),
    );
  }
}
