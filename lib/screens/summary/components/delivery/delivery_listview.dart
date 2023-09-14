import 'package:flutter/material.dart';
import 'package:myparrot/models/pending_msg_mod.dart';
import 'package:myparrot/screens/summary/components/delivery/delivery_list_tile.dart';

class DeliveryListView extends StatelessWidget {
  const DeliveryListView({super.key, required this.deliveryMsgs});
  final List<Datum> deliveryMsgs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: deliveryMsgs.length,
        itemBuilder: (context, index) {
          final data = deliveryMsgs[index];
          return DeliveryListTile(deliveryMsg: data);
        });
  }
}