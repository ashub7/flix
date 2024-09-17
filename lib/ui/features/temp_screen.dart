import 'package:flex_list/flex_list.dart';
import 'package:flutter/material.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  final List<String> list = [];

  @override
  void initState() {
    super.initState();
    list.add("value");
    for (int i = 0; i < 10; i++) {
      list.add("value range $i");
    }
    list.add("value not in the");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wrap Example')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 5,
          runSpacing: 10,
          children: list.map((label) => _labelView(label)).toList(),
        ),
      ),
    );
  }

  Widget _labelView(String label) {
    return Expanded(
      child: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(8),
        child: Text(label),
      ),
    );
  }
}
