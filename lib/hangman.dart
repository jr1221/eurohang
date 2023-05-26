import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HangmanScreen extends StatefulWidget {
  const HangmanScreen({Key? key, required this.questionId}) : super(key: key);

  final int questionId;

  @override
  State<HangmanScreen> createState() => _HangmanScreenState();
}

class _HangmanScreenState extends State<HangmanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Eurohang'),
          centerTitle: true,
        ),
        body: ListView(children: [
          Text(widget.questionId.toString()),
          ElevatedButton(
              onPressed: () => context.pop(false), child: const Text('Return'))
        ]));
  }
}
