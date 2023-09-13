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
          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.person_add,color: MyColors.seed,))
        ],
      ),
        body: const Text("Recipient List"));
  }
}