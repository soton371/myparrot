import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: Scaffold(
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
            Center(
              child: Text("Pending"),
            ),
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
