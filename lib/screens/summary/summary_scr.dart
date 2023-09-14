import 'package:flutter/material.dart';
import 'package:myparrot/screens/summary/components/delivery/delivery_view.dart';
import 'package:myparrot/screens/summary/components/failed/failed_view.dart';
import 'package:myparrot/screens/summary/components/pending/pending_view.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Summary"),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Pending",
                ),
                Tab(
                  text: "Delivery",
                ),
                Tab(
                  text: "Failed",
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              PendingView(),
              DeliveryView(),
              FailedView(),
            ],
          ),
        ));
  }
}
