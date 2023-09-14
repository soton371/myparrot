import 'package:flutter/material.dart';
import 'package:myparrot/screens/summary/components/pending_view.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
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
              Center(
                child: Text("Delivery"),
              ),
              Center(
                child: Text("Failed"),
              ),
            ],
          ),
        ));
  }
}
